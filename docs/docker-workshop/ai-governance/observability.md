---
title: "Observability - Audit + Dashboard"
---

**Pillar 3 (Audit + Visibility)** Every policy decision sbx makes is written to a structured JSONL log on disk today - and the lab ships a live dashboard you can run alongside it.

:::info[At a glance]
**Time:** ~10 minutes &nbsp;&nbsp;|&nbsp;&nbsp; **Prerequisites:** You completed the Network demo and (optionally) MCP Hands-On.
:::

This section gives you two things:

1. A way to read the underlying audit log directly with `jq`
2. A live dashboard you can build from [`labspace/kits/observability/`](https://github.com/ajeetraina/labspace-ai-governance/tree/main/labspace/kits/observability) in the lab repo

---

## Step 1 - Locate the daemon log

The sbx daemon writes JSONL audit records here:

```bash
ls -lh "$HOME/Library/Application Support/com.docker.sandboxes/sandboxes/sandboxd/daemon.log"
```

On Linux it's typically `~/.local/share/com.docker.sandboxes/sandboxes/sandboxd/daemon.log`.

---

## Step 2 - Read it with `jq`

Each policy decision is one JSON line. The `msg` field is `"governance policy evaluation"`, and useful fields include `resource_value`, `allowed`, `policy_matched_rule`, `policy_deny_reason`, `policy_source`.

```bash
LOG="$HOME/Library/Application Support/com.docker.sandboxes/sandboxes/sandboxd/daemon.log"

# Last 20 policy decisions
jq -c 'select(.msg == "governance policy evaluation")' "$LOG" | tail -20

# Only denies
jq -c 'select(.msg == "governance policy evaluation" and .allowed == false)' "$LOG" | tail -20

# Count denies per rule
jq -r 'select(.msg == "governance policy evaluation" and .allowed == false) | .policy_matched_rule // "(default-deny)"' "$LOG" \
  | sort | uniq -c | sort -rn

# Explicit (rule matched) vs implicit (default-deny)
jq -r 'select(.msg == "governance policy evaluation" and .allowed == false) | .policy_deny_reason' "$LOG" \
  | sort | uniq -c
```

This is your SIEM-ready surface. Forward this file to Splunk/Datadog/Sentinel and you have an org-grade audit trail for sandbox policy decisions.

---

## What's captured and what isn't

| Captured today | Not captured today |
|---|---|
| Timestamp | User identity |
| Resource (domain, port, path) | Sandbox name (sandbox_id) |
| Decision (allow/deny) | Prompt or tool-call payload |
| Matched rule name | MCP tool-call audit (separate roadmap) |
| Deny reason (explicit / implicit) | Cross-machine aggregation |
| Policy source (local / remote) | |

The audit log answers *what was decided and why*. It doesn't yet answer *who triggered it on this machine* - that's roadmap.

---

## Step 3 - Run the dashboard

The lab repo ships a small dashboard built on top of the daemon log. Clone the lab repo if you haven't, then start it from the observability kit:

```bash
git clone https://github.com/ajeetraina/labspace-ai-governance
cd labspace-ai-governance/labspace/kits/observability
docker compose --profile with-gateway up -d --build
```

Then open it in a fresh browser tab:

```bash
open http://localhost:8090
```

:::tip
If the dashboard is empty, trigger a few events with the commands in Step 4 - it populates live.
:::

---

## Step 4 - Generate some events to watch

In another terminal, enter a sandbox and trigger denies:

```bash
mkdir -p ~/labspace-fs-test/test-1 && cd ~/labspace-fs-test/test-1
sbx run shell .
```

(Reusing `~/labspace-fs-test/test-1` means the single `allow lab test directory` filesystem rule from the earlier demos already covers this workspace - no new rule needed.)

Inside the sandbox prompt:

```bash
curl -sS https://collabnix.com -o /dev/null -w "%{http_code}\n"
curl -sS https://example.com -o /dev/null -w "%{http_code}\n"
curl -sS https://api.anthropic.com -o /dev/null -w "%{http_code}\n"
```

Switch to the dashboard. You'll see three new rows appear in real time:

- `paste.ee` or `collabnix.com` → `deny` with `explicit` reason and your matched rule name
- `example.com` → `deny` with `implicit` reason (default-deny)
- `api.anthropic.com` → `allow`

The per-rule deny count panel on the left updates live.

---

## Step 5 - Layer MCP traffic on top (optional)

If you have the Variant B MCP gateway from *MCP Hands-On* running on `localhost:8811`, the dashboard automatically picks up its logs (it discovers any running container whose image name contains `mcp-gateway`).

Trigger an MCP call through it and you'll see entries with source `mcp-gateway` alongside the sbx rows - both signals in one screen.

---

## What you just demonstrated

- Pillar 3's audit substrate already ships in `sbx`: structured JSONL ready for SIEM ingestion
- A live UI can be built on top in a few hundred lines of code
- The honest gap (no user attribution, no MCP-tool-level audit yet) is now visible to your security team in the same view that shows what *is* captured

For a security review conversation, this section is the one that lands. You're not promising a feature - you're showing the structured event stream that already exists, and the work it would take to wrap it in your org's SIEM.

---

## Frequently asked: prompts and tool calls

The most common question after seeing this dashboard:

> *"Can it show me the prompts the agent sent and which MCP tool was called?"*

**Short answer: no, and the dashboard is intentionally honest about that.** Here's the precise breakdown.

### Prompts

Not logged. The sbx proxy does MITM TLS interception so it *could* technically read request bodies, but it only captures network metadata (destination, port, decision). No request bodies. Almost certainly a deliberate product choice - logging prompt content has privacy and legal implications.

### MCP tool calls

Only visible for gateways you run yourself, and only as heuristic log lines:

- **Mode B (local stdio):** the subprocess runs on your host; wrap it yourself if you need audit
- **Local MCP Gateway with `--verbose=true`:** the dashboard tails the gateway stdout and surfaces `call-tool` / `list-tools` classifications. Not structured per-call records.
- **Mode A (remote OAuth servers like Notion, GitHub):** invisible from your side. You see the TCP connect in sbx, you don't see which tool was called.

For structured tool-call audit, [`docker/mcp-gateway`](https://github.com/docker/mcp-gateway) would need to emit JSONL audit events. It doesn't today - file a feature request.

### Who triggered each event

The sbx daemon log has no `user`, `sandbox_id`, or `agent` field. Per-machine logs answer *what* was decided, not *who* triggered it. For org-wide audit you'd want sbx to enrich each event with `user_email` from the Docker login session - a feasible feature request, not currently shipping.

### What ships today vs roadmap

| What | Today | Roadmap |
|---|---|---|
| Network policy decisions (allow/deny/rule/reason) | ✅ JSONL in daemon.log | - |
| Filesystem mount decisions | ✅ same | - |
| User attribution | ❌ | Likely (no API change required) |
| Prompt content | ❌ | Probably never default |
| Structured MCP tool-call audit | ❌ (heuristic only) | Yes, via gateway changes |
| Hosted MCP server audit | ❌ | Part of MCP Tool Governance (Pillar 2) |
| Cross-machine aggregation | ❌ | Via SIEM ingestion of the daemon.log |

That's the entire picture you can defend to a security team.

---

## Where to go from here

- Forward the daemon.log to your SIEM (Splunk HEC, Datadog HTTP intake, Elastic HTTP)
- Read the kit's `README.md` for caveats and config
- Watch this space for `sbx audit` CLI and MCP-tool-level audit - both on the roadmap
