#!/usr/bin/env node
/**
 * Some legacy filenames contain characters ('#', spaces, ...) that Docusaurus
 * can't turn into a valid slug. Inject an explicit sanitized `slug:` for those
 * files so the build succeeds while keeping a sensible, stable URL.
 */
import fs from 'node:fs';
import path from 'node:path';

const DOCS = path.join(process.cwd(), 'docs');
const BAD = /[#?%!()\[\] ]/;

const sanitize = (seg) =>
  seg
    .replace(/[#?%!()\[\]]/g, '')
    .replace(/\s+/g, '-')
    .replace(/-+/g, '-')
    .replace(/^-|-$/g, '');

let fixed = 0;

function walk(dir) {
  for (const e of fs.readdirSync(dir, {withFileTypes: true})) {
    const abs = path.join(dir, e.name);
    if (e.isDirectory()) {
      walk(abs);
      continue;
    }
    if (!e.name.endsWith('.md')) continue;
    const rel = path.relative(DOCS, abs);
    if (!BAD.test(rel)) continue;

    const slug =
      '/' +
      rel
        .replace(/\.md$/, '')
        .split('/')
        .map(sanitize)
        .join('/');

    let text = fs.readFileSync(abs, 'utf8');
    const fmMatch = text.match(/^---\r?\n([\s\S]*?)\r?\n---\r?\n/);
    if (fmMatch) {
      if (/^slug:/m.test(fmMatch[1])) continue; // already set
      text = text.replace(/^---\r?\n/, `---\nslug: ${JSON.stringify(slug)}\n`);
    } else {
      text = `---\nslug: ${JSON.stringify(slug)}\n---\n\n${text}`;
    }
    fs.writeFileSync(abs, text);
    fixed++;
  }
}

walk(DOCS);
console.log(`✓ Injected explicit slugs into ${fixed} files with unsafe names`);
