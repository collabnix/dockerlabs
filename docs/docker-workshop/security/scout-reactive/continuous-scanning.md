---
title: "Continuous Scanning"
---

## Continuous Scanning, Not Just at Build

> **Best Practice #5:** New CVEs are disclosed every day against images you built months ago. Scanning must happen throughout the entire SDLC - at code, build, registry push, and in production.

A scan at build time tells you what was vulnerable when you built. It does *not* tell you whether yesterday's freshly-disclosed CVE affects the image you shipped last quarter. Continuous scanning closes that gap.

## The three core Scout commands

### 1. Quickview - fast summary

```bash
docker scout quickview catalog-service:slim --org <YOUR_ORG>
```

Use this as your default first look at any image. It returns CVE counts grouped by severity (Critical / High / Medium / Low / Unknown), plus the recommended base image upgrade.

### 2. CVE drill-down - see the actual vulnerabilities

```bash
docker scout cves catalog-service:slim \
    --only-severity critical,high \
    --org <YOUR_ORG>
```

This lists every CVE matching the severity filter, the affected package, the version, and (when available) the fix version. Filter aggressively in CI - most teams gate only on `critical,high`.

### 3. Compare - see exactly what changed between two images

```bash
docker scout compare \
    --ignore-unchanged \
    --to catalog-service \
    catalog-service:slim \
    --org <YOUR_ORG>
```

The `compare` output shows exactly which packages were added/removed/changed and which CVEs were introduced or eliminated - actionable signal, not just noise. This is the command that turns a scary "289 CVEs!" report into "here are the 3 packages that actually changed".

Use `compare` whenever you:

- Bump a base image version
- Bump a major dependency
- Review a PR that touches the Dockerfile
- Roll out a new image to production

## Recommendations - the upgrade path

```bash
docker scout recommendations catalog-service:slim --org <YOUR_ORG>
```

Scout shows the exact upgrade tag that resolves remaining CVEs, along with how many vulnerabilities each candidate eliminates. Instead of "the base image has CVEs, good luck", you get "upgrade to `node:25-slim` and 23 of these go away."

## Background SBOM indexing in Docker Desktop

Enable via **Settings → Features in development → Enable background Scout SBOM indexing** in Docker Desktop.

Once enabled, Scout continuously analyses every image you pull or build - you get alerts before you even think to scan. New CVE disclosed against an image you're running? Scout will tell you, automatically.

This is the missing piece for true continuous scanning: the CVE database changes every day, but most teams only scan at build time. Background indexing means your local images are always re-evaluated against the latest data.

## What about production?

For production fleets, the same principles apply but at registry-/cluster-scale:

- **Registry scanning** - Docker Hub and most registries can scan on push and continuously re-evaluate
- **Cluster scanning** - runtime scanners like Trivy, Grype, and Wiz can pull and analyse every image referenced by a running deployment
- **VEX integration** - DHI ships VEX documents that tell these scanners *which CVEs are non-applicable* (more in the [DHI attestations section](/docker-workshop/security/dhi-proactive/attestations))

Continue to [CI Integration](/docker-workshop/security/scout-reactive/ci-integration).
