---
title: "Overview"
---

## Container Security

Welcome to **Creating a More Secure Production with Containers** - a hands-on workshop covering **8 container security best practices** plus a full **Docker Hardened Images (DHI) migration**, using the `catalog-service-node` app as the running example.

This workshop is split into two complementary tracks:

| Track | Approach | What it covers |
|-------|----------|----------------|
| **Docker Scout** | 🔄 **Reactive** - Scan and Fix | Surface CVEs in existing images, gate them in CI, fix them as they appear |
| **Docker Hardened Images** | 🛡️ **Pro-active** - Start Secure | Build on minimal, distroless, attested images with near-zero CVEs from day one |

Both approaches matter. Scout helps you understand and remediate what you already run; DHI helps you stop creating the problem in the first place.

---

## The four attack vectors that keep production teams up at night

1. **Image vulnerabilities** - known CVEs in OS packages and language dependencies
2. **Supply chain integrity** - compromised dependencies, post-install scripts, untrusted base images
3. **Runtime attack surface** - shells, package managers, dev tools, and OS utilities that aid attackers
4. **Compliance** - FIPS, STIG, license obligations, audit-ready provenance

The 8 best practices below directly address vectors 1, 3, and 4. Scout addresses vector 1 reactively. DHI addresses all four pro-actively.

---

## The 8 Container Security Best Practices

| # | Best Practice | What it addresses |
|---|---------------|-------------------|
| 1 | [Start with minimal base images](/docker-workshop/security/container-security/minimal-base-images) | Less OS surface = fewer CVEs |
| 2 | [Use multi-stage builds](/docker-workshop/security/container-security/multi-stage-builds) | Keep dev tools out of production |
| 3 | [Run as non-root user](/docker-workshop/security/container-security/non-root-user) | Limit blast radius of code execution |
| 4 | [Read-only filesystem + drop capabilities](/docker-workshop/security/container-security/readonly-capabilities) | Stop attackers from writing payloads |
| 5 | [Scan continuously, not just at build](/docker-workshop/security/scout-reactive/continuous-scanning) | Catch new CVEs as they emerge |
| 6 | [Manage secrets properly](/docker-workshop/security/container-security/secrets-and-tools) | Never bake credentials into images |
| 7 | [No dev tools in production](/docker-workshop/security/container-security/secrets-and-tools) | Smaller attack surface |
| 8 | [No OS tools in production](/docker-workshop/security/container-security/secrets-and-tools) | No `curl`, no `wget`, no payload delivery |

---

## Key numbers from the field

| Image | Critical CVEs | High CVEs | Packages | Size |
|-------|---------------|-----------|----------|------|
| `node:18` (where most teams start) | 2 | 26 | 693 | 1.62 GB |
| `node:25-slim` (BP#1 applied) | 0 | 2 | 272 | 368 MB |
| `dhi.io/node:24-debian13` (DHI) | 0 | 0 | ~12 | ~50 MB |

> **One `FROM` line change** from `node:18` to `node:25-slim` eliminates **2 critical and 25 high** CVEs immediately. Migrating to DHI eliminates **all of them**, removes 595 packages, and shrinks the image 10x.

---

## The sample application

Throughout this workshop we use [`catalog-service-node`](https://github.com/dockersamples/catalog-service-node) - a real-world Node.js service with PostgreSQL, Kafka, and S3 dependencies. It ships with a setup script that deliberately introduces a vulnerable state (old base image, downgraded dependencies) so you can experience the full security journey from the bottom up.

Ready to start? Head over to [Setup](/docker-workshop/security/container-security/setup) to clone the project and configure your environment.
