"use strict";

const Path = require("path");
const Fs = require("fs");

const createRequireFromPath = require("./create-require");

const cache = new Map();

function requireAt(dir, request) {
  const makeIt = (xdir, checked) => {
    let xRequire = requireAt.cache && requireAt.cache.get(xdir);

    if (!xRequire) {
      let stat;
      try {
        stat = Fs.statSync(xdir);
      } catch (e) {
        throw new Error(`require-at: stat '${xdir}' failed: ${e.message}`);
      }

      if (!stat || !stat.isDirectory()) {
        if (checked) throw new Error(`require-at: not a directory: '${dir}'`);
        return makeIt(Path.dirname(xdir), true);
      }

      xRequire = createRequireFromPath(Path.join(xdir, "._require-at_"), xdir);

      requireAt.cache && requireAt.cache.set(xdir, xRequire);
    }

    return request ? xRequire(request) : xRequire;
  };

  return makeIt(Path.resolve(dir), false);
}

requireAt.cache = cache;

module.exports = requireAt;
