---
title: "Introducing Vulnerabilities"
---

## Introducing Vulnerabilities

Imagine a teammate, chasing a compatibility issue, pins the service to an **older Node.js base image** and merges it. It builds. Tests pass. Nobody notices that the image now ships with hundreds of additional known vulnerabilities.

You're going to reproduce that mistake on purpose, then **measure** it.

## 💥 Step 1: Downgrade the base image

A small script rewrites the Dockerfile's base image from `node:22` to the older `node:18`. Take a quick look at what it does:

- Open `scripts/introduce-vulnerabilities.sh`

Then run it:

```bash
bash scripts/introduce-vulnerabilities.sh
```

Confirm the change landed:

```bash
grep '^FROM' Dockerfile
```

The base image should now read `FROM node:18-slim`. 😬

## 🏗️ Step 2: Rebuild the vulnerable image

```bash
docker build -t product-catalog:vulnerable .
```

## 🔬 Step 3: Scan it with Docker Scout

`docker scout` reports the known CVEs in an image. Scanning needs to download advisory data, so log in to Docker Hub first if you haven't already.

```bash
docker login
```

Now get a quick overview:

```bash
docker scout quickview product-catalog:vulnerable
```

And list the actual CVEs, sorted by severity:

```bash
docker scout cves --only-severity critical,high product-catalog:vulnerable
```

:::warning
That's a lot of red. Almost none of these vulnerabilities are in *your* code — they're inherited from a bloated, out-of-date base image. This is exactly the problem Docker Hardened Images are designed to eliminate.
:::

## 🧠 Why this happens

A general-purpose base like `node:18-slim` carries a full Linux userland — shells, package managers, libraries — most of which your app never uses. Every one of those packages is attack surface, and older tags stop receiving patches.

Instead of *removing* things from a big image and hoping you got them all, the hardened approach is to **start from a minimal, maintained image**. That's what you'll do next — and `dhictl` is how you find the right one. ➡️
