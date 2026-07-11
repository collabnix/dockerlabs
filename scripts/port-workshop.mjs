#!/usr/bin/env node
/**
 * Ports the modern docker-workshop (MkDocs Material) content into the
 * Docusaurus `docs/docker-workshop/` tree and generates a curated sidebar
 * (`sidebars.workshop.json`) that mirrors the upstream mkdocs nav.
 *
 * Usage: node scripts/port-workshop.mjs [/path/to/docker-workshop]
 */
import fs from 'node:fs';
import path from 'node:path';

const SRC = process.argv[2] || '/tmp/docker-workshop';
const SRC_DOCS = path.join(SRC, 'docs');
const ROOT = process.cwd();
const OUT = path.join(ROOT, 'docs', 'docker-workshop');

if (!fs.existsSync(SRC_DOCS)) {
  console.error(`✗ Source not found: ${SRC_DOCS}\n  Clone it first: git clone https://github.com/ajeetraina/docker-workshop ${SRC}`);
  process.exit(1);
}

// ---------------------------------------------------------------------------
// MkDocs -> Docusaurus conversion
// ---------------------------------------------------------------------------
const ADM_MAP = {
  note: 'note', info: 'info', tip: 'tip', success: 'tip', question: 'info',
  help: 'info', hint: 'tip', warning: 'warning', caution: 'warning',
  attention: 'warning', danger: 'danger', error: 'danger', bug: 'danger',
  failure: 'danger', example: 'info', abstract: 'info', summary: 'info',
  quote: 'note', important: 'warning',
};

/** Recursively convert `!!!`/`???` admonitions and `=== "tab"` blocks. */
function convertBlocks(src) {
  const lines = src.split('\n');
  const out = [];
  let i = 0;
  while (i < lines.length) {
    const line = lines[i];
    const adm = line.match(/^(\s*)(?:!!!|\?\?\?\+?)\s+([a-zA-Z-]+)(?:\s+"([^"]*)")?\s*$/);
    const tab = line.match(/^(\s*)===\s+"?([^"]+?)"?\s*$/);

    if (adm) {
      const type = ADM_MAP[adm[2].toLowerCase()] || 'note';
      const title = adm[3];
      i++;
      const body = [];
      while (i < lines.length && (lines[i].trim() === '' || /^ {4}/.test(lines[i]))) {
        body.push(lines[i].trim() === '' ? '' : lines[i].replace(/^ {4}/, ''));
        i++;
      }
      while (body.length && body[body.length - 1] === '') body.pop();
      out.push(`:::${type}${title ? `[${title}]` : ''}`);
      out.push(convertBlocks(body.join('\n')));
      out.push(':::', '');
      continue;
    }

    if (tab) {
      const title = tab[2];
      i++;
      const body = [];
      while (i < lines.length && (lines[i].trim() === '' || /^ {4}/.test(lines[i]))) {
        body.push(lines[i].trim() === '' ? '' : lines[i].replace(/^ {4}/, ''));
        i++;
      }
      while (body.length && body[body.length - 1] === '') body.pop();
      out.push(`**${title}**`, '');
      out.push(convertBlocks(body.join('\n')), '');
      continue;
    }

    out.push(line);
    i++;
  }
  return out.join('\n');
}

const GH_TREE = 'https://github.com/ajeetraina/docker-workshop/tree/main/docs';

/**
 * Rewrite relative Markdown links (NOT images) so they don't 404 under
 * Docusaurus:
 *   - links to another workshop doc  ->  absolute `/docker-workshop/<path>`
 *   - links to source code / dirs that aren't docs -> the GitHub source repo
 * `rel` is the file's path relative to the source docs dir.
 */
function rewriteLinks(text, rel) {
  const fileDir = path.posix.dirname(rel.split(path.sep).join('/'));
  return text.replace(/(?<!!)\]\(([^)\s]+)((?:\s+"[^"]*")?)\)/g, (m, target, title) => {
    let t = target.trim();
    if (/^(https?:|#|mailto:|tel:|\/)/i.test(t)) return m; // external / anchor / already-absolute
    let anchor = '';
    const h = t.indexOf('#');
    if (h !== -1) {
      anchor = t.slice(h);
      t = t.slice(0, h);
    }
    if (!t) return m;
    const p = t.replace(/\/$/, '').replace(/\.md$/, '');
    const base = fileDir === '.' ? '' : fileDir;
    let candidate = path.posix.normalize(path.posix.join(base, p)).replace(/^\.\//, '');
    const asFile = fs.existsSync(path.join(SRC_DOCS, candidate + '.md'));
    const asIndex = fs.existsSync(path.join(SRC_DOCS, candidate, 'index.md'));
    if (!asFile && !asIndex) {
      return `](${GH_TREE}/${candidate}${anchor}${title})`; // not a doc -> source repo
    }
    // Docusaurus folder-index convention: `index.md`, `README.md`, or a file
    // named after its folder routes to the folder path (duplicate dropped).
    let routePath = candidate;
    if (asFile) {
      const parts = candidate.split('/');
      const b = parts[parts.length - 1];
      const parent = parts[parts.length - 2];
      if (b === 'index' || b === 'README' || b === parent) {
        routePath = parts.slice(0, -1).join('/');
      }
    }
    const url = routePath ? `/docker-workshop/${routePath}` : '/docker-workshop';
    return `](${url}${anchor}${title})`;
  });
}

function convertFile(raw, rel) {
  let text = raw.replace(/\r\n/g, '\n');
  // Pull the first H1 into the front-matter title, then drop it.
  let title = null;
  const m = text.match(/^#\s+(.+?)\s*$/m);
  if (m) {
    title = m[1].replace(/[#*`]/g, '').trim();
    text = text.replace(m[0], '').replace(/^\n+/, '');
  }
  text = convertBlocks(text);
  text = rewriteLinks(text, rel);
  const fm = ['---', `title: ${JSON.stringify(title || 'Untitled')}`, '---', '', ''].join('\n');
  return fm + text;
}

// ---------------------------------------------------------------------------
// Walk the source docs, converting .md and copying assets.
// ---------------------------------------------------------------------------
const copiedIds = new Set();
let mdCount = 0;
let assetCount = 0;

function walk(dir) {
  for (const entry of fs.readdirSync(dir, {withFileTypes: true})) {
    const abs = path.join(dir, entry.name);
    const rel = path.relative(SRC_DOCS, abs);
    // Skip dotfiles/dot-dirs (.claude, .git, ...), editor cruft, node_modules —
    // BEFORE recursing, otherwise their contents leak into docs/.
    if (entry.name.startsWith('.') || entry.name === 'node_modules') continue;
    if (/\.(swp|orig)$/.test(entry.name)) continue;
    if (entry.isDirectory()) {
      walk(abs);
      continue;
    }
    // Skip the workshop's own global CSS (we have our own theme).
    if (rel.startsWith('css/')) continue;

    const dest = path.join(OUT, rel);
    fs.mkdirSync(path.dirname(dest), {recursive: true});

    if (entry.name.endsWith('.md')) {
      fs.writeFileSync(dest, convertFile(fs.readFileSync(abs, 'utf8'), rel));
      copiedIds.add('docker-workshop/' + rel.replace(/\.md$/, ''));
      mdCount++;
    } else {
      fs.copyFileSync(abs, dest);
      assetCount++;
    }
  }
}

fs.rmSync(OUT, {recursive: true, force: true});
fs.mkdirSync(OUT, {recursive: true});
walk(SRC_DOCS);

// ---------------------------------------------------------------------------
// Curated sidebar (mirrors upstream mkdocs nav). Missing files are dropped so
// the build never breaks on a stale reference.
// ---------------------------------------------------------------------------
const P = 'docker-workshop/';
const doc = (label, id) => ({type: 'doc', label, id: P + id});
const cat = (label, items) => ({type: 'category', label, collapsed: true, items});

const NAV = [
  doc('👋 Getting Started', 'index'),
  doc('Prerequisites', 'prereq/prereq'),
  cat('Docker 101', [
    cat('Inner-Loop Development Workflow', [
      doc('Inner vs Outer Loop', 'lab1/overview'),
      doc('What is a Container', 'lab1/what-is-a-container'),
      doc('Running Postgres Containers', 'lab1/postgres'),
      doc('Docker Workflow', 'lab1/docker-workflow'),
      doc('docker init', 'lab1/docker-init'),
      doc('Compose Watch', 'lab1/compose-watch'),
      doc('Best Practices', 'lab1/best-practices'),
    ]),
    cat('Product Catalog — Sample App', [
      doc('Overview', 'product-catalog/overview'),
      doc('Prerequisites', 'product-catalog/prereq'),
      doc('Tech Stack', 'product-catalog/tech-stack'),
      doc('Develop', 'product-catalog/develop'),
      doc('Test', 'product-catalog/test'),
      doc('Build', 'product-catalog/build'),
      doc('Secure', 'product-catalog/secure'),
    ]),
  ]),
  cat('Docker and AI', [
    cat('Docker Agent', [
      doc('Overview', 'lab10/overview'),
      doc('Getting Started', 'lab10/getting-started'),
      cat('Concepts', [
        doc('Autonomy', 'lab10/concept/autonomy/autonomy'),
        doc('Perception', 'lab10/concept/perception/perception'),
        doc('Reasoning', 'lab10/concept/reasoning/reasoning'),
        doc('Action', 'lab10/concept/action/action'),
        doc('Goal-Oriented', 'lab10/concept/goal/goal'),
      ]),
      cat('Tools', [
        doc('memory', 'lab10/tools/memory'),
        doc('think', 'lab10/tools/think'),
        doc('todo', 'lab10/tools/todo'),
        doc('shell', 'lab10/tools/shell'),
        doc('filesystem', 'lab10/tools/filesystem'),
        doc('environment', 'lab10/tools/environment'),
      ]),
      cat('Integration', [
        doc('Model Context Protocol', 'lab10/integration/mcp'),
        doc('Docker Model Runner', 'lab10/integration/dmr'),
        doc('RAG', 'lab10/integration/rag'),
      ]),
      cat('Projects', [
        doc('A Simple Pirate Agent', 'lab10/projects/pirate'),
        doc('Learning Agent with Alloy Models', 'lab10/projects/alloy'),
        doc('Developer Agent with Tools', 'lab10/projects/dev'),
        doc('Financial Analysis Team', 'lab10/projects/financial'),
        doc('Docker Expert Team', 'lab10/projects/docker-expert'),
        doc('Bug Investigator', 'lab10/projects/bug-investigator/bug-investigator'),
        doc('Auto-Curator Agent', 'lab10/projects/auto-curator-agent/auto-curator-agent'),
      ]),
      doc('Sharing Agents', 'lab10/sharing'),
    ]),
    cat('Docker Model Runner', [
      doc('Overview', 'lab4/overview'),
      doc('Getting Started', 'lab4/getting-started'),
      doc('Product Catalog Chatbot', 'lab4/projects/catalog-chatbot'),
      doc('GenAI Chatbot', 'lab4/projects/genai-chatbot'),
    ]),
    cat('MCP Catalog and Toolkit', [
      doc('Overview', 'lab5/overview'),
      doc('Getting Started', 'lab5/getting-started'),
      doc('Visual Chatbot', 'lab5/projects/visual-chatbot/visual-chatbot'),
      doc('Your First MCP Server', 'lab5/projects/visual-chatbot/mcp'),
      doc('GitHub MCP + Claude Desktop', 'lab5/projects/GitHub-Claude'),
      doc('Docker MCP + Gordon', 'lab5/projects/Docker-CLI-With-Gordon'),
      doc('Docker MCP + VS Code', 'lab5/projects/Docker-CLI-With-VSCode'),
      doc('GitHub MCP + Gordon', 'lab5/projects/GitHub-MCP-Gordon'),
      doc('Kubernetes MCP + Claude', 'lab5/projects/Kubernetes-MCP'),
      doc('Slack MCP + Claude', 'lab5/projects/Slack-MCP-With-Claude'),
    ]),
    cat('Agentic Compose', [
      doc('Overview', 'lab6/overview'),
      doc('Getting Started', 'lab6/getting-started'),
      cat('DevDuck', [
        doc('Overview', 'lab6/projects/devduck/overview'),
        doc('Prerequisite', 'lab6/projects/devduck/prereq'),
        doc('Getting Started', 'lab6/projects/devduck/getting-started'),
        doc('Local Agent Interaction', 'lab6/projects/devduck/local-agent'),
        doc('Cerebras Interaction', 'lab6/projects/devduck/cerebras-interaction'),
      ]),
      doc('Agentic Product Catalog', 'lab6/projects/agentic-catalog'),
      doc('Hackathon Recommender', 'lab6/projects/hackathon-recommender'),
      doc('A2A Multi-Agent Fact Checker', 'lab6/projects/a2a-multi-agent-fact-checker'),
    ]),
    cat('Docker Sandboxes', [
      doc('Overview', 'lab8/overview'),
      doc('Getting Started', 'lab8/getting-started'),
      doc('Why Agents Need Governance', 'lab8/projects/why-governance'),
      doc('Your First Sandbox', 'lab8/projects/first-sandbox'),
      doc('The Isolation Proof', 'lab8/projects/isolation-proof'),
      doc('Reviewing Agent Changes', 'lab8/projects/reviewing-agent-changes'),
      doc('Secrets Without Exposure', 'lab8/projects/secrets'),
      doc('1Password Credential Injection', 'lab8/projects/1password-credentials'),
      doc('Network Policy', 'lab8/projects/network-policy'),
      doc('Branch Mode', 'lab8/projects/branch-mode'),
      doc('Parallel Agents', 'lab8/projects/parallel-agents'),
      doc('Running Open-Source Models', 'lab8/projects/local-models'),
      doc('AI Governance at Scale', 'lab8/projects/governance-summary'),
      doc('DevBoard', 'lab8/projects/devboard'),
    ]),
    cat('AI Governance', [
      doc('Setup', 'ai-governance/setup'),
      doc('Why AI Governance', 'ai-governance/introduction'),
      doc('The Policy Model', 'ai-governance/policy-model'),
      doc('Network Enforcement Demo', 'ai-governance/network-demo'),
      doc('Filesystem Enforcement Demo', 'ai-governance/filesystem-demo'),
      doc('MCP Hands-On', 'ai-governance/mcp-hands-on'),
      doc('Observability', 'ai-governance/observability'),
      doc("What's Next", 'ai-governance/whats-next'),
      cat('Sandbox Kits', [
        doc('Introduction to Kits', 'ai-governance/kits/intro'),
        doc('Your First Mixin Kit', 'ai-governance/kits/first-mixin'),
        doc('Network & Credentials', 'ai-governance/kits/network-and-creds'),
        doc('Fork an Agent Kit', 'ai-governance/kits/agent-kit'),
        doc('Stacking & Community Kits', 'ai-governance/kits/stacking-and-community'),
        doc('Summary & Next Steps', 'ai-governance/kits/summary'),
      ]),
    ]),
  ]),
  cat('Docker and Security', [
    cat('Container Security', [
      doc('Overview', 'security/container-security/overview'),
      doc('Setup', 'security/container-security/setup'),
      doc('Surface the Problem', 'security/container-security/surface-the-problem'),
      doc('BP#1: Minimal Base Images', 'security/container-security/minimal-base-images'),
      doc('BP#2: Multi-Stage Builds', 'security/container-security/multi-stage-builds'),
      doc('BP#3: Non-Root User', 'security/container-security/non-root-user'),
      doc('BP#4: Read-Only + Drop Capabilities', 'security/container-security/readonly-capabilities'),
      doc('BP#6-8: Secrets & Limiting Tools', 'security/container-security/secrets-and-tools'),
    ]),
    cat('Docker Scout (Reactive)', [
      doc('Overview', 'security/scout-reactive/overview'),
      doc('Continuous Scanning', 'security/scout-reactive/continuous-scanning'),
      doc('CI Integration', 'security/scout-reactive/ci-integration'),
      doc('Recommendations & Comparisons', 'security/scout-reactive/recommendations'),
    ]),
    cat('DHI (Pro-active)', [
      doc('Overview', 'security/dhi-proactive/overview'),
      doc('Migrate to DHI', 'security/dhi-proactive/migration'),
      doc('Attestations & Scanner Integration', 'security/dhi-proactive/attestations'),
    ]),
    cat('Docker Hardened Images', [
      doc('Overview', 'lab9/dhi/overview'),
      doc('Getting Started', 'lab9/dhi/getting-started'),
      doc('Image Scanning', 'lab9/dhi/image-scanning'),
      doc('Switch to DHI', 'lab9/dhi/switch-to-dhi'),
      doc('Compliance & Attestations', 'lab9/dhi/compliance'),
    ]),
    cat('Supply Chain with dhictl', [
      doc('Introduction & Setup', 'dhictl/introduction'),
      doc('Meet the Product Catalog', 'dhictl/product-catalog'),
      doc('Introducing Vulnerabilities', 'dhictl/introducing-vulnerabilities'),
      doc('Browsing the DHI Catalog', 'dhictl/browsing-catalog'),
      doc('Migrating to a Hardened Image', 'dhictl/migrating'),
      doc('Supply Chain & dhictl Capabilities', 'dhictl/supply-chain'),
    ]),
  ]),
  cat('Docker Offload', [
    doc('Overview', 'lab7/overview'),
    doc('Getting Started', 'lab7/getting-started'),
  ]),
  cat('Kubernetes 101', [
    doc('Introduction & Your Cluster', 'kubernetes-101/overview'),
    doc('Pods', 'kubernetes-101/pods'),
    doc('Deployments', 'kubernetes-101/deployments'),
    doc('Services', 'kubernetes-101/services'),
    doc('Scaling & Rolling Updates', 'kubernetes-101/scaling-and-updates'),
    doc('Exposing Your App with Ingress', 'kubernetes-101/ingress'),
    doc('Bonus: Compose Bridge', 'kubernetes-101/compose-bridge'),
    doc('Bonus: GenAI on Kubernetes', 'kubernetes-101/genai-on-kubernetes'),
  ]),
];

// Prune items whose backing files were not copied; drop empty categories.
let dropped = 0;
function prune(items) {
  const kept = [];
  for (const item of items) {
    if (item.type === 'doc') {
      if (copiedIds.has(item.id)) kept.push(item);
      else dropped++;
    } else if (item.type === 'category') {
      const inner = prune(item.items);
      if (inner.length) kept.push({...item, items: inner});
    }
  }
  return kept;
}
const sidebar = prune(NAV);

// Backfill titles for pages that had no H1, using their nav label (best source)
// or a humanized filename as a last resort.
const labelMap = new Map();
(function collect(items) {
  for (const item of items) {
    if (item.type === 'doc') labelMap.set(item.id, item.label.replace(/^[^\w]+\s*/, ''));
    else if (item.type === 'category') collect(item.items);
  }
})(NAV);

const humanize = (id) =>
  id.split('/').pop().replace(/[-_]+/g, ' ').replace(/\b\w/g, (c) => c.toUpperCase());

let retitled = 0;
for (const id of copiedIds) {
  const file = path.join(ROOT, 'docs', id + '.md');
  let content = fs.readFileSync(file, 'utf8');
  if (content.startsWith('---\ntitle: "Untitled"')) {
    const title = labelMap.get(id) || humanize(id);
    content = content.replace('title: "Untitled"', `title: ${JSON.stringify(title)}`);
    fs.writeFileSync(file, content);
    retitled++;
  }
}

fs.writeFileSync(
  path.join(ROOT, 'sidebars.workshop.json'),
  JSON.stringify(sidebar, null, 2) + '\n',
);

console.log(`✓ Ported ${mdCount} docs + ${assetCount} assets into docs/docker-workshop/`);
console.log(`✓ Wrote sidebars.workshop.json (${dropped} nav entries dropped as missing)`);
