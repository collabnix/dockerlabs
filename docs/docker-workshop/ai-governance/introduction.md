---
title: "Why AI Governance"
---

AI agents - Claude, Copilot, Cursor, custom MCP servers - run with the same blast radius as the developer running them. That means access to your filesystem, your secrets, your network, your everything.

This is fine when the agent does what you expect. It's a disaster when:

- A prompt-injected agent uploads SSH keys to `paste.ee`
- A misconfigured MCP server exfiltrates source code to an unknown destination
- An agent acting on hallucinated instructions pushes a malicious commit to `main`
- A coding agent reads your `.env` and posts it to the model API alongside your code

The standard answer - **"don't let agents do that"** - doesn't scale. Developers want agents. They'll find a way. The right answer is to put guardrails around the agent's execution environment so it physically *cannot* exceed its scope.

That's AI governance.

---
<img width="1003" height="496" alt="image" src="https://github.com/user-attachments/assets/3abeb360-eb55-40c7-b287-459effe275dd" />


## The three pillars

Docker AI Governance gives you three layers of control, defined once in the Admin Console and enforced everywhere agents run.

### 1. Sandbox policies
Network allowlists, filesystem mount rules, resource limits. Enforced at the proxy and mount layer. The agent never sees data or destinations it isn't allowed to touch.

### 2. MCP tool governance
Which MCP servers and tools your org's agents can use. Defined centrally, enforced for every developer, audited.

### 3. Audit + visibility
Every policy decision generates a structured event with user identity, timestamp, session context, and triggering rule. Exports to your SIEM. CISOs get the trail.

---

## What this lab covers

| Section | What you'll do |
| --- | --- |
| The Policy Model | Understand how org policies flow to developer machines |
| Network Enforcement Demo | Prove network policies enforce with three `curl`s |
| Filesystem Enforcement Demo | Prove filesystem policies enforce on a credentials directory |
| MCP Hands-On | Register MCP servers locally with `sbx mcp` |
| Observability | Read the audit log and watch policy decisions live |
| What's Next | Preview audit trails and MCP governance |

The lab focuses on **Pillar 1 (sandbox policies)** because that's what's broadly available today and what you can prove enforces in a short demo. Pillars 2 and 3 are previewed and partially hands-on in the later sections.

By the end you'll have a working, defensible enforcement story you can walk a security team through.
