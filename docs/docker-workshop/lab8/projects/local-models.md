---
title: "Running Open-Source Models with sbx"
---

So far you've governed agents that call cloud LLMs. This module closes the last
gap: running agents inside sbx against **local open-source models** on your Mac
- no API keys, no egress, no cloud dependency.

The pattern is simple once you see it:

- **Docker Model Runner** runs on your Mac host at `localhost:12434`
- **The agent** runs inside the sbx microVM
- **Only one port** crosses the VM boundary - the OpenAI-compatible HTTP endpoint

That's the strong story: air-gapped agent workflows with zero cloud
dependency, still governed by the same sandbox, same network policy, same
audit log.

---

## Why not just run the model inside the sbx?

Two reasons:

1. **Models are heavy.** A 4GB GGUF file plus GPU/Metal acceleration belongs on
   the host. The sbx is a lean microVM - it doesn't have Metal access.
2. **Docker Model Runner already exists on the host.** It's built into Docker
   Desktop, exposes an OpenAI-compatible API, and can be shared by every sbx on
   your machine.

The agent calls the model over HTTP. That's the only thing the VM boundary
needs to pass through.

---

## Step 1 - Confirm DMR is running on the host

On your **Mac**:

```bash
docker model ls
curl -s http://localhost:12434/engines/llama.cpp/v1/models | head -20
```

You should see a list of local models. If `docker model ls` is empty, pull a
small one - smollm2 is 360MB and loads instantly:

```bash
docker model pull ai/smollm2:360M-Q4_K_M
```

For a real coding demo, pull something bigger:

```bash
docker model pull ai/qwen3:8B-Q4_K_M
```

---

## Step 2 - Create a fresh sbx

On the host:

```bash
mkdir -p /tmp/dmr-test && cd /tmp/dmr-test
sbx create --name dmr-test shell .
```

The `shell` agent gives you a plain bash prompt inside the microVM - no AI
agent attached. Perfect for testing connectivity before wiring up Codex or
Claude.

---

## Step 3 - Allow DMR through the network policy

Before you attach, add a local allow rule. The sbx proxy normalizes the target
to `localhost:12434` internally - even when you'll reach it via
`host.docker.internal`.

```bash
sbx policy allow network localhost:12434
```

Verify:

```bash
sbx policy ls | grep localhost
```

You should see one local allow entry for `localhost:12434`.

> **Why `localhost:12434` and not `host.docker.internal:12434`?** The sbx proxy
> strips the hostname and matches the destination port against policy as
> `localhost:<port>`. It's the same reason you'll use `host.docker.internal`
> for the curl but allow `localhost` in the policy - a quirk of the proxy
> internals.

---

## Step 4 - Attach to the sbx

```bash
sbx run dmr-test
```

You'll land inside the VM:

```plaintext
agent@dmr-test:dmr-test$
```

Confirm you're really in a fresh Linux guest:

```bash
hostname
cat /etc/os-release | head -2
```

You'll see the sandbox name and a clean Ubuntu 25.10 image - not your Mac.

---

## Step 5 - Reach DMR from inside the sbx

Three things to know about networking inside sbx:

- `localhost` inside the VM is the **VM's own loopback** - not your Mac.
  `curl localhost:12434` will get **connection refused**.
- `host.docker.internal` **does** resolve - it points at your Mac host via the
  sbx gateway.
- `model-runner.docker.internal` does **not** resolve inside sbx. Don't use it.

Get the model list:

```bash
curl -s http://host.docker.internal:12434/engines/llama.cpp/v1/models | head -30
```

You'll see the same list you saw on the host in Step 1 - proof that the sbx
proxy forwarded the request to DMR.

---

## Step 6 - Run inference across the boundary

```bash
curl -s http://host.docker.internal:12434/engines/llama.cpp/v1/chat/completions \
  -H "Content-Type: application/json" \
  -d '{
    "model": "ai/smollm2:360M-Q4_K_M",
    "messages": [{"role":"user","content":"Reply with exactly: sbx to DMR works"}],
    "max_tokens": 20
  }'
```

You'll get back JSON with the model's response in `choices[0].message.content`.
That's a completed inference round-trip - agent in microVM, model on host,
OpenAI-compatible protocol between them.

> **Tip:** smollm2 at 360M is great for connectivity tests but too small for
> real coding. For production-quality demos use `ai/qwen3:8B-Q4_K_M` or
> `ai/gemma4:latest`.

---

## Step 7 - Python client using the OpenAI SDK

This is the pattern any real agent will use. Create `test_local.py` inside
the sbx:

```bash
cat > test_local.py <<'EOF'
from openai import OpenAI

client = OpenAI(
    base_url="http://host.docker.internal:12434/engines/llama.cpp/v1",
    api_key="not-needed"
)

resp = client.chat.completions.create(
    model="ai/qwen3:8B-Q4_K_M",
    messages=[{
        "role": "user",
        "content": "Write a Python function that reads a CSV and counts rows."
    }]
)
print(resp.choices[0].message.content)
EOF
```

Install the SDK and run it:

```bash
pip install --break-system-packages openai
python3 test_local.py
```

The model generates Python code - completely offline, no API key, no egress.

---

## Step 8 - Run a coding agent against the local model

Swap the `shell` agent for a real one. Codex and Claude Code both respect
`OPENAI_BASE_URL` and `OPENAI_API_KEY` environment variables, so pointing them
at DMR is a one-liner.

First stop the shell sandbox:

```bash
sbx stop dmr-test
sbx rm dmr-test
```

Create a codex sandbox and inject the local-model env vars:

```bash
cd /tmp/dmr-test
sbx create --name dmr-codex codex .
```

Add the env vars to the codex config so they're available to the agent every
run. Inside the sbx once you attach:

```bash
export OPENAI_BASE_URL=http://host.docker.internal:12434/engines/llama.cpp/v1
export OPENAI_API_KEY=not-needed
codex "write a Python script that prints the first 10 Fibonacci numbers"
```

The agent is running inside the microVM. The model is running on your Mac.
The only thing crossing the boundary is OpenAI-compatible JSON over HTTP. No
cloud. No secrets leaving the host. No tokens billed.

---

## Watch the policy log during the run

In a separate host terminal:

```bash
sbx policy log dmr-codex
```

Every inference request shows up as an allowed `localhost:12434` entry. That's
your audit trail - proof that the agent only talked to the local model and
nothing else.

Try breaking it. Stop the sbx, change the allow rule to a deny, and restart -
the agent will fail to reach the model. Network policy governs local traffic
the same way it governs cloud traffic.

---

## Conclusion

This is the pitch to hand your rep:

- **Agent is fully isolated.** microVM boundary, not a container escape risk.
- **Model runs locally.** No cloud API costs, no third-party LLM exposure, no
  token limits.
- **Secrets never leave the host.** Your Mac keeps its API keys and SSH
  credentials. The sbx never sees them.
- **Network is governed.** Even `localhost:12434` requires an explicit allow
  rule. Every request is logged.
- **Works air-gapped.** Regulated enterprises - healthcare, finance, defense -
  can run this pattern on air-gapped networks with zero cloud dependency.

That's the "agent in a microVM, model on the host, zero cloud dependency"
architecture. sbx + DMR gives you the first real open-source implementation
of it.

---

## Troubleshooting

**`curl localhost:12434` returns connection refused inside sbx.**
Expected. `localhost` is the VM's own loopback. Use `host.docker.internal`.

**`curl host.docker.internal:12434` returns `Blocked by network policy`.**
You didn't add the allow rule. Run `sbx policy allow network localhost:12434`
on the host and restart the sbx.

**`curl model-runner.docker.internal` returns `no such host`.**
That DNS name doesn't resolve inside sbx. Only `host.docker.internal` does.

**Agent reaches DMR but inference returns 404 or garbled output.**
Check the exact model ID with `docker model ls` on the host - model names with
quantization tags like `ai/smollm2:360M-Q4_K_M` must be passed verbatim in the
request body.

---

## ✅ Checkpoint

Before moving on, confirm you can:

- Reach DMR from inside the sbx via `host.docker.internal:12434`
- Run a chat completion against a local model
- Point a Python OpenAI SDK client at the local endpoint
- Point a coding agent (codex) at the local model via `OPENAI_BASE_URL`
- Watch the connections in `sbx policy log`

Next: the governance summary - the full architecture pulled together.
