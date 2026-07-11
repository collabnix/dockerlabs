---
title: "CI Integration"
---

## Scout CI Integration

A scanner that doesn't fail the build is just a dashboard. Wiring Scout into CI as a **gate** is what turns reactive scanning into something that actually keeps vulnerable images out of production.

## The Scout GitHub Action

Open `catalog-service-node/.github/workflows/pipeline-docker-cloud.yaml` to see how Scout integrates into a real pipeline.

The key gate step:

```yaml
      - name: Docker Scout CVEs
        uses: docker/scout-action@v1
        with:
          command: cves
          image: ${{ steps.build.outputs.imageid }}
          only-severities: critical,high
          exit-code: true
```

Two flags do the heavy lifting:

- `only-severities: critical,high` - only fail on what actually matters; medium and low don't block the pipeline
- `exit-code: true` - makes the action **fail** the build when matching CVEs are found

That's the gate. If a critical or high CVE shows up, the PR can't merge and the image can't deploy.

## A more complete pipeline

A typical Scout-in-CI pipeline does several things in sequence:

```yaml
      # 1. Build with SBOM and provenance attached
      - name: Build image
        id: build
        uses: docker/build-push-action@v5
        with:
          tags: ${{ env.IMAGE_NAME }}
          sbom: true
          provenance: mode=max
          load: true

      # 2. Quickview - surfaces a summary in the action log
      - name: Docker Scout quickview
        uses: docker/scout-action@v1
        with:
          command: quickview
          image: ${{ steps.build.outputs.imageid }}

      # 3. Compare against the previous prod image
      - name: Docker Scout compare
        uses: docker/scout-action@v1
        with:
          command: compare
          image: ${{ steps.build.outputs.imageid }}
          to: registry.example.com/catalog-service:prod
          ignore-unchanged: true

      # 4. Hard gate on critical/high
      - name: Docker Scout CVE gate
        uses: docker/scout-action@v1
        with:
          command: cves
          image: ${{ steps.build.outputs.imageid }}
          only-severities: critical,high
          exit-code: true

      # 5. Policy gate
      - name: Docker Scout policy gate
        uses: docker/scout-action@v1
        with:
          command: policy
          image: ${{ steps.build.outputs.imageid }}
          exit-code: true
```

The order matters: `quickview` and `compare` run *before* the gate, so the developer sees what's wrong even when the gate fails. Nothing is more frustrating than a CI that says "FAILED" with no detail.

## Tuning the gate

A real-world gate has to balance security and developer flow. A few patterns that work well:

| Pattern | What it does |
|---------|--------------|
| `only-severities: critical,high` | Only block on CVEs that meaningfully matter |
| `only-fixed: true` | Only block on CVEs where a fix is actually available |
| `ignore-unchanged: true` | Don't re-flag CVEs that were already in the previous image |
| Block on `policy` not raw `cves` | Use organisational policy rather than every CVE everywhere |

## Local pre-flight check

Developers can run the same gate locally before pushing - fewer broken builds:

```bash
docker scout cves catalog-service:slim \
    --only-severity critical,high \
    --org <YOUR_ORG> \
    --exit-code
```

Exit code is non-zero if anything matches. Wire this into a pre-commit hook or a `make security` target.

Continue to [Recommendations & Comparisons](/docker-workshop/security/scout-reactive/recommendations), or jump to the pro-active half of the workshop: [Migrating to DHI](/docker-workshop/security/dhi-proactive/overview).
