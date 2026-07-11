---
title: "Introduction & Setup"
---

## Introduction & Setup

👋 Welcome! In this lab you'll play the part of a developer who owns a small **Product Catalog** service. Things start out fine — then a seemingly innocent change quietly drags in a pile of known vulnerabilities. You'll **measure the damage**, then use **`dhictl`** and **Docker Hardened Images (DHI)** to fix it properly and prove your supply chain is trustworthy.

By the end, you will be able to:

- 🔎 Surface the CVEs hiding in a "normal" container image
- 🗂️ Browse and compare hardened base images with **`dhictl catalog`**
- 🛡️ Migrate a Dockerfile to a **Docker Hardened Image** and watch the attack surface collapse
- 📜 Inspect SBOMs and SLSA provenance with **`dhictl attestation`**
- 🏭 Mirror and customize DHI images for your own organization

## 🤔 What is a Docker Hardened Image?

A **Docker Hardened Image (DHI)** is a minimal, secure, production-ready base or application image maintained by Docker. DHIs are built to be small (less to attack), come with **near-zero known CVEs**, run as **non-root**, and ship with cryptographically signed **attestations** — SBOMs, VEX, and SLSA provenance — so you can prove what's inside and where it came from.

## 🛠️ What is `dhictl`?

`dhictl` is the command-line tool for working with DHI. It lets you:

| Command group | What it does |
| --- | --- |
| `catalog` | Browse available hardened images, tags, and CVE counts |
| `mirror` | Mirror DHI images into your own Docker Hub organization |
| `customization` | Add packages, users, env vars, entrypoints to a DHI and build it |
| `attestation` | Inspect SBOMs and SLSA provenance attached to an image |

## ✅ Step 1: Verify your environment

First, confirm Docker is working in your workspace.

```bash
docker version
```

You should see both a **Client** and **Server** section reported.

## ⬇️ Step 2: Install `dhictl` as a Docker CLI plugin

`dhictl` ships as a single binary. Installing it into the Docker CLI plugins directory lets you call it as `docker dhi`. The command below auto-detects your architecture and downloads the latest release.

```bash
ARCH=$(uname -m); case "$ARCH" in x86_64) ARCH=amd64;; aarch64|arm64) ARCH=arm64;; esac && \
mkdir -p "$HOME/.docker/cli-plugins" && \
curl -sSL -o "$HOME/.docker/cli-plugins/docker-dhi" \
  "https://github.com/docker-hardened-images/dhictl/releases/download/v0.0.4/dhictl-linux-${ARCH}" && \
chmod +x "$HOME/.docker/cli-plugins/docker-dhi" && \
echo "✅ Installed dhictl for linux/${ARCH}"
```

## ✅ Step 3: Confirm the plugin is available

```bash
docker dhi --help
```

You should see the top-level `dhictl` help listing the `catalog`, `mirror`, `customization`, and `attestation` command groups.

:::tip
Throughout this lab you'll invoke the tool as `docker dhi …`. If you prefer the standalone form, the same commands work as `dhictl …` — they're the identical binary.
:::

When you can see the help output, you're ready to meet the app. ➡️
