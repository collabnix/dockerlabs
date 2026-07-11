---
title: "Stage: base (DHI dev variant - has shell + npm for builds)"
---

## Migrate to Docker Hardened Images

> **The pro-active approach: Start Secure.** DHI images are purpose-built from the ground up to be extremely minimal - not stripped-down versions of something bloated.

In this section we'll convert `catalog-service-node` from `node:25-slim` (where the [best-practices track](/docker-workshop/security/container-security/overview) ended) to a Docker Hardened Image, then compare the results.

## Before you start

Make sure you have:

- Completed the [Setup](/docker-workshop/security/container-security/setup) steps
- Decided on free vs paid DHI tier (and know your `<DHI_PREFIX>`)
- Logged in to `dhi.io` if using the free tier (`docker login dhi.io`)

## Update the Dockerfile

Open `catalog-service-node/Dockerfile` and replace it with this DHI-based version:

```dockerfile
###########################################################

###########################################################
FROM <DHI_PREFIX>node:24-debian13-dev AS base

WORKDIR /usr/local/app
COPY package.json package-lock.json ./

###########################################################
# Stage: dev
###########################################################
FROM base AS dev
ENV NODE_ENV=development
RUN npm install
CMD ["yarn", "dev-container"]

###########################################################
# Stage: production-dependencies
###########################################################
FROM base AS production-dependencies
ENV NODE_ENV=production
RUN npm ci --production --ignore-scripts && npm cache clean --force

###########################################################
# Stage: final (DHI runtime - distroless, no shell)
###########################################################
FROM <DHI_PREFIX>node:24-debian13 AS final
ENV NODE_ENV=production
COPY --from=production-dependencies /usr/local/app/node_modules ./node_modules
COPY ./src ./src
EXPOSE 3000
CMD ["node", "src/index.js"]
```

The two critical changes:

```diff
- FROM node:25-slim AS base
+ FROM <DHI_PREFIX>node:24-debian13-dev AS base   # build stage
+ FROM <DHI_PREFIX>node:24-debian13 AS final      # runtime - distroless
```

Notice the structure: the dev variant is used as the build environment (it has `npm`), but the final image is built `FROM` the **distroless runtime** variant. Only the compiled `node_modules` and `src` are copied in.

## Build the DHI version

```bash
docker build -t catalog-service:dhi --sbom=true --provenance=mode=max .
```

## Compare all three images

```bash
docker images catalog-service
```

```text
IMAGE                    ID             DISK USAGE   CONTENT SIZE
catalog-service:dhi      ac3a0d465de4        191MB         40.3MB
catalog-service:latest   48806e62b871       1.62GB          413MB
catalog-service:slim     8d03cef7a79f        368MB         84.1MB
```

The DHI runtime is **10× smaller than the original** and **half the size of the slim version** - and we still haven't looked at security.

## Scout quickview - all 7 policies green

```bash
docker scout quickview catalog-service:dhi --org <YOUR_ORG>
```

```text
Target     │  catalog-service:dhi  │    0C     0H     0M     0L

Policy status  SUCCEEDED  (7/7 policies met)

  Status │                              Policy                              │  Results
─────────┼──────────────────────────────────────────────────────────────────┼──────────
  ✓      │ Default non-root user                                            │
  ✓      │ No AGPL v3 licenses                                              │
  ✓      │ No fixable critical or high vulnerabilities                      │
  ✓      │ No high-profile vulnerabilities                                  │
  ✓      │ No unapproved base images                                        │
  ✓      │ Supply chain attestations                                        │
  ✓      │ No outdated base images                                          │
```

**7/7 policies met.** Up from 4/7 at the start of the workshop.

## Full before/after comparison

```bash
docker scout compare \
    --ignore-unchanged \
    --to catalog-service \
    catalog-service:dhi \
    --org <YOUR_ORG>
```

```text
  vulnerabilities │  0C  0H  0M  0L   │  2C  26H  25M  122L  4?
  size            │  40 MB (-358 MB)   │  398 MB
  packages        │  211 (-595)        │  806
```

The numbers:

- ✅ **595 packages removed** - 595 fewer potential CVE vectors
- ✅ **179 vulnerabilities removed** across all severities
- ✅ Image is **10× smaller**

## The no-shell demo

Because the DHI runtime is distroless, an attacker who gains code execution **cannot drop to a shell**:

```bash
docker run --rm catalog-service:dhi sh
```

Expected: error - `sh` does not exist in the image.

Compare to slim:

```bash
docker run --rm catalog-service:slim sh -c "echo 'shell available - attack surface'"
```

The slim image still gives the attacker a shell. The DHI image does not. That's a meaningful difference in what an exploit can do once it lands.

## DHI vs slim - property comparison

| Property | `node:25-slim` | DHI runtime |
|----------|---------------|-------------|
| CVEs (critical/high) | 0C 2H | **0C 0H** |
| Package count | ~272 | **~12** |
| Shell in runtime | Yes (`sh`) | **No (distroless)** |
| Non-root by default | Manual | **Built-in** |
| SBOM | Build-time only | **Cryptographically signed** |
| VEX document | No | **Yes** |
| SLSA provenance | Build-time only | **Verified** |
| FIPS variant | No | **Yes** (`-fips` tag) |
| STIG variant | No | **Yes** |
| 7-day CVE SLA | No | **Yes** |

Continue to [Attestations & Scanner Integration](/docker-workshop/security/dhi-proactive/attestations).
