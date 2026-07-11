---
title: "Meet the Product Catalog"
---

## Meet the Product Catalog

The service you'll be hardening is a small **Express** REST API that returns a catalog of (very important) Docker merchandise. Let's get it running before you change anything, so you have a known-good baseline.

## 👀 Step 1: Explore the project

Take a look at the application entry point and the Dockerfile that builds it:

- Open `src/server.js` — the API. Note it's hard-coded to **port 3000**.
- Open `Dockerfile` — a single-stage build on `node:22-slim`, running as **root**.

```bash
cat Dockerfile
```

This is a typical starting point: a general-purpose base image, `npm install`, and a `CMD`. It works — but it isn't minimal and it isn't hardened.

## 🏗️ Step 2: Build the image

Build the catalog and tag it `product-catalog:baseline` so you can compare against it later.

```bash
docker build -t product-catalog:baseline .
```

## 🚀 Step 3: Run it

```bash
docker run -d --rm --name catalog -p 8090:3000 product-catalog:baseline
```

:::note
The app listens on port **3000 inside the container**, but the lab environment already uses some host ports (3000 and 8085) so you publish it on host port **8090** (`-p 8090:3000`) and reach it at `localhost:8090`. If `8090` is busy too, pick another free port (e.g. `9095`) and use it consistently for the run command and URLs below.
:::

Give it a second to boot, then check it's healthy:

```bash
curl -s http://localhost:8090/health
```

You should get back `{"status":"ok",...}`.

## 🛒 Step 4: Open the catalog

Open the running app in your browser at [http://localhost:8090](http://localhost:8090).

You can also hit the JSON API directly:

```bash
curl -s http://localhost:8090/products | head -c 400; echo
```

## 📏 Step 5: Note the baseline size

```bash
docker images product-catalog:baseline
```

Jot that number down — you'll watch it shrink dramatically once you adopt a Docker Hardened Image.

## 🧹 Step 6: Stop the container

```bash
docker stop catalog
```

The app works and you have a baseline. Now let's see what happens when a well-meaning change goes wrong. ➡️
