"use strict";

const Module = require("module");
// use eval to avoid tripping bundlers
const xrequire = eval("require");

const createRequireFromPath =
  Module.createRequire ||
  Module.createRequireFromPath ||
  ((filename, dir) => {
    // https://github.com/nodejs/node/blob/1ae0511b942c01c6e0adff98643d350a395bf101/lib/internal/modules/cjs/loader.js#L748
    // https://github.com/nodejs/node/blob/1ae0511b942c01c6e0adff98643d350a395bf101/lib/internal/modules/cjs/helpers.js#L16
    const m = new Module(filename);

    m.filename = filename;
    m.paths = Module._nodeModulePaths(dir);

    // don't name this require to avoid tripping bundlers
    function _require(request) {
      // can't use m.require because there's an internal requireDepth thing
      // in the native Module implementation
      return xrequire(resolve(request));
    }

    function resolve(request, options) {
      return Module._resolveFilename(request, m, false, options);
    }

    _require.resolve = resolve;

    function paths(request) {
      return Module._resolveLookupPaths(request, m, true);
    }

    resolve.paths = paths;
    _require.main = process.mainModule;
    _require.extensions = Module._extensions;
    _require.cache = Module._cache;

    return _require;
  });

module.exports = createRequireFromPath;
