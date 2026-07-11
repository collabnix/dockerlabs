---
title: "Recommendations & Comparisons"
---

## Recommendations & Comparisons

Two of Scout's most useful commands aren't about finding CVEs - they're about figuring out **what to do next**: `recommendations` and `compare`.

## `docker scout recommendations` - what should I upgrade to?

Most CVE-fix advice from a generic scanner is "upgrade the package". For base images that's not always actionable - you don't pin individual OS packages, you pin a base image tag. Scout knows that and gives you tag-level upgrade paths instead.

```bash
docker scout recommendations catalog-service:slim --org <YOUR_ORG>
```

The output ranks candidate base image tags by:

- How many CVEs are eliminated
- Tag freshness
- Compatibility with your current image

Use this every time you do a base image bump. It turns "I think I should move to `node:25-slim` because I read it somewhere" into "Scout says `node:25-slim` removes 23 CVEs, here are the remaining 7."

## `docker scout compare` - what changed between two images?

`compare` is the command most teams underuse. It's the difference between a scary CVE report and an actionable one.

### Compare two local image tags

```bash
docker scout compare \
    --ignore-unchanged \
    --to catalog-service \
    catalog-service:slim \
    --org <YOUR_ORG>
```

This compares the new image (`catalog-service:slim`) against the baseline (`catalog-service`, the old vulnerable build). With `--ignore-unchanged`, you see only what's *different* - not every package both images share.

### Compare against the previous production image

In CI, you almost always want to compare against what's currently running in prod:

```bash
docker scout compare \
    --to registry.example.com/catalog-service:prod \
    catalog-service:candidate \
    --org <YOUR_ORG>
```

The output answers the question every reviewer actually wants the answer to: **"is this PR worse than what we have today?"**

### Reading the compare output

A typical block looks like this:

```text
  vulnerabilities │  0C  0H  0M  0L  │  2C  26H  25M  122L  4?
  size            │  40 MB (-358 MB)  │  398 MB
  packages        │  211 (-595)       │  806
```

Three signals at a glance:

- CVEs gone vs introduced
- Size delta
- Package count delta

If you're shipping to a tightly-controlled production environment, this is the table to put in your release notes.

## Putting it together: the upgrade decision flow

1. Run `docker scout quickview` on what you have today
2. Run `docker scout recommendations` to see candidate upgrades
3. Pick a candidate, build it
4. Run `docker scout compare` against your current prod image
5. If the comparison looks good, ship it. If not, revisit.

This is the **reactive loop done well** - fast, data-driven, and grounded in actual diffs rather than abstract advice.

> Ready to break out of the reactive loop entirely? Continue to [Migrating to DHI](/docker-workshop/security/dhi-proactive/overview). DHI ships with near-zero CVEs by construction - and Scout still gives you visibility on top.
