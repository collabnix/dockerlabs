---
title: "Why AI Agents Need Governance"
---

No terminal needed for this module. Read carefully - everything you run in the next seven modules exists because of what's on this page.

---

## The Problem: Agents Running on the Host

When a developer runs Claude Code on their laptop without sandboxing, the agent runs as their user process. That means it has access to everything they have access to:

- `~/.aws/credentials` - AWS access keys
- `~/.ssh/id_rsa` - SSH private keys  
- `.env` files - database passwords, API tokens
- The entire home directory
- Any running Docker containers on the host

The agent isn't malicious. But it doesn't need to be for something to go wrong. A confused agent, a malicious MCP server, a prompt injection attack - any of these can cause the agent to exfiltrate credentials or corrupt data. And if there's no audit trail, you won't know it happened.

---

## Real Incidents - Not Hypothetical

These are documented vulnerabilities from 2025:

**Cursor's System Prompt Leaked** - The agent's internal instructions were exposed, revealing details about its tool access and capabilities. Developers building on top of Cursor couldn't trust their agents weren't being manipulated.

**GitHub Copilot / Cursor RCE via Malicious MCP File Swaps** - An attacker could replace an approved MCP server file after approval, causing the agent to execute arbitrary code with the developer's credentials.

**MCP Tool Poisoning** - A critical vulnerability in the Model Context Protocol allowed attackers to poison tool descriptions, causing agents to take unintended actions. Anthropic, OpenAI, Zapier, and Cursor were all affected.

The pattern: **agents are trusted, and that trust is being exploited.**

---

## Why Current "Solutions" Don't Work

### Permission Dialogs

```
┌─────────────────────────┐
│   Delete all your data? │
│                         │
│   [ Yes ]    [ No ]     │
└─────────────────────────┘
```

Developers running agents in YOLO mode (the default for productivity) dismiss these. They accumulate. They become noise. They are not security.

### System Prompt Instructions

```
I solemnly promise not to read any 
sensitive .env files unless you ask 
me really nicely.
```

A system prompt is text. It can be overridden by prompt injection. It has no enforcement mechanism. It is not security.

---

## What Actually Works: The microVM Boundary

Docker Sandboxes runs each agent in a **lightweight microVM** - a virtual machine with its own dedicated Linux kernel. The agent runs inside the VM. Your credentials live on your host. The only thing shared is the workspace directory you explicitly mount.

```
Your Mac (host)
├── ~/.aws/credentials     ← here, untouched
├── ~/.ssh/id_rsa          ← here, untouched  
├── /var/run/docker.sock   ← host daemon, untouched
│
└── sbxlab (microVM)
    ├── /your/workspace    ← shared, bidirectional
    ├── private Docker daemon
    └── outbound proxy     ← enforces network policy, injects creds
```

The boundary is structural. It's enforced by the hypervisor, not by a policy document or a system prompt. The agent can't reach what isn't mounted - not because it's been told not to, but because it doesn't exist inside the VM.

---

## The Agent Autonomy Scale

| Stage | Name | Description |
|---|---|---|
| 1 | Autocomplete | Code suggestions in IDE |
| 2 | Assistant | Chat, Q&A, explanations |
| 3 | Specialist | Multi-step task completion |
| **4** | **Semi-Autonomous** | **Governed agent loops ← sbx target** |
| **5** | **Autonomous** | **Self-directed workflows ← sbx target** |
| 6 | Steward | Long-term agent vision, full trust model |

Most enterprises today are at stage 2–3. sbx is the infrastructure that makes stages 4–5 safe to operate. Without governance, you skip stages and take the risk with you.

---

## What You'll Learn in This Lab

By the end of this lab, you will be able to:

- Prove structurally that an agent cannot access host credentials (Module 3)
- Explain how secret injection works without exposing keys to the agent (Module 4)
- Configure and observe network policy enforcement in real time (Module 5)
- Use branch mode to get clean agent diffs for review (Module 6)
- Run multiple agents in parallel on the same codebase without conflicts (Module 7)

Let's start.
