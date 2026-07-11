---
title: "Pre-flight Checklist"
---

Before starting the lab, confirm your environment is ready. Every exercise depends on `sbx` running correctly on your host machine. **Do not skip this section.**

---

## Requirements

| Requirement | Platform |
|---|---|
| macOS Apple Silicon (M1/M2/M3/M4) | ✅ Fully supported |
| Linux x86_64 (Ubuntu 22.04+, KVM access) | ✅ Supported |
| macOS Intel | ❌ Not supported |
| Windows 11 x86_64 | ⚠️ Supported, some exercises differ |

---

## Step 1 - Verify sbx is installed

Open a terminal on your host machine and run:

```bash
sbx version
```

Expected output: a version string like `sbx 0.21.0` or similar.

If you see `command not found`, install sbx first:

```bash
# macOS
brew install docker/tap/sbx

# Linux
curl -fsSL https://get.docker.com | sudo REPO_ONLY=1 sh
sudo apt-get install docker-sbx
sudo usermod -aG kvm $USER
newgrp kvm
```

---

## Step 2 - Log in to Docker

```bash
sbx login
```

The CLI prints a one-time device confirmation code and a URL:

```
Your one-time device confirmation code: XXXX-XXXX
Open this URL to sign in: https://login.docker.com/activate?user_code=XXXX-XXXX

By logging in, you agree to our Subscription Service Agreement.
For more details, see https://www.docker.com/legal/docker-subscription-service-agreement/

Waiting for authentication...
Signed in as <your-docker-username>.
Daemon started (PID: XXXXX, socket: ~/Library/Application Support/com.docker.sandboxes/sandboxd/sandboxd.sock)
Logs: ~/Library/Application Support/com.docker.sandboxes/sandboxd/daemon.log
```

Open the URL in your browser - the CLI confirms sign-in automatically.

### Choose a network policy

```
Select a default network policy for your sandboxes:

     1. Open         - All network traffic allowed, no restrictions.
  ❯  2. Balanced     - Default deny, with common dev sites allowed.
     3. Locked Down  - All network traffic blocked unless you allow it.

  Use ↑/↓ or 1–3 to navigate, Enter to confirm, Esc to cancel.

Network policy set to "Balanced". Default deny, with common dev sites allowed.
```

| Policy | When to use |
|--------|-------------|
| Open | Local dev, no external exposure concerns |
| **Balanced** | **Recommended - least privilege without breaking typical dev workflows** |
| Locked Down | High-security or air-gapped environments |

> **Note:** This policy applies to all sandboxes on this machine. Change it anytime with `sbx policy reset`.

---

## Step 3 - Choose your agent and provider

This lab works with any mainstream coding agent. Pick the provider whose API key you have - the rest of the lab will adapt.

:::tip[Pick a provider for the rest of this lab]
Each option below assumes you've chosen one of these:

- **Use OpenAI + Codex**
- **Use Anthropic + Claude**
- **Use Google + Gemini**
:::

&nbsp;

:::note[If you chose OpenAI + Codex]

### OpenAI configuration

You'll run **Codex** inside the sandbox, authenticated to OpenAI.

**First, export your API key in your host terminal** (don't paste it into this page):

```bash
export OPENAI_API_KEY=sk-proj-...    # your real key, set in your own shell
```

If you're using Windows:

```bash 
$ env:OPENAI_API_KEY = "sk-proj-..."
```

Then store it as a global sbx secret. The command below reads `$OPENAI_API_KEY` from your shell - your key never leaves the terminal and is not displayed anywhere:

```bash
echo "$OPENAI_API_KEY" | sbx secret set -g openai
```
:::

:::note[If you chose Anthropic + Claude]

### Anthropic configuration

You'll run **Claude Code** inside the sandbox, authenticated to Anthropic.

**First, export your API key in your host terminal** (don't paste it into this page):

```bash
export ANTHROPIC_API_KEY=sk-ant-...    # your real key, set in your own shell
```

```bash 
$ env:ANTHROPIC_API_KEY = "sk-ant-..."
```

Then store it as a global sbx secret. The command below reads `$ANTHROPIC_API_KEY` from your shell - your key never leaves the terminal and is not displayed anywhere:

```bash
echo "$ANTHROPIC_API_KEY" | sbx secret set -g anthropic
```
:::

:::note[If you chose Google + Gemini]

### Gemini configuration

You'll run **Gemini CLI** inside the sandbox, authenticated to Google.

**First, export your API key in your host terminal** (don't paste it into this page):

```bash
export GOOGLE_API_KEY=AIza...    # your real key, set in your own shell
```

```bash 
$ env:GEMINI_API_KEY = "AIza..."
```

Then store it as a global sbx secret. The command below reads `$GOOGLE_API_KEY` from your shell - your key never leaves the terminal and is not displayed anywhere:

```bash
echo "$GOOGLE_API_KEY" | sbx secret set -g google
```
:::

> **Why not type the key into this page?** Labspace renders anything you enter into an input field inline in the command below it - so the raw key becomes visible in the lab UI and in screenshots. Setting the env var in your own shell keeps the key off the page entirely.

Verify the secret was stored:

```bash
sbx secret ls
```

Expected output: a line matching your chosen provider (`openai`, `anthropic`, or `google`) with the value masked as `****...****`.

> **Why this matters:** Secrets are stored in your OS keychain and injected at the network proxy layer. The agent never sees the raw API key. This is one of the core governance guarantees you'll explore in Module 4.

---

## Step 4 - Clone the lab repository

The exercises use DevBoard - a full-stack FastAPI + Next.js issue tracker with intentional bugs. It's pre-configured for this lab.

```bash
git clone https://github.com/dockersamples/sbx-quickstart ~/sbx-lab
cd ~/sbx-lab
```

---

## Step 5 - Create your sandbox

```bash
cd ~/sbx-lab
sbx create <agent> .
```

> **First run:** The agent image will pull (1–2 minutes) and the sandbox will be created with the Balanced network policy you selected at login.

```bash
sbx ls
```

You should see `shell-sbx-kits-box-main` in the list with status `stopped`:

```
SANDBOX   AGENT    STATUS    PORTS   WORKSPACE
shell-sbx-kits-box-main    <agent>   stopped           /your/project/path
```

Once you run it (Step 6), the status changes to `running`.

---

## Step 6 - Run your sandbox

```bash
sbx run sbxlab
```

On first run, the agent may auto-update itself. If you see an update message, simply re-run the command:

```bash
sbx run sbxlab
```

You will then see a trust prompt before the agent starts:

```
INFO: Starting Docker daemon
Starting <agent> agent in sandbox 'sbxlab'...
Workspace: /your/project/path

> You are in /your/project/path

  Do you trust the contents of this directory? Working with untrusted
  contents comes with higher risk of prompt injection.

› 1. Yes, continue
  2. No, quit
```

Select **1. Yes, continue** to launch the agent.

> **Why this prompt exists:** sbx mounts only your project directory into the microVM. The trust check ensures you're aware of what the agent can see and act on.

---

## ✅ Ready to go

All six steps pass? Move to Module 1.

If anything failed, check [Troubleshooting](https://docs.docker.com/ai/sandboxes/troubleshooting/) or the Appendix at the end of this lab.
