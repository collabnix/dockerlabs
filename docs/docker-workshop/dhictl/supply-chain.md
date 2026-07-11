---
title: "Supply Chain & dhictl Capabilities"
---

## Supply Chain & dhictl Capabilities

A small image with no CVEs is great — but in a real supply chain you also need to **prove** what's inside an image and where it came from. Every DHI ships with signed **attestations**: an SBOM (software bill of materials) and SLSA build provenance. `dhictl` reads them.

## 📜 Step 1: List the attestations on your image

Attestations are attached to an image as OCI referrers. List what's available for the runtime image you adopted:

```bash
docker dhi attestation list dhi.io/node:20-debian12
```

You can scope it to a single platform:

```bash
docker dhi attestation list dhi.io/node:20-debian12 --platform linux/amd64
```

## 🧾 Step 2: Read the SBOM

The SBOM lists every package in the image — the ground truth for any vulnerability scan or license audit:

```bash
docker dhi attestation sbom dhi.io/node:20-debian12
```

## 🔐 Step 3: Pull a full attestation

Grab a specific attestation by its digest (copy one from the `attestation list` output) to see the raw, signed provenance:

```bash
docker dhi attestation get dhi.io/node:20-debian12 sha256:<digest>
```

This is your SLSA provenance — verifiable evidence of how and where the image was built.

## 🏭 Step 4: Mirror images into your org

Need a DHI image in your own registry namespace? `mirror` copies it into your Docker Hub org so your builds pull from a repo you control. You can mirror several at once with repeated `-r source,destination` flags:

```bash
docker dhi mirror start --org <YOUR_ORG_NAME> -r dhi.io/node,<YOUR_ORG_NAME>/dhi-node
```

Check what's mirrored, and stop one when you're done:

```bash
docker dhi mirror list --org <YOUR_ORG_NAME>
```

```bash
docker dhi mirror stop --org <YOUR_ORG_NAME> dhi-node
```

## 🧰 Step 5: Customize a hardened image

Sometimes the minimal image is *too* minimal — maybe your app needs `curl` or a CA bundle, or you want to set an env var or a specific user. `dhictl customization` lets you tailor a DHI without giving up its security properties.

1. Generate a starting customization file from the base image:

    ```bash
    docker dhi customization prepare --org <YOUR_ORG_NAME> node 20 --destination <YOUR_ORG_NAME>/dhi-node-custom
    ```

2. Open the generated YAML and add what you need — extra `packages`, `environment` variables, an `entrypoint`, or a non-root account under `accounts`.

3. Create the customization (which kicks off a build):

    ```bash
    docker dhi customization create --org <YOUR_ORG_NAME> my-customization.yaml
    ```

4. Watch the build and read its logs:

    ```bash
    docker dhi customization build list --org <YOUR_ORG_NAME> <customization-id>
    ```

    ```bash
    docker dhi customization build logs --org <YOUR_ORG_NAME> <customization-id> <build-id>
    ```

The result is your own hardened, customized image — minimal, signed, and built to your org's needs.

## 🎉 Wrap-up

You took a real service from vulnerable to verifiable:

- 🐳 Built the **Product Catalog** and established a baseline
- 💥 **Introduced CVEs** by downgrading the base image, and measured them with `docker scout`
- 🗂️ Used **`dhictl catalog`** to find a hardened Node.js image with near-zero CVEs
- 🛡️ **Migrated** to a multi-stage, distroless, non-root **DHI** build — smaller and dramatically safer
- 📜 Verified the supply chain with **`dhictl attestation`** (SBOM + SLSA provenance)
- 🏭 Saw how to **mirror** and **customize** DHIs for your own organization

### Where to go next

- 📚 Explore the full CLI reference: [github.com/docker-hardened-images/dhictl](https://github.com/docker-hardened-images/dhictl)
- 🔍 Learn more about Docker Hardened Images on [Docker Docs](https://docs.docker.com/dhi/)
- 🧪 Try customizing the Product Catalog's own image with `dhictl customization` and an added package

Thanks for hardening with us. Ship secure. 🚀
