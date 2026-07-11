---
title: "BP#2: Multi-Stage Builds"
---

## Best Practice #2: Multi-Stage Builds

> **Keep dev tools, compilers, and test frameworks out of production.**

A common antipattern is using a single Dockerfile stage that installs everything - dev dependencies, compilers, test frameworks, debuggers - and then ships that whole image to production. Everything that's only useful at build time becomes attack surface at runtime.

## What must NOT ship to production

- Source code beyond what's needed (after copy/compile)
- IDE tooling and editors
- Compilers and build tools
- Debuggers
- The full `npm install` set (which includes `devDependencies`)
- Non-deployable build artifacts

Multi-stage builds let you cleanly separate the build environment from the runtime environment.

## Examine the Dockerfile structure

Look at the `Dockerfile` you saved in the previous step. Three stages:

```text
FROM node:25-slim AS base     <-- shared foundation
  └─ FROM base AS dev          <-- installs ALL deps + dev tools
  └─ FROM base AS final        <-- npm ci --production only
```

The critical production line:

```dockerfile
RUN npm ci --production --ignore-scripts && npm cache clean --force
```

Each flag matters:

- `--production` - only production dependencies, `devDependencies` excluded
- `--ignore-scripts` - no post-install scripts (a common supply chain attack vector)
- `npm cache clean --force` - removes the npm cache from the layer, shrinking the image

## Build specific stages

You can build any stage by name with `--target`. This is useful in CI: run unit tests against the dev stage, ship the final stage to production.

Build the dev stage:

```bash
docker build -t catalog-service:dev --target dev .
```

Build the production stage:

```bash
docker build -t catalog-service:prod --target final .
```

Compare the two:

```bash
docker images catalog-service
```

The `dev` image is significantly larger - it contains all `devDependencies`. The `prod` image is lean: smaller attack surface, faster pulls, less risk.

## Why `--ignore-scripts` matters

Post-install scripts are a well-known supply chain attack vector. The 2022 [`node-ipc` incident](https://snyk.io/blog/peacenotwar-malicious-npm-node-ipc-package-vulnerability/) used a post-install script to wipe files on disks in specific countries. `--ignore-scripts` prevents `npm` from running these scripts during `ci` or `install`, blocking that entire class of attack at build time.

You can verify your prod image stayed clean of critical/high CVEs with Scout:

```bash
docker scout cves catalog-service:prod --only-severity critical,high --org <YOUR_ORG>
```

Continue to [BP#3: Non-Root User](/docker-workshop/security/container-security/non-root-user).
