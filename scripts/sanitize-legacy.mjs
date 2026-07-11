#!/usr/bin/env node
/**
 * Makes the migrated legacy Markdown build-clean under Docusaurus/MDX:
 *   1. Removes image references whose local target does not exist (Docusaurus
 *      treats a missing referenced image as a fatal error). Remote (http) and
 *      resolvable local images are left untouched.
 *   2. Strips empty-URL links `[text]()` -> `text` ("link URL is mandatory").
 *
 * Skips docs/docker-workshop (already clean). Prints what it changed.
 */
import fs from 'node:fs';
import path from 'node:path';

const ROOT = process.cwd();
const DOCS = path.join(ROOT, 'docs');
const STATIC = path.join(ROOT, 'static');
const SKIP = path.join(DOCS, 'docker-workshop');

let imagesRemoved = 0;
let linksFixed = 0;
let filesTouched = 0;

/** Resolve an image target to an on-disk path; return null if it clearly exists. */
function isBrokenImage(target, fileDir) {
  let url = target.trim().replace(/^<|>$/g, '');
  // Drop an optional "title" and any query/anchor.
  url = url.split(/\s+/)[0].split('#')[0].split('?')[0];
  if (!url) return true;
  if (/^(https?:|data:|mailto:|\/\/)/i.test(url)) return false; // remote — fine
  url = decodeURIComponent(url);
  const candidate = url.startsWith('/')
    ? path.join(STATIC, url)
    : path.resolve(fileDir, url);
  return !fs.existsSync(candidate);
}

function sanitize(file) {
  const dir = path.dirname(file);
  let text = fs.readFileSync(file, 'utf8');
  const before = text;
  let localImg = 0;
  let localLink = 0;

  // 1. Remove broken images:  ![alt](target)
  text = text.replace(/!\[([^\]]*)\]\(([^)]*)\)/g, (m, _alt, target) => {
    if (isBrokenImage(target, dir)) {
      localImg++;
      return '';
    }
    return m;
  });

  // 2. Fix empty-URL links:  [text]()  ->  text
  text = text.replace(/\[([^\]]*)\]\(\s*(?:<>)?\s*\)/g, (_m, label) => {
    localLink++;
    return label;
  });

  if (text !== before) {
    fs.writeFileSync(file, text);
    filesTouched++;
    imagesRemoved += localImg;
    linksFixed += localLink;
  }
}

function walk(dir) {
  for (const e of fs.readdirSync(dir, {withFileTypes: true})) {
    const abs = path.join(dir, e.name);
    if (abs === SKIP) continue;
    if (e.isDirectory()) walk(abs);
    else if (e.name.endsWith('.md')) sanitize(abs);
  }
}

walk(DOCS);
console.log(`✓ Sanitized ${filesTouched} files`);
console.log(`  Removed ${imagesRemoved} broken image refs, fixed ${linksFixed} empty links`);
