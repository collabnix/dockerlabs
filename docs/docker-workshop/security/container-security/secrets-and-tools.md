---
title: "WRONG - SSH key baked into layer forever"
---

## Best Practices #6, #7, #8: Secrets, Dev Tools, OS Tools

The last three best practices all share a common theme: **don't ship anything to production that an attacker could use against you**. That includes credentials, dev tooling, and standard OS utilities.

## BP#6: Secrets

Containers often need credentials: DB passwords, TLS certs, API keys, SSH keys for private package registries. Where you put them determines who can read them.

### The wrong approaches - all visible to attackers

| Location | Risk |
|----------|------|
| In source code | Visible to anyone with repo access |
| Built into the image | Visible via `docker history` |
| In execution scripts committed to SCM | Same as source code |
| In an environment variable | Shows in log dumps, visible to all processes |
| In a file on disk | Available to any process on the machine |
| **In a secrets vault** | **Only available to the process asking for it ✓** |

### Inspect image layers - confirm no secrets leaked

`docker history` shows every command that built the image - and exposes anything that was inlined into a layer:

```bash
docker history catalog-service:slim
```

Look through every layer - no credentials, tokens, or keys should be visible. If you see a `RUN echo "API_KEY=..."` or a `COPY .env`, that secret is now permanently embedded in the image.

### BuildKit build-time secrets

BuildKit's `--mount=type=secret` lets you use a secret during build **without it ever being written to any layer**:

```dockerfile

RUN cp /root/.ssh/id_rsa /app/key

# RIGHT - BuildKit secret, never written to any layer
RUN --mount=type=secret,id=mysecret cat /run/secrets/mysecret
```

```bash
docker build --secret id=mysecret,src=./mysecret.txt -t myapp .
```

The secret is mounted into the build container at `/run/secrets/mysecret`, used during the `RUN`, then disappears. It never lands in `docker history` and never ships in the image.

For runtime secrets, integrate with a real vault (HashiCorp Vault, AWS Secrets Manager, Azure Key Vault) and fetch them at startup - never bake them in.

---

## BP#7: No dev tools in production

Verify the production image has no dev tooling beyond the runtime itself:

```bash
docker run --rm catalog-service:slim which npm   || echo "npm not found - good"
```

```bash
docker run --rm catalog-service:slim which yarn  || echo "yarn not found - good"
```

```bash
docker run --rm catalog-service:slim which git   || echo "git not found - good"
```

If any of these *do* exist in your prod image, you have either too much in the base layer or you're shipping the dev stage by mistake.

---

## BP#8: No OS tools in production

The same logic applies to standard OS utilities:

```bash
docker run --rm catalog-service:slim which curl    || echo "curl not found - good"
```

```bash
docker run --rm catalog-service:slim which wget    || echo "wget not found - good"
```

```bash
docker run --rm catalog-service:slim which apt-get || echo "apt-get not found - good"
```

```bash
docker run --rm catalog-service:slim which sudo    || echo "sudo not found - good"
```

> **Why no `curl`?** An attacker who gets code execution typically uses `curl` or `wget` to download additional payloads - a reverse shell, a crypto miner, a credential stealer. Removing these utilities meaningfully raises the cost of a successful exploit. The attacker now has to write their own networking code from inside the runtime they're stuck with.

> **Why no `apt-get`?** Without a package manager, the attacker can't install anything new - they're limited to whatever is already in the image. With a minimal image, that's almost nothing.

## Attack surface count so far

```bash
docker scout cves catalog-service:slim --format only-packages --org <YOUR_ORG>
```

Where we started: **693 packages** (`node:18`).

Where we are now: **~272 packages** (`node:25-slim`).

Where DHI takes us: **~12 packages**.

Continue to [Continuous Scanning with Scout](/docker-workshop/security/scout-reactive/continuous-scanning), or jump straight to [Migrating to DHI](/docker-workshop/security/dhi-proactive/overview).
