---
title: "Overview"
---

## Docker Hardened Images

Docker Hardened Images are Secure, Minimal, Production-Ready Images with near-zero CVEs and enterprise-grade SLA for rapid remediation. 

These images follow a distroless philosophy, removing unnecessary components to significantly reduce the attack surface. The result? Smaller images that pull faster, run leaner, and provide a secure-by-default foundation for production workloads:

- **Near-zero exploitable CVEs:** Continuously updated, vulnerability-scanned, and published with signed attestations to minimize patch fatigue and eliminate false positives.
- **Seamless migration:** Drop-in replacements for popular base images, with `-dev` variants available for multi-stage builds.
- **Up to 95% smaller attack surface:** Unlike traditional base images that include full OS stacks with shells and package managers, distroless images retain only the essentials needed to run your app.
- **Built-in supply chain security:** Each image includes signed SBOMs, VEX documents, and SLSA provenance for audit-ready pipelines.

[Docker Hardened Images](https://www.docker.com/products/hardened-images/) lists the enterprise-ready, secure container images with built-in compliance and minimal vulnerabilities.

## Workshop Structure

This workshop walks you through the end-to-end migration of a Node.js application from a standard community base image to Docker Hardened Images. You'll learn how to mirror DHI images, scan and compare images using Docker Scout, and leverage built-in attestations for compliance.

| Section | Description |
|---------|-------------|
| [Getting Started](/docker-workshop/lab9/dhi/getting-started) | Mirror a DHI Node image and set up Docker Scout |
| [Image Scanning](/docker-workshop/lab9/dhi/image-scanning) | Build and scan a Node.js app with Docker Scout |
| [Switch to DHI](/docker-workshop/lab9/dhi/switch-to-dhi) | Migrate from community images to Docker Hardened Images |
| [Compliance & Attestations](/docker-workshop/lab9/dhi/compliance) | Explore DHI attestations, FIPS compliance, and scanner integration |

> This workshop is based on the [labspace-dhi-node](https://github.com/dockersamples/labspace-dhi-node) labspace.

## The Sample Application

The demo application used in this workshop is a simple Hello World Node.js server. The source code is available in the [labspace-dhi-node](https://github.com/dockersamples/labspace-dhi-node) repository.

**app.js:**

```javascript
const http = require('http');

const port = 3000;

const server = http.createServer((req, res) => {
  if (req.url === '/' && req.method === 'GET') {
    res.writeHead(200, { 'Content-Type': 'text/plain' });
    res.end('Hello World!');
  } else {
    res.writeHead(404);
    res.end('Not Found');
  }
});

server.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
```

**Dockerfile (starting point):**

```dockerfile
FROM node:24-trixie-slim AS dev

ENV BLUEBIRD_WARNINGS=0 \
NODE_ENV=production \
NODE_NO_WARNINGS=1 \
NPM_CONFIG_LOGLEVEL=warn \
SUPPRESS_NO_CONFIG_WARNING=true

WORKDIR /app

COPY package.json ./

RUN apt-get update \
 && apt-get install -y --no-install-recommends npm \
 && npm install --no-optional \
 && npm cache clean --force \
 && apt-get remove -y npm \
 && apt-get autoremove -y \
 && rm -rf /var/lib/apt/lists/*

COPY . .


#-- Prod stage --
FROM node:24-trixie-slim AS prod

WORKDIR /app

COPY --from=dev /app /app

ENTRYPOINT ["node"]
CMD ["app.js"]
EXPOSE 3000
```

The Dockerfile takes a multi-stage build approach and is based on the `node:24-trixie-slim` image. As you'll see in the next sections, this base image comes with CVEs and fails several Docker Scout policies - which is exactly where DHI comes into play.
