---
title: "---- Build stage: the -dev variant has a shell and npm ----"
---

## Migrating to a Hardened Image

You know the image you want: the DHI **Node.js** variants. Now you'll rewrite the Dockerfile into a **multi-stage build** that uses the `-dev` variant to install dependencies and the minimal **distroless** runtime variant to actually run the app.

:::note
The Dockerfile below pulls hardened images directly from the DHI registry at **`dhi.io`**. Make sure you're authenticated (`docker login dhi.io`) with an account entitled to Docker Hardened Images.
:::

## ✍️ Step 1: Rewrite the Dockerfile

Replace the contents of `Dockerfile` with this hardened, multi-stage version:

```dockerfile

FROM dhi.io/node:20-debian12-dev AS build

WORKDIR /app

COPY package*.json ./
RUN npm install --omit=dev

COPY src ./src

# ---- Runtime stage: minimal, distroless, non-root, no shell ----
FROM dhi.io/node:20-debian12 AS runtime

WORKDIR /app

# Bring over only what's needed to run the app.
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/src ./src
COPY --from=build /app/package.json ./package.json

EXPOSE 3000

# Invoke node explicitly. Use exec form so the app is PID 1 and receives signals.
CMD ["node", "src/server.js"]
```

What changed — and why it matters:

- **Multi-stage** — build tooling (`npm`, shell) lives only in the `build` stage and never ships to production.
- **Distroless runtime** — the final image has *no shell and no package manager*. Even with code execution, an attacker can't drop into a shell.
- **Non-root by default** — DHI runtime images run as an unprivileged user out of the box.

## 🏗️ Step 2: Build the hardened image

```bash
docker build -t product-catalog:hardened .
```

## 🚀 Step 3: Run it and confirm it still works

```bash
docker run -d --rm --name catalog-hardened -p 8090:3000 product-catalog:hardened && \
sleep 2 && curl -s http://localhost:8090/health
```

Open it again in your browser at [http://localhost:8090](http://localhost:8090) to be sure.

Then stop it:

```bash
docker stop catalog-hardened
```

## 📉 Step 4: Compare the results

Look at the size difference between the vulnerable build and the hardened one:

```bash
docker images 'product-catalog' --format 'table {{.Repository}}:{{.Tag}}\t{{.Size}}'
```

And re-scan to confirm the CVEs are gone:

```bash
docker scout quickview product-catalog:hardened
```

:::tip
You just turned a sprawling, root-running, hundreds-of-CVEs image into a small, non-root, near-zero-CVE one — without changing a line of application code. That's the whole point of starting from a hardened base.
:::

The image is secure. Next, you'll **prove** it by inspecting the attestations baked into the DHI. ➡️
