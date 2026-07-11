---
title: "The Isolation Proof"
---

This is the most important module in the lab. Everything else is context. This is the evidence.

You're going to systematically attempt to access sensitive host resources from inside the sandbox - and document exactly what you find. This is not a trick. Run every command. Read every result.

---

## Setup

You need two terminals side by side:

- **Terminal A** - your running sandbox session (`sbx run sbxlab`)
- **Terminal B** - your host, for comparison

---

## Part 1 - What the agent can see

Run these commands **inside the sandbox** (Terminal A):

### 1a. Try to access AWS credentials

```bash
cat ~/.aws/credentials
ls -la ~/.aws/
```

Real output:

```
cat: /home/agent/.aws/credentials: No such file or directory

ls: cannot access '/home/agent/.aws/': No such file or directory
```

### 1b. Try to access SSH keys

```bash
cat ~/.ssh/id_rsa
ls -la ~/.ssh/
```

Real output:

```
cat: /home/agent/.ssh/id_rsa: No such file or directory

ls: cannot access '/home/agent/.ssh/': No such file or directory
```

### 1c. Inspect the agent home directory

```bash
ls -la ~/
pwd
```

Real output:

```
total 56
drwxr-xr-x 1 agent agent 4096 Apr 11 14:48 .
drwxr-xr-x 1 root  root  4096 Apr 11 06:03 ..
-rw------- 1 agent agent   61 Apr 11 14:48 .bash_history
-rw-r--r-- 1 agent agent  223 Apr 11 06:20 .bashrc
drwxr-xr-x 9 agent agent 4096 Apr 11 14:45 .codex
drwxr-xr-x 3 agent agent   46 Apr 11 06:20 .docker
-rw-r--r-- 1 agent agent   99 Apr 11 14:45 .gitconfig
drwxr-xr-x 1 agent agent   27 Apr 11 06:03 workspace

/Users/ajeetraina/sbx-lab
```

Three things to notice:
- Agent home is `/home/agent/` - a clean Linux environment, not your Mac home
- `pwd` shows the exact host path `/Users/ajeetraina/sbx-lab` - preserved as the workspace mount point
- No `.ssh/`, `.aws/`, `.zshrc`, no Mac files anywhere

### 1d. Inspect the scaffolding boundary

```bash
ls /Users/
ls /Users/ajeetraina/
ls /home/
ls /var/run/
```

Real output:

```
/Users/
ajeetraina

/Users/ajeetraina/
AGENTS.md   sbx-lab

/home/
agent   ubuntu

/var/run/
containerd  docker  docker.pid  docker.sock  secrets
```

| Path | What you see | What it means |
|------|-------------|---------------|
| `/Users/ajeetraina/` | Only `AGENTS.md` + `sbx-lab` | Empty scaffolding - directory tree preserved for the workspace path, nothing else from your Mac home exists |
| `/home/` | `agent`, `ubuntu` | Two Linux users, completely separate from your Mac user |
| `/var/run/docker.sock` | Present | The VM's own Docker daemon - separate from your host's |
| `/var/run/secrets` | Present | The credential proxy socket - intercepts outbound API calls and injects your keys |

### 1e. Try to reach the AWS metadata endpoint

```bash
curl -s --connect-timeout 3 http://169.254.169.254/latest/meta-data/
```

Real output:

```
Blocked by network policy: matched rule no applicable policies for op(action=net:connect:tcp,
resource=net:domain:169.254.169.254:80)
```

The Balanced network policy blocks the AWS IMDS endpoint entirely - the most dangerous target for a compromised agent running in a cloud VM.

### 1f. Check the VM identity

```bash
uname -r
cat /etc/os-release
cat /proc/1/cgroup
```

Real output:

```
6.12.44

PRETTY_NAME="Ubuntu 25.10 (Questing Quokka)"
NAME="Ubuntu"
VERSION_ID="25.10"

0::/docker/d65f75fdecab4f730049fd5991cfb82c7a7ff539ec34828b1955021f1f42141c
```

- Kernel `6.12.44` - Linux, not macOS. This is a real VM with its own kernel
- Ubuntu 25.10 - full Linux distro running inside the microVM
- `0::/docker/d65f75fd...` - the `/docker/` prefix confirms the agent runs as a container inside the VM's own Docker daemon

---

## Part 2 - Verify the host is untouched

Switch to **Terminal B** (host):

```bash
cat ~/.aws/credentials    # still here
cat ~/.ssh/id_rsa         # still here
ls -la ~/                 # unchanged
docker ps                 # your host containers - sbxlab never appears
sbx ls                    # sbxlab appears here instead
```

Everything that doesn't exist inside the VM is alive and well on the host.

---

## Part 3 - Guardrails vs sbx: why you need both

You might wonder: if the model refuses to print credentials, why does the sandbox matter?

**Because guardrails and sbx defend different threats.**

| Threat | Model guardrails | sbx |
|--------|-----------------|-----|
| Model refuses a direct bad request | ✅ Blocked | ❌ Not its job |
| Prompt injection in a README or code file | ❌ May comply - looks like a task | ✅ File doesn't exist |
| Jailbroken model | ❌ Guardrails bypassed | ✅ VM boundary holds |
| Model with no safety training | ❌ No protection | ✅ Same isolation |
| Agent runs `rm -rf` outside workspace | ❌ Depends on model | ✅ Impossible - not mounted |
| Agent exfiltrates to attacker URL | ❌ Depends on model | ✅ Blocked by network policy |

**Guardrails are a bet on the model.** They work when the model is well-behaved, well-trained, and not under adversarial pressure. Change the model, jailbreak it, or hide the instruction in a file the agent reads - and the guardrails disappear.

**sbx is a technical guarantee.** The VM boundary is enforced by the hypervisor, not the model. It holds regardless of what the model does, what prompt it receives, or how it was trained.

> The right mental model: use guardrails to make agents well-behaved. Use sbx to limit the blast radius when they're not.

---

## Part 4 - The architecture

```
macOS host (L0)
│
├── Your files, credentials, Docker daemon   ← outside the VM
│
└── sbxlab (microVM, own Linux kernel)
    │
    ├── Only ~/sbx-lab workspace mounted      ← the only shared thing
    ├── Private Docker daemon                 ← completely separate
    └── Outbound HTTP proxy (/var/run/secrets)
        │
        ├── Injects API key on outbound calls  ← agent never sees the key
        ├── Blocks 169.254.169.254             ← AWS IMDS unreachable
        └── Balanced policy: allows dev sites, blocks everything else
```

The key technical fact: **the VM has its own kernel**. A container escape would still be inside the VM. There is no path from the VM's userspace to your host's userspace - the hypervisor enforces that boundary in hardware.

---

## ✅ Checkpoint

You've now empirically proven the isolation guarantee with real commands and real output:

- `~/.aws/credentials` → `No such file or directory`
- `~/.ssh/id_rsa` → `No such file or directory`
- `169.254.169.254` → `Blocked by network policy`
- `uname -r` → Linux kernel `6.12.44`, not macOS
- `cat /proc/1/cgroup` → `/docker/...` - agent runs in VM's own Docker daemon

Not taken Docker's word for it. Proven it yourself.

Next: how secrets are handled without ever entering the VM.
