---
title: "Surface the Problem"
---

## Surface the Problem

Before we fix anything, let's measure exactly what's wrong with the starting image. After the setup patch, our `Dockerfile` starts with:

```dockerfile
FROM node:18 AS base
```

`node:18` is a full, unoptimised image - and it's where most teams start by default. Let's see what that costs us.

## Quick vulnerability overview

```bash
docker scout quickview catalog-service --org <YOUR_ORG>
```

You'll see something like this:

```text
  Target             │  catalog-service:latest  │    2C    26H    25M   122L     4?
    digest           │  360db4f00cbd            │
  Base image         │  node:18                 │    2C    26H    25M   122L     4?
  Updated base image │  node:25-slim            │    0C     1H     2M    24L
                     │                          │    -2    -25    -23    -98     -4
```

Scout is already pointing at the answer: **one `FROM` line change** from `node:18` to `node:25-slim` would eliminate **2 critical and 25 high** CVEs immediately.

## Policy evaluation

Scout doesn't just count CVEs - it evaluates your image against a set of organisational policies:

```bash
docker scout policy catalog-service --org <YOUR_ORG>
```

```text
Policy status  FAILED  (4/7 policies met)

  Status │                     Policy                     │           Results
─────────┼────────────────────────────────────────────────┼──────────────────────────────
  ✓      │ Default non-root user                          │
  !      │ AGPL v3 licenses found                         │    3 packages
  !      │ Fixable critical or high vulnerabilities found │    2C    26H     0M     0L
  ✓      │ No high-profile vulnerabilities                │
  ✓      │ No outdated base images                        │
  !      │ Unapproved base images found                   │    1 deviation
  ✓      │ Supply chain attestations                      │    0 deviations
```

**4/7 policies failing.** This is the **reactive "scan and fix"** cycle most teams know all too well:

1. Developers pull a base image, build, ship
2. CI scanner finds 2 critical and 26 high CVEs
3. Developers spend 3 days researching fixes
4. Rebuild - 189 vulnerabilities still remain
5. Cycle repeats; security blocks deployment

The next 8 sections walk through fixing this **proactively, one best practice at a time** - and then [migrating to DHI](/docker-workshop/security/dhi-proactive/overview) to eliminate the cycle altogether.
