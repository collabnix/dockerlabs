/// <reference types="node" />
/**
 * function to log in case require module was not found
 *
 * @params message - message to log
 * @params path - path of the module that user tried to require
 */
export declare type LogFunction = (message: string, path: string) => void;
/**
 * Options for calling optionalRequire
 */
export declare type OptionalRequireOpts = {
    /**
     * `notFound` is a function. If error from require was `MODULE_NOT_FOUND`, then:
     *
     * - call `notFound` if it's provided
     * - else return the `default` value.
     *
     * @remark in case the error was not `MODULE_NOT_FOUND`, will instead call the `fail` function
     * if it's provided.
     *
     * @param err - the error from require
     */
    notFound?: (err: Error) => unknown;
    /**
     * `fail` is a function. If error from require was something other than `MODULE_NOT_FOUND`,
     * for example, the module contains syntax error, then:
     *
     * - call `fail` if it's provided
     * - else rethrow the error
     *
     * @remark This is a separate callback from `notFound` so user can handle
     * real `MODULE_NOT_FOUND` exception separately, or let the `default` be returned.
     *
     * @param err - the error from require
     */
    fail?: (err: Error) => unknown;
    /**
     * The value to return if error was `MODULE_NOT_FOUND` but `notFound` is not provided.
     */
    default?: unknown;
    /**
     * Tell optional require to log a message if the module is not found.
     * - note: it doesn't log if the error is not due to the module not found
     *
     * This field can have these values:
     * 1. `true` - log with default message
     * 2. string - a string to prepend to the message being logged
     *
     * @remarks to further customize logging, set the `log` function.
     */
    message?: true | string;
    /**
     * function to log the module not found message, default log function uses `console.log`
     */
    log?: LogFunction;
    /**
     * `require` is the node.js require function from caller's context.
     *
     * If not provided, then use the one received when creating the optional require function
     */
    require?: NodeRequire;
    /**
     * If `true`, then do an optional `require.resolve` and return the full path
     */
    resolve?: boolean;
};
export declare function setDefaultLog(log: LogFunction): void;
/**
 * try to require a module with optional handling in case it's not found or fail to require
 *
 * @param callerRequire - `require` from caller context
 * @param path - path to module to require
 * @param optsOrMsg - options or message to log in case of exceptions
 * @returns require result
 */
export declare function tryRequire(callerRequire: NodeRequire, path: string, optsOrMsg?: OptionalRequireOpts | string | true): unknown;
/**
 * try to resolve a module with optional handling in case it's not found or fail to require
 *
 * @param callerRequire - `require` from caller context
 * @param path - path to module to require
 * @param optsOrMsg - options or message to log in case of exceptions
 * @returns resolve result
 */
export declare function tryResolve(callerRequire: NodeRequire, path: string, optsOrMsg?: OptionalRequireOpts | string | true): string;
/**
 * function to require a module with optional handling in case it's not found or fail to require
 */
export declare type OptionalRequireFunction<T = any> = {
    /**
     * @param path - path to module to require
     * @param optsOrMsg - options or message to log when module not found
     */
    (path: string, optsOrMsg?: OptionalRequireOpts | string | true): T;
    /**
     * resolve the module's full path
     *
     * @param path - path to module to resolve
     * @param optsOrMsg - options or message to log when module not found
     * @returns resolve result
     */
    resolve: (path: string, opsOrMsg?: OptionalRequireOpts | string | true) => string;
    /**
     * function to log message, default to use `console.log`, you can replace this with
     * another function.
     */
    log: LogFunction;
};
/**
 * Make an optional require function, using the `require` from caller's context.
 *
 * @param callerRequire - `require` from caller's context
 * @param log - function to log if module is not found
 * @returns required module
 */
export declare function makeOptionalRequire<T = any>(callerRequire: NodeRequire, log?: (message: string, path: string) => void): OptionalRequireFunction<T>;
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
export declare const optionalRequire: OptionalRequireFunction<any>;
/**
 * An optionalRequire function using `require` from CWD context
 *
 * @remarks because `require` is from CWD context, if you do `optionalRequireCwd("./my-module")`
 * then it will look for `my-module` in CWD.
 *
 * @remarks You can still override the `require` using `options.require` with the one from your
 * calling context.
 */
export declare const optionalRequireCwd: OptionalRequireFunction<any>;
