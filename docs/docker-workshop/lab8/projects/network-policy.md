---
title: "Network Policy"
---

The sandbox controls what the agent can reach on the network. This is the third
layer of isolation - and it gives you a complete audit trail of every connection
the agent attempts.

---

## The default: already open for common dev tools

sbx ships with **5 default allow policies** covering everything a developer
typically needs. You don't need to configure anything for standard workflows.

Check what's allowed right now:

```bash
sbx policy ls
```

You'll see five policy groups:

| Policy | What it covers |
|---|---|
| `default-ai-services` | OpenAI, Anthropic, Gemini, Cursor, Perplexity |
| `default-package-managers` | PyPI, npm, cargo, maven, rubygems, and more |
| `default-code-and-containers` | GitHub, GitLab, Docker Hub, ghcr.io |
| `default-cloud-infrastructure` | AWS, GCP, Azure, Vercel, Fastly |
| `default-os-packages` | Ubuntu, Debian, Alpine package repos |

`pypi.org`, `files.pythonhosted.org`, `npmjs.org`, `github.com` - all already
allowed. No setup required.

---

## Prove it: install a package

Start your sandbox and ask the agent to install `httpx`:

```bash
sbx run sbxlab
```

Then prompt:

> Install httpx and tell me the version

The agent will work through PEP 668 on its own and successfully install:

```plaintext
• Ran python3 -m pip install httpx
  └ error: externally-managed-environment ...

• Ran python3 -m pip install --break-system-packages httpx
  └ Successfully installed httpx-0.28.1
    0.28.1
```

The agent self-corrected and got the answer - all inside the microVM, your Mac
untouched.

---

## The real power: deny rules

The default policies allow common tools. But you can **restrict** what the agent
can reach - blocking specific domains at the network layer, regardless of what
the agent tries.

### Step 1 - Block PyPI

```bash
sbx policy deny network pypi.org
```

Verify it's active:

```bash
sbx policy ls
```

You'll see a new local entry at the bottom:

```plaintext
local:9701dc6e-...   network   deny   pypi.org
```

### Step 2 - Restart the sandbox

Policy changes require a sandbox restart to take effect:

```bash
sbx stop sbxlab
sbx run sbxlab
```

### Step 3 - Watch the agent fail

Ask the agent to install a package:

> Install requests and tell me the version

The agent is persistent - it will try multiple approaches, all of which fail:

```plaintext
• Ran pip install requests
  └ error: externally-managed-environment

• Ran pip install --break-system-packages requests
  └ ERROR: Could not find a version that satisfies the requirement requests
    ERROR: No matching distribution found for requests

• Ran curl -I https://pypi.org/simple/requests/
  └ HTTP/2 403
```

The agent tried everything it knew. It still failed. Not because of a system
prompt instruction - because the proxy blocked the TCP connection at the network
layer.

> **Key insight:** A smarter agent cannot bypass a network deny rule.
> Agent capability and network policy are completely independent layers.

### Step 4 - Find and remove the deny rule

List policies to get the rule ID:

```bash
sbx policy ls
```

Look for the local deny entry at the bottom. Copy its UUID (the part after
`local:`), then remove it:

```bash
sbx policy rm network --id <uuid-from-policy-ls>
```

> **Important:** Use `--id` with just the UUID - drop the `local:` prefix.

Verify it's gone:

```bash
sbx policy ls
```

No local entries should remain.

### Step 5 - Confirm the agent works again

Restart the sandbox:

```bash
sbx stop sbxlab
sbx run sbxlab
```

Ask the agent to install requests again - it works immediately.

---

## Key rules about policy precedence

- **Deny overrides allow** - a local deny rule beats any default allow policy
- **Restart required** - policy changes take effect on the next `sbx run`
- **Always clean up deny rules** - use `sbx policy rm network --id <uuid>`
- **Default policies cannot be removed** - only local rules you add can be removed

---

## Watch live connections

In a separate terminal, watch every outbound connection in real time:

```bash
sbx policy log sbxlab
```

You'll see each connection as it happens:

```plaintext
ALLOWED   pypi.org                 200
ALLOWED   files.pythonhosted.org   200
```

Add a deny rule and repeat - you'll see:

```plaintext
BLOCKED   pypi.org   -
```

This log is your **audit trail**. For regulated enterprises it answers:
*"What did the agent do on the network, and when?"*

---

## Reach host services from inside the sandbox

If you have a local service running on your Mac (like Ollama on port 11434),
use `host.docker.internal` - not `localhost`, which resolves to the VM itself:

```bash
sbx policy allow network localhost:11434
```

Then inside the sandbox, connect to `host.docker.internal:11434`.

---

## ✅ Checkpoint

Before moving on, confirm you can:

- Run `sbx policy ls` and identify the 5 default policy groups
- Add a deny rule and observe the agent failing
- Remove the deny rule with `sbx policy rm network --id <uuid>`
- Confirm the agent works again after the deny rule is removed

Next: branch mode - how to run agents without touching your working tree.
