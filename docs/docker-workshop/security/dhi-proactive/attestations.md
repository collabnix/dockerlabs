---
title: "Attestations & Scanner Integration"
---

## Attestations & Scanner Integration

> **Built-in supply chain security:** Every DHI ships with signed SBOMs, VEX documents, and SLSA provenance for audit-ready pipelines.

This is what most teams don't realise about DHI: it's not just a smaller image with fewer CVEs. It's a fully-attested artifact. Every image carries cryptographic evidence of what's in it, where it came from, and what risks have been assessed.

## List all attestations

```bash
docker scout attest list <DHI_PREFIX>node:24-debian13
```

A single DHI image typically ships with all of the following:

| Attestation | What it is |
|-------------|------------|
| CycloneDX SBOM | Bill of materials - components, libraries, versions |
| SPDX SBOM | SBOM in SPDX format (widely adopted in open-source) |
| Scout SBOM | SBOM generated and signed by Docker Scout |
| OpenVEX | Identifies non-applicable CVEs and explains why |
| in-toto vulnerabilities | Known CVEs affecting the image's components |
| SLSA provenance | Source, build params, and environment details |
| SLSA verification summary | Image's compliance with SLSA requirements |
| Scout health | Signed summary of security and quality posture |
| Scout secret scan | Results of a secrets scan |
| Scout test report | Record of automated tests run against the image |

That's *evidence-grade* supply-chain documentation, available out of the box.

## View the SPDX SBOM

```bash
docker scout attest get <DHI_PREFIX>node:24-debian13 \
    --predicate-type https://spdx.dev/Document
```

The SPDX SBOM lists every package, version, license, and supplier. This is the document a compliance team will ask for during an audit.

## Inspect the SLSA provenance

```bash
docker buildx imagetools inspect <DHI_PREFIX>node:24-debian13 \
    --format '{{json .Provenance}}' | head -80
```

SLSA provenance answers "where did this image come from?" - source repository, commit, build parameters, builder identity. Combined with a signature, it becomes verifiable proof of origin.

## Verify the image signature

```bash
docker trust inspect --pretty <DHI_PREFIX>node:24-debian13
```

The signature ties the image bytes to a verified publisher. A modified image won't verify; an attacker can't substitute a tampered version without breaking the chain.

## FIPS compliance

DHI includes FIPS 140-validated cryptographic modules for regulated environments - government, healthcare, finance, defence.

```bash
docker scout attest get \
    --predicate-type https://docker.com/dhi/fips/v0.1 \
    --predicate \
    <DHI_PREFIX>node:24-debian13-fips
```

Sample output:

```text
"certification": "CMVP #4985",
"certificationUrl": "https://csrc.nist.gov/projects/cryptographic-module-validation-program/certificate/4985",
"name": "OpenSSL FIPS Provider",
"standard": "FIPS 140-3",
"status": "active",
"sunsetDate": "2030-03-10"
```

That's a real CMVP certificate number, queryable on NIST's site, attached as a signed predicate to the image. For regulated workloads, that's the difference between "we think we're compliant" and "here's the certificate".

## STIG attestation

```bash
docker scout attest get \
    --predicate-type https://docker.com/dhi/stig/v0.1 \
    --predicate \
    <DHI_PREFIX>node:24-debian13-fips
```

STIG (Security Technical Implementation Guide) attestations cover compliance with US DoD security baselines - required for many government deployments.

## VEX export - eliminate false positives in external scanners

VEX (Vulnerability Exploitability eXchange) documents tell external scanners (Grype, Trivy, Wiz) which CVEs have already been **assessed as non-exploitable** - eliminating false positives automatically.

This is the killer feature for teams already running third-party scanners. Instead of triaging the same CVE every week, the VEX document tells the scanner "this one's been reviewed, it doesn't apply to this image, move on."

View attestations on your migrated app image:

```bash
docker scout attest list catalog-service:dhi
```

Export the merged VEX document:

```bash
docker scout vex get catalog-service:dhi --output vex.json
```

Pass it to Grype:

```bash
grype catalog-service:dhi --vex vex.json
```

Pass it to Trivy:

```bash
trivy image --vex vex.json catalog-service:dhi
```

The same image, scanned with VEX, reports far fewer CVEs - because the noise has been pre-filtered out by people who actually understand whether a given CVE applies in this build.

## The complete supply chain story

| Question a security team will ask | DHI's answer |
|-----------------------------------|--------------|
| What's in this image? | Signed SBOM (CycloneDX + SPDX) |
| Where did it come from? | SLSA provenance |
| Who built it? | Image signature + provenance |
| Has it been tampered with? | `docker trust inspect` verifies the signature |
| Which CVEs apply? | Scout CVE scan + OpenVEX (filters non-applicable ones) |
| Is it FIPS-compliant? | FIPS attestation with CMVP certificate |
| Is it STIG-compliant? | STIG attestation |
| When are CVEs fixed? | 7-day SLA on critical/high |

## Key takeaway

> Securing your containers is step one.
> Securing your **supply chain** is the rest.
>
> 1. **Know what software you are running** - SBOMs, dependency trees, base image provenance
> 2. **Know what risks that software has** - continuous vulnerability scanning, VEX-aware
> 3. **Fix those risks quickly** - DHI gives you a **7-day SLA** on critical/high CVEs

[Get started with DHI →](https://docs.docker.com/dhi/get-started/)
