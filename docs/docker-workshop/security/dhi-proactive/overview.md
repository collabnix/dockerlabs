---
title: "Overview"
---

## Docker Hardened Images - The Pro-active Approach

> **Start Secure.** Docker Hardened Images are purpose-built from the ground up to be extremely minimal - not stripped-down versions of something bloated.

This is the **pro-active** half of the container security story. Where [Scout](/docker-workshop/security/scout-reactive/overview) helps you find and fix CVEs in images you already have, DHI helps you stop *creating* them in the first place.

The premise is simple: if your base image starts with **near-zero CVEs**, follows a **distroless philosophy**, and ships with **signed supply-chain attestations**, you've eliminated most of the reactive cycle before it begins.

---

## What makes a Docker Hardened Image different

| Property | Standard base image | DHI |
|----------|---------------------|-----|
| CVEs (critical/high) | dozens to hundreds | **0 critical, 0 high** |
| Package count | 200–700+ | **~12** |
| Shell in runtime | Yes (`sh`, `bash`) | **No** (distroless) |
| Non-root by default | Manual | **Built-in** (UID 65532) |
| SBOM | Build-time, optional | **Cryptographically signed** |
| VEX document | No | **Yes** (eliminates false positives) |
| SLSA provenance | Build-time, optional | **Verified, signed** |
| FIPS variant | No | **Yes** (`-fips` tag) |
| STIG variant | No | **Yes** |
| CVE remediation SLA | None | **7-day SLA** |

---

## DHI variants

DHI ships in two variants per language/runtime:

| Variant | Tag pattern | Use case |
|---------|-------------|----------|
| **Dev** | `<DHI_PREFIX>node:24-debian13-dev` | Building - has shell, `npm`, build tools |
| **Runtime** | `<DHI_PREFIX>node:24-debian13` | Production - distroless, no shell |

> Replace `<DHI_PREFIX>` with `dhi.io/` for the free tier or `<YOUR_ORG>/dhi-` for the paid tier (see [Setup](/docker-workshop/security/container-security/setup)).

Because the runtime variant has no shell or `npm`, you use **multi-stage builds**: the dev image installs dependencies, the runtime image gets only the output. This isn't a constraint - it's how production images *should* be built.

---

## Workshop sections

| Section | What you'll do |
|---------|----------------|
| [Migrate to DHI](/docker-workshop/security/dhi-proactive/migration) | Convert `catalog-service-node` from `node:25-slim` to DHI, before/after Scout comparison |
| [Attestations & Scanner Integration](/docker-workshop/security/dhi-proactive/attestations) | Inspect SBOMs, VEX, SLSA provenance, FIPS, and pass them into Grype/Trivy |

---

## The four attack vectors, addressed

Recall the four attack vectors from the [Container Security overview](/docker-workshop/security/container-security/overview):

| Vector | DHI's answer |
|--------|--------------|
| Image vulnerabilities | Near-zero CVEs by construction; 7-day SLA on remediation |
| Supply chain integrity | Signed SBOMs + SLSA provenance + VEX, all verifiable with `docker scout attest` |
| Runtime attack surface | Distroless: no shell, no package manager, no curl, no apt |
| Compliance | FIPS 140-validated and STIG variants ship out of the box |

That's why DHI is the **pro-active** answer. You're not finding CVEs and patching them - you're starting from a base where there are almost none, with cryptographic evidence to prove it.

> **Use both.** Scout for visibility on what you run. DHI for the foundation you build on.
