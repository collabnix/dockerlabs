---
title: "Overview"
---

## Docker Scout - The Reactive Approach

> **Scan and Fix.** Docker Scout helps you understand what's already in your images, find vulnerabilities, and remediate them - across the full SDLC.

This is the **reactive** half of the container security story: you have images today, they have CVEs today, and you need a systematic way to find and fix them. Scout gives you that.

The companion track, [Docker Hardened Images (Pro-active Approach)](/docker-workshop/security/dhi-proactive/overview), goes the other direction: don't *create* the problem in the first place. In real production environments, you need both.

---

## What Scout does

| Capability | What it gives you |
|------------|-------------------|
| **Quickview** | Fast CVE summary for any image |
| **CVE drill-down** | Per-package vulnerability detail with severity filtering |
| **Compare** | Diff between two image versions - exactly what changed |
| **Recommendations** | Suggested base image upgrade paths |
| **Policy evaluation** | Pass/fail your image against organisational policies |
| **CI integration** | GitHub Action that fails the build on critical/high CVEs |
| **Background SBOM indexing** | Continuous analysis of every image you pull or build |

---

## When to use Scout

| Scenario | Scout role |
|----------|-----------|
| You inherited a fleet of images and need to triage | Quickview + CVE drill-down |
| A CVE was just disclosed - am I affected? | Background SBOM indexing alerts you |
| Reviewing a PR that bumps a base image | `compare` to see exactly what changed |
| Gating production deployments | `scout-action` in CI with `exit-code: true` |
| Choosing what to migrate to | `recommendations` shows the upgrade path |

---

## Workshop sections

| Section | What you'll do |
|---------|----------------|
| [Continuous Scanning](/docker-workshop/security/scout-reactive/continuous-scanning) | The three core Scout commands and why scanning at build alone is not enough |
| [CI Integration](/docker-workshop/security/scout-reactive/ci-integration) | Wire Scout into GitHub Actions and fail the build on critical/high CVEs |
| [Recommendations & Comparisons](/docker-workshop/security/scout-reactive/recommendations) | Use `scout recommendations` and `scout compare` to find your upgrade path |

---

## The reactive cycle (and its limits)

The traditional reactive cycle looks like this:

1. Pull a base image
2. Build, ship
3. Scanner finds CVEs
4. Spend days researching fixes
5. Patch, rebuild
6. New CVEs disclosed against your image
7. Go to step 4

Scout makes every step of this cycle faster and more accurate - but you're still on the cycle. The pro-active answer is to start from a base that has near-zero CVEs and a 7-day SLA on remediation. That's [DHI](/docker-workshop/security/dhi-proactive/overview).

> **Use both.** Scout for the images you have today. DHI for the images you build next.
