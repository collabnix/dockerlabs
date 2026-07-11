---
title: "What's Next"
---

You just proved **Pillar 1 - Sandbox Policies** end-to-end. Here's how Pillars 2 and 3 fit in.

:::warning[Roadmap content]
The CLI surface for audit and MCP governance is still landing on `sbx`. The descriptions below explain the model and point to where each pillar lives today. Validate against your installed version as features ship.
:::

---

## Pillar 2 - MCP Tool Governance

MCP (Model Context Protocol) servers give agents access to tools - GitHub, Notion, your internal APIs, custom servers your team builds. Each tool is a new attack surface.

Docker AI Governance lets org admins define:

- **Which MCP servers** are approved for agents in your org
- **Which tools** within each server are usable
- **Which catalogs** developers can pull from (curated Hub catalog vs. open public sources)
- **How secrets are injected** per request, never persisted on the agent

This is the **MCP Gateway Enterprise** layer. It sits between agent and tool, evaluating every call against the same policy engine that enforces sandbox network rules in the Network demo.

**Where to see it today:** The MCP Gateway Enterprise control plane is rolling out. Check [docker.com/products/ai-governance](https://www.docker.com/products/ai-governance/) for current availability and your org's enablement status.

---

## Pillar 3 - Audit and Visibility

Every policy decision - allow or deny, network or filesystem or MCP - generates a structured audit event. Conceptually:

```json
{
  "timestamp": "2026-06-01T01:35:22Z",
  "user": "ajeetraina777",
  "org": "<your-org>",
  "sandbox_id": "sbx_abc123",
  "rule_type": "network",
  "rule_name": "deny exfiltration",
  "decision": "deny",
  "resource": "paste.ee:443",
  "agent": "shell"
}
```

These events stream to your existing SIEM (Splunk, Datadog, Elastic, Sentinel) for retention, alerting, and compliance reporting.

**Where to see it today:**

- **Admin Console** - for your org, the Activity / Audit logs view shows org-level policy and access events (when enabled for your plan)
- **Local daemon log** - runtime decisions on this machine are streamed to the sbx daemon log. For ad-hoc inspection during demos:

```bash
tail -50 ~/Library/Application\ Support/com.docker.sandboxes/sandboxes/sandboxd/daemon.log
```

This is **not** a polished audit surface - it's the raw daemon log. But after running the Network and Filesystem enforcement tests, you can grep it for the paste.ee, example.com, and credential-access denials to see the underlying machinery in action:

```bash
grep -iE "paste\.ee|example\.com|deny|block" ~/Library/Application\ Support/com.docker.sandboxes/sandboxes/sandboxd/daemon.log | tail -20
```

A dedicated `sbx audit` CLI with structured query, export, and SIEM integration is on the roadmap. The **Observability** section walks through the structured JSONL surface and a live dashboard built on top of it.

---

## The complete three-pillar picture

| Pillar | What it controls | Where it's enforced | Where to see it today |
| --- | --- | --- | --- |
| 1. Sandbox policies | Network, filesystem, resource limits | Network proxy, mount layer | **Validated in Network + Filesystem demos** |
| 2. MCP tool governance | Which tools agents can call | MCP Gateway Enterprise | Admin Console (rolling out) |
| 3. Audit + visibility | Every policy decision logged | Audit event stream → SIEM | Admin Console + daemon log |

All three share **one policy engine** and **one source of truth** - the Admin Console for your org.

---

## Where to go from here

- **Product page:** [docker.com/products/ai-governance](https://www.docker.com/products/ai-governance/)
- **Docker docs:** [docs.docker.com](https://docs.docker.com) - check for the latest AI governance documentation
- **The accompanying deck** covers the policy framework and supporting architecture in more depth
- **Interactive Labspace:** [github.com/ajeetraina/labspace-ai-governance](https://github.com/ajeetraina/labspace-ai-governance) - the click-to-run version of this lab with built-in terminals and a live audit dashboard
- **Sandbox Kits** - the next track in this lab shows how to package reproducible, shareable sandbox configurations

---

## Quick recap

You proved:

- Policies defined once in the Admin Console flow automatically to every developer's `sbx`
- Three rules - two allows and one deny - enforce a real security model
- The default-deny posture catches anything you didn't explicitly approve
- Developers can't override the policies locally - the CISO retains control

That's the working version of "AI governance" you can defend to a security team.
