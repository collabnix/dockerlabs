"use strict";
var __assign = (this && this.__assign) || function () {
    __assign = Object.assign || function(t) {
        for (var s, i = 1, n = arguments.length; i < n; i++) {
            s = arguments[i];
            for (var p in s) if (Object.prototype.hasOwnProperty.call(s, p))
                t[p] = s[p];
        }
        return t;
    };
    return __assign.apply(this, arguments);
};
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
exports.optionalRequireCwd = exports.optionalRequire = exports.makeOptionalRequire = exports.tryResolve = exports.tryRequire = exports.setDefaultLog = void 0;
var assert_1 = __importDefault(require("assert"));
var require_at_1 = __importDefault(require("require-at"));
/* eslint-disable max-params, complexity, no-eval */
// `require` from this module's context
// Using `eval` to avoid tripping bundlers like webpack
var xrequire = eval("require");
// Copied from https://github.com/yarnpkg/berry/blob/d5454007c9c76becfa97b36a92de299a3694afd5/packages/yarnpkg-pnp/sources/loader/makeApi.ts#L27
// Splits a require request into its components, or return null if the request is a file path
var pnpDependencyNameRegExp = /^(?![a-zA-Z]:[\\/]|\\\\|\.{0,2}(?:\/|$))((?:node:)?(?:@[^/]+\/)?[^/]+)\/*(.*|)$/;
/**
 * Change a module name request into a Yarn Berry PnP dependency name,
 * since the dependency name is what will be included in the error message.
 * For example, `optionalRequire('my-package/package.json')` will print a message like
 * `Your application tried to access my-package,` without the `/package.json` at the end of it.
 * This function grabs the dependency name only, or returns `null` if it can't find it.
 * @param {string} name Requested name
 * @returns {string} Dependency name
 */
function getPnpDependencyName(name) {
    var dependencyNameMatch = name.match(pnpDependencyNameRegExp);
    if (!dependencyNameMatch)
        return null;
    return dependencyNameMatch[1];
}
/**
 * Check if an error from require is really due to the module not found,
 * and not because the module itself trying to require another module
 * that's not found.
 *
 * @param err - the error
 * @param name - name of the module being required
 * @returns true or false
 */
function findModuleNotFound(err, name) {
    // Check the first line of the error message
    var msg = err.message.split("\n")[0];
    /* istanbul ignore if */
    if (!msg) {
        return false;
    }
    // Check for "Cannot find module 'foo'"
    if (msg.includes("'" + name + "'")) {
        return true;
    }
    var pnpDependencyName = getPnpDependencyName(name);
    if (pnpDependencyName) {
        return (
        // Check for "Your application tried to access foo (a peer dependency) ..." (Yarn Berry PnP)
        // https://github.com/yarnpkg/berry/blob/e81dc0d29bb2f41818d9c5c1c74bab1406fb979b/packages/yarnpkg-pnp/sources/loader/makeApi.ts#L680
        msg.includes(" " + pnpDependencyName + " ") ||
            // Check for "Your application tried to access foo. While ..." (Yarn Berry PnP)
            // https://github.com/yarnpkg/berry/blob/e81dc0d29bb2f41818d9c5c1c74bab1406fb979b/packages/yarnpkg-pnp/sources/loader/makeApi.ts#L704
            msg.includes(" " + pnpDependencyName + ". ") ||
            // Check for "Your application tried to access foo, but ..." (Yarn Berry PnP)
            // https://github.com/yarnpkg/berry/blob/e81dc0d29bb2f41818d9c5c1c74bab1406fb979b/packages/yarnpkg-pnp/sources/loader/makeApi.ts#L718
            msg.includes(" " + pnpDependencyName + ", "));
    }
    return false;
}
/**
 * Default log function
 *
 * @param message - message to log
 * @param path - path of the module to require
 */
function defaultLog(message, path) {
    console.log("Just FYI: " + message + "; Path \"" + path + "\"");
}
var __defaultLog = defaultLog;
function setDefaultLog(log) {
    __defaultLog = log;
}
exports.setDefaultLog = setDefaultLog;
function _getOptions(optsOrMsg, requireFunction, log) {
    if (requireFunction === void 0) { requireFunction = xrequire; }
    if (typeof optsOrMsg === "object") {
        var opts = __assign({ require: requireFunction, log: log }, optsOrMsg);
        (0, assert_1.default)(!(opts.hasOwnProperty("notFound") && opts.hasOwnProperty("default")), "optionalRequire: options set with both `notFound` and `default`");
        return opts;
    }
    else {
        return { require: requireFunction, log: log, message: optsOrMsg };
    }
}
/**
 * Internal optional require implementation
 *
 * @param path - path to module to require
 * @param optsOrMsg - options or message to log in case module not found
 * @returns require or resolve result
 */
function _optionalRequire(path, opts) {
    try {
        return opts.resolve ? opts.require.resolve(path) : opts.require(path);
    }
    catch (e) {
        // exception that's not due to the module itself not found
        if (e.code !== "MODULE_NOT_FOUND" || !findModuleNotFound(e, path)) {
            // if the module we are requiring fail because it try to require a
            // module that's not found, then we have to report this as failed.
            if (typeof opts.fail === "function") {
                return opts.fail(e);
            }
            throw e;
        }
        if (opts.message) {
            var message = opts.message === true ? "" : opts.message + " - ";
            var r = opts.resolve ? "resolved" : "found";
            opts.log(message + "optional module not " + r, path);
        }
        if (typeof opts.notFound === "function") {
            return opts.notFound(e);
        }
        return opts.default;
    }
}
/**
 * try to require a module with optional handling in case it's not found or fail to require
 *
 * @param callerRequire - `require` from caller context
 * @param path - path to module to require
 * @param optsOrMsg - options or message to log in case of exceptions
 * @returns require result
 */
function tryRequire(callerRequire, path, optsOrMsg) {
    var opts = _getOptions(optsOrMsg, callerRequire, __defaultLog);
    opts.resolve = false;
    return _optionalRequire(path, opts);
}
exports.tryRequire = tryRequire;
/**
 * try to resolve a module with optional handling in case it's not found or fail to require
 *
 * @param callerRequire - `require` from caller context
 * @param path - path to module to require
 * @param optsOrMsg - options or message to log in case of exceptions
 * @returns resolve result
 */
function tryResolve(callerRequire, path, optsOrMsg) {
    var opts = _getOptions(optsOrMsg, callerRequire, __defaultLog);
    opts.resolve = true;
    return _optionalRequire(path, opts);
}
exports.tryResolve = tryResolve;
/**
 * Make an optional require function, using the `require` from caller's context.
 *
 * @param callerRequire - `require` from caller's context
 * @param log - function to log if module is not found
 * @returns required module
 */
function makeOptionalRequire(callerRequire, log) {
    var x = function (path, optsOrMsg) {
        var opts = _getOptions(optsOrMsg, callerRequire, x.log);
        return _optionalRequire(path, opts);
    };
    x.resolve = function (path, optsOrMsg) {
        var opts = _getOptions(optsOrMsg, callerRequire, x.log);
        opts.resolve = true;
        return _optionalRequire(path, opts);
    };
    x.log = log || __defaultLog;
    return x;
}
exports.makeOptionalRequire = makeOptionalRequire;
/**
 * A default optionalRequire function using `require` from optional-require's context.
 *
 * @remarks because `require` is from optional-require's context, you won't be able to
 * do `optionalRequire("./my-module")`.
 *
 * You can still override the `require` using `options.require` with the one from your
 * calling context.
 *
 */
exports.optionalRequire = makeOptionalRequire(xrequire);
/**
 * An optionalRequire function using `require` from CWD context
 *
 * @remarks because `require` is from CWD context, if you do `optionalRequireCwd("./my-module")`
 * then it will look for `my-module` in CWD.
 *
 * @remarks You can still override the `require` using `options.require` with the one from your
 * calling context.
 */
exports.optionalRequireCwd = makeOptionalRequire((0, require_at_1.default)(process.cwd()));
//# sourceMappingURL=index.js.map