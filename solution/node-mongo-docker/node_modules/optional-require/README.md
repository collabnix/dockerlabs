[![NPM version][npm-image]][npm-url] [![Build Status][travis-image]][travis-url]
[![Dependency Status][daviddm-image]][daviddm-url] [![devDependency Status][daviddm-dev-image]][daviddm-dev-url]

# Optional Require

node.js require that let you handle module not found error without try/catch. Allows you to gracefully require a module only if it exists and contains no error.

## Why not try/catch?

So why not just do:

```ts
let some;
try {
  some = require("some-optional-module");
} catch {
  // do nothing
}
```

1. You need to keep the variable outside: `let some` before try/catch
2. If `"some-optional-module"` contains error itself, above code will silently ignore it, leaving you, and more importantly, your users, puzzling on why it's not working.

## Usage

TypeScript:

```ts
import { optionalRequire } from "optional-require";

const some = optionalRequire("some-optional-module");
```

JavaScript:

```js
const { optionalRequire } = require("optional-require");

const foo = optionalRequire("foo") || {};
const bar = optionalRequire("bar", true); // true enables console.log a message when not found
const xyz = optionalRequire("xyz", "test"); // "test" enables console.log a message with "test" added.
const fbPath = optionalRequire.resolve("foo", "foo doesn't exist");
// relative module path works - *but* you need to pass in `require` from your file
const rel = optionalRequire("../foo/bar", { require });
```

### Binding `require`

The default `optionalRequire` uses `require` from the context of this module. While you can pass in your `require` in `options`, if you want to create your own function that's bound to your `require`, you can do it with `makeOptionalRequire`:

```ts
import { makeOptionalRequire } from "optional-require";

const optionalRequire = makeOptionalRequire(require);

// now you can optional require files in same dir as your file
const myModule = optionalRequire("./my-module");
```

### Legacy Usage

In older versions, this module exports `makeOptionalRequire` directly and this is the legacy usage in JavaScript, which is still supported:

```js
const optionalRequire = require("optional-require")(require);

const foo = optionalRequire("foo") || {};
const bar = optionalRequire("bar", true); // true enables console.log a message when not found
const xyz = optionalRequire("xyz", "test"); // "test" enables console.log a message with "test" added.
const fbPath = optionalRequire.resolve("foo", "foo doesn't exist");
const rel = optionalRequire("../foo/bar"); // relative module path works
```

## API

<https://jchip.github.io/optional-require/modules.html#optionalrequire>

# LICENSE

Apache-2.0 © [Joel Chen](https://github.com/jchip)

[travis-image]: https://travis-ci.org/jchip/optional-require.svg?branch=master
[travis-url]: https://travis-ci.org/jchip/optional-require
[npm-image]: https://badge.fury.io/js/optional-require.svg
[npm-url]: https://npmjs.org/package/optional-require
[daviddm-image]: https://david-dm.org/jchip/optional-require/status.svg
[daviddm-url]: https://david-dm.org/jchip/optional-require
[daviddm-dev-image]: https://david-dm.org/jchip/optional-require/dev-status.svg
[daviddm-dev-url]: https://david-dm.org/jchip/optional-require?type=dev
