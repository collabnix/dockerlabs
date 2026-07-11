---
title: "BP#4: Read-Only + Drop Capabilities"
---

## Best Practice #4: Read-Only Filesystem + Drop Capabilities

> **Defence in depth:** Even if an attacker gains code execution, a read-only container with dropped Linux capabilities severely limits what they can do next.

This is the "even if everything else fails" layer. Assume your app has a vulnerability. Assume the attacker gets code execution. What can they do?

If the filesystem is writable and capabilities are intact: drop a payload, modify config, install a backdoor, escalate.

If the filesystem is read-only and capabilities are dropped: almost nothing.

## Linux capabilities - what gets dropped with `--cap-drop=ALL`

Linux capabilities split root's privileges into discrete chunks. Most apps need none of them. Dropping them all closes huge attack paths:

| Capability | What it allows |
|------------|----------------|
| `CHOWN` | Change file UIDs/GIDs |
| `DAC_OVERRIDE` | Bypass file read/write/execute permission checks |
| `NET_RAW` | Raw and packet sockets (used in some network attacks) |
| `SETUID` / `SETGID` | Change process UID/GID |
| `SYS_CHROOT` | `chroot()` - change root directory |
| `KILL` | Send signals to other processes |
| `MKNOD` | Create special files |

## Step 1 - Clean up any leftover containers

Run this first every time. It removes any containers from a previous attempt so names and ports are free.

```bash
docker rm -f catalog-hardened catalog-hardened-tmpfs 2>/dev/null
```

## Step 2 - Run with hardened flags

```bash
docker run \
    -d \
    -p 3100:3000 \
    --read-only \
    --cap-drop=ALL \
    --user=65532 \
    --name catalog-hardened \
    catalog-service:slim
```

Verify the container is up:

```bash
docker ps --filter name=catalog-hardened
```

Confirm the app responds:

```bash
curl http://localhost:3100
```

## Step 3 - Verify the filesystem is read-only

Try to write a file inside the container:

```bash
docker exec catalog-hardened sh -c "echo test > /tmp/test.txt"
```

Expected output: `sh: /tmp/test.txt: Read-only file system`

The attacker gained code execution but **cannot write anywhere** - no dropping payloads, no modifying config files, no creating SUID binaries.

## Step 4 - Prove the capability drop

```bash
docker inspect catalog-hardened \
    --format 'ReadonlyRootfs={{.HostConfig.ReadonlyRootfs}} CapDrop={{.HostConfig.CapDrop}}'
```

Expected output:

```text
ReadonlyRootfs=true CapDrop=[ALL]
```

## Step 5 - When your app needs a writable area: use `tmpfs`

Some apps genuinely need scratch space - caches, temp files, sessions. `tmpfs` is in-memory only - writable, but never persisted to disk and gone when the container stops:

```bash
docker run \
    -d \
    -p 3101:3000 \
    --read-only \
    --tmpfs /tmp:noexec,nosuid,size=64m \
    --cap-drop=ALL \
    --user=65532 \
    --name catalog-hardened-tmpfs \
    catalog-service:slim
```

Verify `/tmp` is writable but everything else is still read-only:

```bash
docker exec catalog-hardened-tmpfs sh -c "echo test > /tmp/test.txt && cat /tmp/test.txt"
```

Note the extra `tmpfs` flags:

- `noexec` - files in `/tmp` cannot be executed (blocks payload drop-and-run)
- `nosuid` - SUID bits on files in `/tmp` are ignored (blocks privilege escalation via dropped binaries)
- `size=64m` - caps memory usage to 64 MB (prevents tmpfs DoS)

## Step 6 - Clean up

```bash
docker rm -f catalog-hardened catalog-hardened-tmpfs
```

Continue to [BP#6, #7, #8: Secrets and Limiting Tools](/docker-workshop/security/container-security/secrets-and-tools).
