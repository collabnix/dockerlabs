---
title: "1Password Credential Injection"
---

In [Secrets Without Exposure](/docker-workshop/lab8/projects/secrets) you stored credentials in your OS
keychain. This module shows a stronger pattern: keep your secrets in **1Password**
and let `sbx` inject them at the network boundary. The real secret never enters
the sandbox - the agent only ever sees a sentinel value.

---

## Why this matters

- Your API keys stay in 1Password, the vault you already trust.
- The sandbox gets a placeholder (`proxy-managed`), never the real token.
- The proxy swaps the placeholder for the real key only on recognized outbound
  HTTPS calls - and only for domains you allow.

---

## Prerequisites

- Docker Sandboxes (`sbx`) installed - see [Pre-flight Checklist](/docker-workshop/lab8/getting-started)
- A 1Password account with the desktop app installed and **unlocked**
- An agent CLI (Claude, Codex, Gemini, etc.)

---

## Step 1 - Install the 1Password CLI

:::note[macOS]

```bash
brew install --cask 1password-cli
```
:::

:::note[Linux (Debian/Ubuntu)]

```bash
# After adding the 1Password apt repo
sudo apt install 1password-cli
```
:::

:::note[Windows]

```bash
winget install AgileBits.1Password.CLI
```
:::

Verify:

```bash
op --version
```

---

## Step 2 - Authenticate

**Recommended - desktop integration:**

1. Open and unlock the 1Password desktop app.
2. Go to **Settings → Developer**.
3. Enable **Integrate with 1Password CLI**.
4. (Optional) Enable biometric unlock.

**Alternative - manual sign-in:**

```bash
eval $(op signin)
```

Confirm your session:

```bash
op whoami
```

You should see your account URL, email, and user ID. If it says *"not currently
signed in,"* authentication failed - fix it before continuing.

---

## Step 3 - Find your secret reference

References use the format `op://<vault>/<item>/<field>`.

```bash
# List your vaults
op vault list

# List items in a vault
op item list --vault Employee

# Inspect an item to find the field name (don't assume "token")
op item get "OpenAI API Key" --vault Employee
```

:::warning[Field names matter]

**API Credential** items store the secret in a field named `credential`,
not `token`.
:::

:::tip[Avoid special characters in references]

A reference like `op://Employee/OpenAI API Key (docker work)/credential`
will fail:

```
ERROR: invalid character in secret reference: '('
```

Instead: rename the item to a clean handle, use its 26-character UUID, or
copy the reference directly from the desktop app.
:::

---

## Choose an injection pattern

### Pattern 1 - Persistent (reuse across future sandboxes)

```bash
set -o pipefail
op read "op://Employee/OpenAI/credential" | sbx secret set -g openai
```

Update an existing secret:

```bash
sbx secret rm -g openai
op read "op://Employee/OpenAI/credential" | sbx secret set -g openai
```

Verify:

```bash
sbx secret ls
```

### Pattern 2 - Ephemeral (fresh per launch)

The key resolves fresh each run and is cleared on exit - never stored.

```bash
OPENAI_API_KEY="op://Employee/OpenAI/credential" op run -- sbx run codex
ANTHROPIC_API_KEY="op://Employee/Anthropic/credential" op run -- sbx run claude
```

### Pattern 3 - Multiple providers via env file

Create `.sbx-secrets.env`:

```
ANTHROPIC_API_KEY=op://Employee/Anthropic/credential
OPENAI_API_KEY=op://Employee/OpenAI/credential
```

Launch with the file:

```bash
op run --env-file=.sbx-secrets.env -- sbx run claude
```

:::danger[Add it to .gitignore]

`.sbx-secrets.env` holds credential *references*. They aren't the secrets
themselves, but keep the file out of git anyway.
:::

---

## Step 4 - Prove containment

The sandbox should never see your real key:

```bash
sbx run --name op-test shell -d
sbx exec op-test -- bash -lc 'echo "OPENAI_API_KEY=$OPENAI_API_KEY"'
sbx rm op-test
```

Inside the sandbox the value shows `proxy-managed` (the sentinel) - **never**
your real key.

---

## Step 5 - Enable injection via domain binding

Back up your config first:

```bash
cp ~/.config/sbx/credentials.yaml ~/.config/sbx/credentials.yaml.bak
```

Edit `~/.config/sbx/credentials.yaml` and add under `bindings:`:

```yaml
openai:
    discovery: []
    allowedDomains:
        - api.openai.com
```

Start a **fresh** sandbox (existing ones cache the old config) and verify the
proxy injects the real key on an allowed outbound call:

```bash
sbx run --name inj-test shell -d
sbx exec inj-test -- bash -lc \
  'curl -s -o /dev/null -w "%{http_code}\n" https://api.openai.com/v1/models \
   -H "Authorization: Bearer $OPENAI_API_KEY"'
sbx rm inj-test
```

A `200` confirms the proxy swapped the sentinel for your real key at the
network boundary.

---

## Troubleshooting

| Error | Cause | Fix |
|---|---|---|
| `You are not currently signed in` | No live `op` session | `eval $(op signin)` or enable desktop integration; check `op whoami` |
| `Enter secret: input cannot be empty` | `op read` failed upstream | Add `set -o pipefail`; fix the auth issue |
| `isn't an item in the ... vault` | Vault doesn't exist on your account | Run `op vault list`, use your real vault |
| `invalid character in secret reference: '('` | Hand-built reference with special chars | Rename item, use UUID, or copy from app |
| `not injecting` warning | Service has no domain binding | Add an `allowedDomains` entry in `credentials.yaml` |

---

## How it works

The sandbox runs a **credential proxy** that intercepts outbound calls. Your
secret stays in 1Password on the host and is retrieved only when needed. Inside
the container it exists only as a sentinel (`proxy-managed`); the proxy swaps it
for the real value at the network boundary - and only for recognized providers
with an `allowedDomains` binding.

---

## ✅ Checkpoint

Confirm:

- `op whoami` shows an active 1Password session
- `sbx secret ls` lists your stored credential (Pattern 1) **or** your env file
  resolves at launch (Patterns 2 & 3)
- Inside a sandbox, `$OPENAI_API_KEY` reads `proxy-managed`, not your real key
- An allowed outbound call returns `200`

Next: controlling what the agent can reach on the network in
[Network Policy](/docker-workshop/lab8/projects/network-policy).
