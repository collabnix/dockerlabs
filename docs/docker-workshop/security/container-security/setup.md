---
title: "Setup"
---

## Setup

Before you begin, you'll need a Docker Hub account, Docker Desktop installed (4.40+ recommended), and access to a Docker organization. Throughout this workshop, replace `<YOUR_ORG>` with your actual Docker Hub organization name.

## Step 1. Choose your DHI tier

Docker Hardened Images are available in two tiers:

| Tier | Registry | Requirements |
|------|----------|--------------|
| **Free** | `dhi.io/node:...` | No Docker Hub subscription needed |
| **Paid** | `<YOUR_ORG>/dhi-node:...` | Paid plan with images mirrored into your org |

> **How to choose?** Use the free tier (`dhi.io`) unless you have a paid plan with `dhi-node` already mirrored. Throughout the DHI sections, replace `<DHI_PREFIX>` with either `dhi.io/` (free) or `<YOUR_ORG>/dhi-` (paid).

## Step 2. Docker login

```bash
docker login
```

If you're using the free DHI tier, also log in to the `dhi.io` registry:

```bash
docker login dhi.io
```

You should see `Login Succeeded` after each.

## Step 3. Configure Docker Scout organization

```bash
docker scout config organization <YOUR_ORG>
```

This makes Scout output policy results aligned to your organization's configuration. To learn more, see the [Docker Scout Policy guides](https://docs.docker.com/scout/policy/).

## Step 4. Clone and bootstrap the project

The setup script applies a patch that **deliberately introduces a vulnerable state** - old base image and downgraded dependencies - so you can demonstrate the full security journey from the bottom up.

```bash
git clone https://github.com/dockersamples/catalog-service-node
cd catalog-service-node
./demo/sdlc-e2e/setup.sh
```

Clean up any leftover containers from previous runs:

```bash
docker rm $(docker ps -a -q) -f
```

Install Node dependencies:

```bash
npm install
```

## Step 5. Pre-build the initial image

Build the (deliberately vulnerable) starting image so Scout has something to analyse:

```bash
docker build -t catalog-service --sbom=true --provenance=mode=max .
```

The `--sbom=true` and `--provenance=mode=max` flags tell BuildKit to attach a Software Bill of Materials and SLSA provenance attestations to the image. We'll use these in later sections.

You're all set! Continue to [Surface the Problem](/docker-workshop/security/container-security/surface-the-problem) to see what's wrong with the starting image - or jump directly to any of the [8 best practices](/docker-workshop/security/container-security/overview#the-8-container-security-best-practices).
