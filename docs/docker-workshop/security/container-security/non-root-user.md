---
title: "BP#3: Non-Root User"
---

## Best Practice #3: Non-Root User

> **Never run containers as root.** Root inside a container is effectively root on the host if isolation fails.

By default, Docker containers run as `root` (UID 0). If an attacker exploits your app, they get root-level access inside the container - and potentially on the host if the container is misconfigured or running with a privileged socket.

## Why this matters

A container is just a Linux process with namespaces around it. If an attacker:

1. Gets code execution inside your container, AND
2. The container is running as root, AND
3. The container has access to a privileged resource (mounted Docker socket, `--privileged` flag, host volume, kernel exploit)

…then root-in-container can become root-on-host. Running as a non-root user is one of the cheapest, most effective mitigations available.

## Three ways to enforce non-root

### Option A - In the Dockerfile (recommended)

This is what we already have in our `Dockerfile`:

```dockerfile
RUN useradd -m appuser && chown -R appuser /usr/local/app
USER appuser
```

Setting `USER` in the Dockerfile means **every** invocation of the image runs as `appuser` by default. No flag required at `docker run` time, no chance of someone forgetting.

### Option B - At `docker run` time

You can override the user when starting a container:

```bash
docker run --rm --user 1000:1000 catalog-service:slim \
    node -e "console.log(process.getuid())"
```

Expected output: `1000` - not `0`.

### Option C - In `docker compose`

```yaml
services:
  catalog:
    build: .
    user: "${CURRENT_UID}"
```

Use the host user's UID/GID - particularly useful for development where bind-mounted volumes need to match host file ownership.

## Verify the running user

```bash
docker run --rm catalog-service:slim whoami
```

Expected output: `appuser` - not `root`.

## The hardened `docker init` pattern

When you run `docker init` in a new project, Docker scaffolds this hardened pattern automatically:

```dockerfile
ARG UID=10001
RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/nonexistent" \
    --shell "/sbin/nologin" \
    --no-create-home \
    --uid "${UID}" \
    appuser
USER appuser
```

Extra hardening in this version:

- No home directory
- No login shell
- No password
- High UID (10001) to avoid colliding with host users

## Confirm Scout policy

```bash
docker scout quickview catalog-service:slim --org <YOUR_ORG>
```

Look for `Default non-root user` in the policy output - it should show ✓.

Continue to [BP#4: Read-Only Filesystem + Drop Capabilities](/docker-workshop/security/container-security/readonly-capabilities).
