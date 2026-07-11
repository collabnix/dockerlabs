---
title: "Who's This For"
---

## What is Docker Sandboxes?

[Docker Sandboxes (sbx)](https://github.com/docker/sbx-releases) is a microVM-based runtime for running AI coding agents safely. Instead of letting agents like Claude Code, Codex, or Gemini CLI run as a regular user process on your laptop - with full access to your home directory, SSH keys, AWS credentials, and Docker daemon - sbx runs each agent inside a lightweight virtual machine with its own kernel. Only the workspace directory you explicitly mount is shared. Everything else stays on the host.

The boundary is **structural**, enforced by the hypervisor - not by a permission dialog, a system prompt, or a policy document the agent has agreed to follow.

## What problem it solves?

When a developer runs an AI coding agent on their laptop without sandboxing, the agent runs as their user. That means it has access to everything they have access to:

- `~/.aws/credentials` - AWS access keys
- `~/.ssh/id_rsa` - SSH private keys
- `.env` files - database passwords, API tokens
- The entire home directory
- Any running Docker containers on the host

The agent isn't malicious. But it doesn't need to be for something to go wrong. A confused agent, a malicious MCP server, or a prompt injection attack can cause the agent to exfiltrate credentials or corrupt data. And without an audit trail, you won't know it happened.

Real incidents in 2025 - leaked system prompts, RCE via malicious MCP file swaps, MCP tool poisoning across Anthropic, OpenAI, Zapier, and Cursor - all share the same pattern: **agents are trusted, and that trust is being exploited.**

The current "solutions" don't hold up:

- **Permission dialogs** get dismissed in YOLO mode and become noise. They're not security.
- **System prompt instructions** are just text. They can be overridden by prompt injection and have no enforcement mechanism.

## The Solution

Docker Sandboxes wraps each agent in a microVM with four layers of governance built in:

- **Structural Isolation**: The agent runs inside a VM with its own Linux kernel. Host credentials, SSH keys, and the host Docker socket are simply not present inside the VM. There is nothing to exfiltrate.
- **Credential Proxy Injection**: API keys live in your OS keychain. When the agent makes an outbound request, a host-side proxy intercepts it and injects the auth header. The raw key never enters the VM.
- **Network Policy Enforcement**: Every outbound connection passes through a policy layer (Open / Balanced / Locked Down). Allowed and blocked attempts are logged in real time.
- **Branch Mode and Parallel Execution**: Agents work on isolated Git worktrees so you can review diffs before merging - and run multiple agents on the same repo simultaneously without conflicts.

This is the infrastructure that makes semi-autonomous and autonomous agent workflows safe to operate.

## Key Features

- microVM Isolation: Each sandbox is a lightweight VM with its own kernel. The boundary is enforced by the hypervisor, not by a policy file.
- Credential Proxy: API keys stay on the host. Authentication happens at the proxy layer so the agent never sees the raw key.
- Network Policy: Pick Open, Balanced, or Locked Down at login. Override per-sandbox. Watch every connection in a live audit log.
- Branch Mode: Agent work lands on its own Git worktree and branch. Review the diff, then merge - or throw it away.
- Parallel Agents: Run multiple agents on the same codebase at once. Each gets its own worktree. No file-locking, no conflicts.
- Local Model Support: Run open-source models inside sbx via Docker Model Runner. Zero cloud egress, zero API keys, fully air-gapped workflows.
- Pluggable Agents: Works with Codex, Claude Code, Gemini CLI, and any agent image you publish.


- Developers Running Coding Agents: Run Claude Code, Codex, or Gemini CLI without giving them access to your SSH keys, AWS credentials, or host Docker daemon.
- Platform Engineers: Provide a paved path for agent execution across the org. Centralized network policy, centralized secret management, audit logs by default.
- Security Teams: Get the structural guarantees and the audit trail you need to sign off on agentic workloads - without blocking developer productivity.
- Enterprises Operating at Scale: The architecture that makes 30,000 concurrent governed agent sessions across a workforce a tractable problem rather than an unbounded risk.
