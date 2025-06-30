var __create = Object.create;
var __defProp = Object.defineProperty;
var __getOwnPropDesc = Object.getOwnPropertyDescriptor;
var __getOwnPropNames = Object.getOwnPropertyNames;
var __getProtoOf = Object.getPrototypeOf;
var __hasOwnProp = Object.prototype.hasOwnProperty;
var __copyProps = (to, from, except, desc) => {
  if (from && typeof from === "object" || typeof from === "function") {
    for (let key of __getOwnPropNames(from))
      if (!__hasOwnProp.call(to, key) && key !== except)
        __defProp(to, key, { get: () => from[key], enumerable: !(desc = __getOwnPropDesc(from, key)) || desc.enumerable });
  }
  return to;
};
var __toESM = (mod, isNodeMode, target) => (target = mod != null ? __create(__getProtoOf(mod)) : {}, __copyProps(
  // If the importer is in node compatibility mode or this is not an ESM
  // file that has been converted to a CommonJS file using a Babel-
  // compatible transform (i.e. "__esModule" has not been set), then set
  // "default" to the CommonJS "module.exports" for node compatibility.
  isNodeMode || !mod || !mod.__esModule ? __defProp(target, "default", { value: mod, enumerable: true }) : target,
  mod
));

// src/index.ts
var import_node_fs = require("fs");
var import_node_path = require("path");
var import_node_url = require("url");
var import_node_module = require("module");
var import_core = require("@swc/core");

// ../common/refresh-utils.ts
var runtimePublicPath = "/@react-refresh";
var reactCompRE = /extends\s+(?:React\.)?(?:Pure)?Component/;
var refreshContentRE = /\$RefreshReg\$\(/;
var preambleCode = `import { injectIntoGlobalHook } from "__BASE__${runtimePublicPath.slice(
  1
)}";
injectIntoGlobalHook(window);
window.$RefreshReg$ = () => {};
window.$RefreshSig$ = () => (type) => type;`;
var getPreambleCode = (base) => preambleCode.replace("__BASE__", base);
var avoidSourceMapOption = Symbol();
function addRefreshWrapper(code, map, pluginName, id, reactRefreshHost = "") {
  const hasRefresh = refreshContentRE.test(code);
  const onlyReactComp = !hasRefresh && reactCompRE.test(code);
  const normalizedMap = map === avoidSourceMapOption ? null : map;
  if (!hasRefresh && !onlyReactComp) return { code, map: normalizedMap };
  const avoidSourceMap = map === avoidSourceMapOption;
  const newMap = typeof normalizedMap === "string" ? JSON.parse(normalizedMap) : normalizedMap;
  let newCode = code;
  if (hasRefresh) {
    const refreshHead = removeLineBreaksIfNeeded(
      `let prevRefreshReg;
let prevRefreshSig;

if (import.meta.hot && !inWebWorker) {
  if (!window.$RefreshReg$) {
    throw new Error(
      "${pluginName} can't detect preamble. Something is wrong."
    );
  }

  prevRefreshReg = window.$RefreshReg$;
  prevRefreshSig = window.$RefreshSig$;
  window.$RefreshReg$ = RefreshRuntime.getRefreshReg(${JSON.stringify(id)});
  window.$RefreshSig$ = RefreshRuntime.createSignatureFunctionForTransform;
}

`,
      avoidSourceMap
    );
    newCode = `${refreshHead}${newCode}

if (import.meta.hot && !inWebWorker) {
  window.$RefreshReg$ = prevRefreshReg;
  window.$RefreshSig$ = prevRefreshSig;
}
`;
    if (newMap) {
      newMap.mappings = ";".repeat(16) + newMap.mappings;
    }
  }
  const sharedHead = removeLineBreaksIfNeeded(
    `import * as RefreshRuntime from "${reactRefreshHost}${runtimePublicPath}";
const inWebWorker = typeof WorkerGlobalScope !== 'undefined' && self instanceof WorkerGlobalScope;

`,
    avoidSourceMap
  );
  newCode = `${sharedHead}${newCode}

if (import.meta.hot && !inWebWorker) {
  RefreshRuntime.__hmr_import(import.meta.url).then((currentExports) => {
    RefreshRuntime.registerExportsForReactRefresh(${JSON.stringify(
    id
  )}, currentExports);
    import.meta.hot.accept((nextExports) => {
      if (!nextExports) return;
      const invalidateMessage = RefreshRuntime.validateRefreshBoundaryAndEnqueueUpdate(${JSON.stringify(
    id
  )}, currentExports, nextExports);
      if (invalidateMessage) import.meta.hot.invalidate(invalidateMessage);
    });
  });
}
`;
  if (newMap) {
    newMap.mappings = ";;;" + newMap.mappings;
  }
  return { code: newCode, map: newMap };
}
function removeLineBreaksIfNeeded(code, enabled) {
  return enabled ? code.replace(/\n/g, "") : code;
}

// ../common/warning.ts
var silenceUseClientWarning = (userConfig) => ({
  rollupOptions: {
    onwarn(warning, defaultHandler) {
      var _a, _b;
      if (warning.code === "MODULE_LEVEL_DIRECTIVE" && (warning.message.includes("use client") || warning.message.includes("use server"))) {
        return;
      }
      if (warning.code === "SOURCEMAP_ERROR" && warning.message.includes("resolve original location") && warning.pos === 0) {
        return;
      }
      if ((_b = (_a = userConfig.build) == null ? void 0 : _a.rollupOptions) == null ? void 0 : _b.onwarn) {
        userConfig.build.rollupOptions.onwarn(warning, defaultHandler);
      } else {
        defaultHandler(warning);
      }
    }
  }
});

// src/index.ts
var vite = __toESM(require("vite"), 1);
var import_pluginutils = require("@rolldown/pluginutils");
var import_meta = {};
var _dirname = typeof __dirname !== "undefined" ? __dirname : (0, import_node_path.dirname)((0, import_node_url.fileURLToPath)(import_meta.url));
var resolve = (0, import_node_module.createRequire)(
  typeof __filename !== "undefined" ? __filename : import_meta.url
).resolve;
var react = (_options) => {
  let hmrDisabled = false;
  const options = {
    jsxImportSource: (_options == null ? void 0 : _options.jsxImportSource) ?? "react",
    tsDecorators: _options == null ? void 0 : _options.tsDecorators,
    plugins: (_options == null ? void 0 : _options.plugins) ? _options == null ? void 0 : _options.plugins.map((el) => [resolve(el[0]), el[1]]) : void 0,
    devTarget: (_options == null ? void 0 : _options.devTarget) ?? "es2020",
    parserConfig: _options == null ? void 0 : _options.parserConfig,
    reactRefreshHost: _options == null ? void 0 : _options.reactRefreshHost,
    useAtYourOwnRisk_mutateSwcOptions: _options == null ? void 0 : _options.useAtYourOwnRisk_mutateSwcOptions,
    disableOxcRecommendation: _options == null ? void 0 : _options.disableOxcRecommendation
  };
  return [
    {
      name: "vite:react-swc:resolve-runtime",
      apply: "serve",
      enforce: "pre",
      // Run before Vite default resolve to avoid syscalls
      resolveId: {
        filter: { id: (0, import_pluginutils.exactRegex)(runtimePublicPath) },
        handler: (id) => id === runtimePublicPath ? id : void 0
      },
      load: {
        filter: { id: (0, import_pluginutils.exactRegex)(runtimePublicPath) },
        handler: (id) => id === runtimePublicPath ? (0, import_node_fs.readFileSync)(
          (0, import_node_path.join)(_dirname, "refresh-runtime.js"),
          "utf-8"
        ).replace(
          /__README_URL__/g,
          "https://github.com/vitejs/vite-plugin-react/tree/main/packages/plugin-react-swc"
        ) : void 0
      }
    },
    {
      name: "vite:react-swc",
      apply: "serve",
      config: () => ({
        esbuild: false,
        // NOTE: oxc option only exists in rolldown-vite
        oxc: false,
        optimizeDeps: {
          include: [`${options.jsxImportSource}/jsx-dev-runtime`],
          ..."rolldownVersion" in vite ? { rollupOptions: { jsx: { mode: "automatic" } } } : { esbuildOptions: { jsx: "automatic" } }
        }
      }),
      configResolved(config) {
        if (config.server.hmr === false) hmrDisabled = true;
        const mdxIndex = config.plugins.findIndex(
          (p) => p.name === "@mdx-js/rollup"
        );
        if (mdxIndex !== -1 && mdxIndex > config.plugins.findIndex((p) => p.name === "vite:react-swc")) {
          throw new Error(
            "[vite:react-swc] The MDX plugin should be placed before this plugin"
          );
        }
        if ("rolldownVersion" in vite && !options.plugins && !options.useAtYourOwnRisk_mutateSwcOptions && !options.disableOxcRecommendation) {
          config.logger.warn(
            "[vite:react-swc] We recommend switching to `@vitejs/plugin-react-oxc` for improved performance as no swc plugins are used. More information at https://vite.dev/rolldown"
          );
        }
      },
      transformIndexHtml: (_, config) => {
        if (!hmrDisabled) {
          return [
            {
              tag: "script",
              attrs: { type: "module" },
              children: getPreambleCode(config.server.config.base)
            }
          ];
        }
      },
      async transform(code, _id, transformOptions) {
        const id = _id.split("?")[0];
        const refresh = !(transformOptions == null ? void 0 : transformOptions.ssr) && !hmrDisabled;
        const result = await transformWithOptions(
          id,
          code,
          options.devTarget,
          options,
          {
            refresh,
            development: true,
            runtime: "automatic",
            importSource: options.jsxImportSource
          }
        );
        if (!result) return;
        if (!refresh) return result;
        return addRefreshWrapper(
          result.code,
          result.map,
          "@vitejs/plugin-react-swc",
          id,
          options.reactRefreshHost
        );
      }
    },
    options.plugins ? {
      name: "vite:react-swc",
      apply: "build",
      enforce: "pre",
      // Run before esbuild
      config: (userConfig) => ({
        build: silenceUseClientWarning(userConfig)
      }),
      transform: (code, _id) => transformWithOptions(_id.split("?")[0], code, "esnext", options, {
        runtime: "automatic",
        importSource: options.jsxImportSource
      })
    } : {
      name: "vite:react-swc",
      apply: "build",
      config: (userConfig) => ({
        build: silenceUseClientWarning(userConfig),
        esbuild: {
          jsx: "automatic",
          jsxImportSource: options.jsxImportSource,
          tsconfigRaw: {
            compilerOptions: { useDefineForClassFields: true }
          }
        }
      })
    }
  ];
};
var transformWithOptions = async (id, code, target, options, reactConfig) => {
  const decorators = (options == null ? void 0 : options.tsDecorators) ?? false;
  const parser = options.parserConfig ? options.parserConfig(id) : id.endsWith(".tsx") ? { syntax: "typescript", tsx: true, decorators } : id.endsWith(".ts") || id.endsWith(".mts") ? { syntax: "typescript", tsx: false, decorators } : id.endsWith(".jsx") ? { syntax: "ecmascript", jsx: true } : id.endsWith(".mdx") ? (
    // JSX is required to trigger fast refresh transformations, even if MDX already transforms it
    { syntax: "ecmascript", jsx: true }
  ) : void 0;
  if (!parser) return;
  let result;
  try {
    const swcOptions = {
      filename: id,
      swcrc: false,
      configFile: false,
      sourceMaps: true,
      jsc: {
        target,
        parser,
        experimental: { plugins: options.plugins },
        transform: {
          useDefineForClassFields: true,
          react: reactConfig
        }
      }
    };
    if (options.useAtYourOwnRisk_mutateSwcOptions) {
      options.useAtYourOwnRisk_mutateSwcOptions(swcOptions);
    }
    result = await (0, import_core.transform)(code, swcOptions);
  } catch (e) {
    const message = e.message;
    const fileStartIndex = message.indexOf("\u256D\u2500[");
    if (fileStartIndex !== -1) {
      const match = message.slice(fileStartIndex).match(/:(\d+):(\d+)\]/);
      if (match) {
        e.line = match[1];
        e.column = match[2];
      }
    }
    throw e;
  }
  return result;
};
var src_default = react;

// <stdin>
module.exports = src_default;
module.exports.default = src_default;
