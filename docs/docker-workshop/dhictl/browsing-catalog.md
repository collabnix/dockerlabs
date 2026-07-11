---
title: "Browsing the DHI Catalog"
---

## Browsing the DHI Catalog

Time to bring in `dhictl`. Before you can rewrite the Dockerfile, you need to know **which** hardened image to use and what tags are available. That's what the `catalog` command group is for.

## 🔑 Step 1: Authenticate

The catalog, mirror, and customization commands talk to Docker's DHI service on behalf of your organization, so they need a Docker access token and an org name.

:::info
These steps require a Docker Hub organization with a **Docker Hardened Images subscription**. Generate a Personal Access Token at **Docker Hub → Account Settings → Personal access tokens**. If you don't have DHI access yet, read along — the expected output is shown below each command.
:::

Export your credentials in the terminal (replace the placeholders with your real token and organization name):

```bash
export DHI_API_TOKEN="dckr_pat_xxxxxxxxxxxxxxxxxxxx"
export DHI_ORG="<YOUR_ORG_NAME>"
```

Finally, log in to the DHI registry so you can pull hardened images from `dhi.io` later in the lab:

```bash
docker login dhi.io
```

## 🗂️ Step 2: List the catalog

See every hardened image available to you:

```bash
docker dhi catalog list
```

You can narrow it down. Filter to just the images (not other artifact types):

```bash
docker dhi catalog list --type image
```

Or search by name — you want Node.js:

```bash
docker dhi catalog list --filter node
```

:::tip
Add `--fips` to see only FIPS-validated images, which matter for regulated environments.
:::

## 🔍 Step 3: Inspect the Node.js image

Now get the details for the `node` repository — its available tags and, crucially, the **CVE count per tag**:

```bash
docker dhi catalog get node
```

You'll see tags such as `node:20-debian12-dev` (a build variant that includes a shell and `npm`) and `node:20-debian12` (a minimal, **distroless** runtime variant). Notice the CVE counts:

```plaintext
TAG                     CVES (C/H/M/L)
20-debian12             0 / 0 / 0 / 0
20-debian12-dev         0 / 0 / 0 / 0
22-debian13             0 / 0 / 0 / 0
...
```

Compare that to the wall of CVEs `docker scout` just showed you for `node:18-slim`. Same language runtime, radically smaller attack surface.

## 🧩 Two variants, one pattern

| Variant | Contains | Use it for |
| --- | --- | --- |
| `…-dev` | shell, `npm`, build tools | the **build** stage (`npm ci`) |
| runtime (no suffix) | just the Node.js runtime, **no shell** | the **final** stage your app runs in |

This dev/runtime split is the key to a secure multi-stage build — and it's exactly what you'll write next. ➡️
