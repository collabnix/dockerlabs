---
title: "Setup"
---

Welcome to the Docker AI Governance lab.

Over the next two hours you'll prove how Docker AI Governance policies flow from a single Admin Console toggle to every developer's `sbx` (Docker Sandboxes) sandbox, covering both **network** and **filesystem** enforcement.

**Define once. Enforce everywhere.**

:::tip[Run the interactive Labspace]
This lab is also available as a self-contained, click-to-run **Labspace** at
[github.com/ajeetraina/labspace-ai-governance](https://github.com/ajeetraina/labspace-ai-governance).
It ships the terminals, the audit dashboard, and all supporting assets in one repo:

```bash
git clone https://github.com/ajeetraina/labspace-ai-governance
cd labspace-ai-governance
bash start-labspace.sh
```

Then open [http://localhost:3030](http://localhost:3030). The pages that follow mirror that
Labspace content, adapted for this workshop.
:::

---

## Pick your organization

Most commands and links in this lab reference your Docker Hub organization. Throughout the lab we use the placeholder `<your-org>` - substitute it with the name of an organization where you have **admin** rights (for example `whalecollab`).

:::tip[Set this once]
Decide on the org you'll use now and keep it consistent. If you're a member of multiple organizations, make sure the one you pick is where you have admin rights - otherwise you won't be able to set policies in the Network and Filesystem demos.
:::

If you don't have an organization yet, you can still walk through Setup, *Why AI Governance*, and *The Policy Model* conceptually - the demo sections need org-level admin access to add policy rules.

---

## What you need

- **Docker Desktop** with `sbx` (Docker Sandboxes) installed and on your `$PATH`
- **Admin access** to a Docker Hub organization so you can configure AI governance policies
- **A terminal** on your host machine

---

## Quick check

Verify `sbx` is installed:

```bash
sbx version
```

Verify you're logged in to Docker with your org credentials:

```bash
docker login
```

When you're ready, move on to **Why AI Governance**.
