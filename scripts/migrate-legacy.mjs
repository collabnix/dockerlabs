#!/usr/bin/env node
/**
 * Migrates the legacy Jekyll lab content into the Docusaurus `docs/` tree.
 *
 *  - Moves each legacy content directory into `docs/<dir>/` so the original URL
 *    path is preserved (with routeBasePath '/', `docs/beginners/x.md` -> `/beginners/x`).
 *  - Renames `.markdown` -> `.md` so Docusaurus picks the pages up.
 *  - Adds a `title:` front matter ONLY to files that have neither front matter
 *    nor an H1 (so we never create duplicate headings).
 *  - Copies the shared top-level `images/` into `static/images/`.
 *
 * Idempotent-ish: skips dirs already moved. Safe to run once on a clean branch.
 */
import fs from 'node:fs';
import path from 'node:path';

const ROOT = process.cwd();
const DOCS = path.join(ROOT, 'docs');

// Legacy lab content worth preserving for SEO. (Excludes _site build output,
// vendor gems, _layouts, assets, and the already-Docusaurus docs/.)
const LEGACY_DIRS = [
  'beginners', 'intermediate', 'advanced', 'kubernetes', 'networking',
  'security', 'workshop', 'solution', 'play-with-docker', 'play-with-kubernetes',
  'portal', 'os', 'docker', 'dockerhub', 'dockerlabs', 'desktop', 'cheatsheet',
  'cloud', 'cookbook', 'interview', 'readings', 'template', 'troubleshooting',
  'presentation',
];

const humanize = (name) =>
  name.replace(/\.md$/, '').replace(/[-_]+/g, ' ').replace(/\s+/g, ' ').trim()
    .replace(/\b\w/g, (c) => c.toUpperCase());

/** True if the file already has YAML front matter at the very top. */
function hasFrontMatter(text) {
  return /^---\r?\n[\s\S]*?\r?\n---\r?\n/.test(text);
}

/** True if there is a Markdown H1 (`# ...`) anywhere before front matter would matter. */
function hasH1(text) {
  return /^#\s+\S/m.test(text);
}

let moved = 0, renamed = 0, titled = 0, skipped = 0;

function processMarkdown(file) {
  let text = fs.readFileSync(file, 'utf8');
  if (hasFrontMatter(text) || hasH1(text)) return; // Docusaurus derives the title
  const title = humanize(path.basename(file));
  fs.writeFileSync(file, `---\ntitle: ${JSON.stringify(title)}\n---\n\n${text}`);
  titled++;
}

function walkAndFix(dir) {
  for (const entry of fs.readdirSync(dir, {withFileTypes: true})) {
    const abs = path.join(dir, entry.name);
    if (entry.isDirectory()) {
      walkAndFix(abs);
      continue;
    }
    if (entry.name.endsWith('.markdown')) {
      const md = abs.replace(/\.markdown$/, '.md');
      fs.renameSync(abs, md);
      renamed++;
      processMarkdown(md);
    } else if (entry.name.endsWith('.md')) {
      processMarkdown(abs);
    }
  }
}

for (const dir of LEGACY_DIRS) {
  const src = path.join(ROOT, dir);
  const dest = path.join(DOCS, dir);
  if (!fs.existsSync(src)) {
    skipped++;
    continue;
  }
  if (fs.existsSync(dest)) {
    console.warn(`! ${dest} already exists — skipping ${dir}`);
    skipped++;
    continue;
  }
  fs.mkdirSync(DOCS, {recursive: true});
  fs.renameSync(src, dest);
  moved++;
  walkAndFix(dest);
}

// Shared images referenced as /images/... — expose them via static/.
const imgSrc = path.join(ROOT, 'images');
const imgDest = path.join(ROOT, 'static', 'images');
if (fs.existsSync(imgSrc) && !fs.existsSync(imgDest)) {
  fs.mkdirSync(path.dirname(imgDest), {recursive: true});
  fs.cpSync(imgSrc, imgDest, {recursive: true});
  console.log('✓ Copied images/ -> static/images/');
}

console.log(`✓ Moved ${moved} legacy dirs into docs/`);
console.log(`✓ Renamed ${renamed} .markdown -> .md`);
console.log(`✓ Added titles to ${titled} untitled files`);
console.log(`  (${skipped} dirs skipped — missing or already migrated)`);
