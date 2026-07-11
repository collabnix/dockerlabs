---
title: "Introduction to Docker Sandbox Kits"
---

So far in this lab you've been running agents directly with `sbx run`. That works great for one-off sessions. But what happens when you want to:

- Give every sandbox the same linting rules?
- Make sure a specific API's credentials never enter the VM?
- Share your exact sandbox setup with a teammate in one command?

That's what **kits** solve. A kit is a declarative artifact - a `spec.yaml` file plus an optional `files/` directory - that packages everything a sandbox needs: tools to install, files to inject, network rules to enforce, and credentials to wire up through the proxy.

---

## Two kinds of kits

**Mixin kits** (`kind: mixin`) extend an existing agent. You can stack several on the same sandbox with multiple `--kit` flags. Use these for adding tools, dropping in config files, or granting access to a new service.

**Agent kits** (`kind: agent`) define a full agent from scratch - image, entrypoint, network policy, credentials, everything. The built-in `claude` agent you've been using is itself defined as a kit. You can fork it and change just what you need.

---

## What a kit can do

| Capability | What it means in practice |
|---|---|
| `commands.install` | Runs once at sandbox creation - installs tools, downloads binaries |
| `commands.startup` | Runs every time the sandbox starts - launches background services |
| `commands.initFiles` | Writes files with runtime values (like `${WORKDIR}`) substituted in |
| `files/` directory | Static files dropped into `/home/agent/` or the workspace at creation |
| `network.allowedDomains` | Domains the sandbox can reach; everything else is blocked |
| `credentials.sources` | Where the proxy reads secrets on the host - they never enter the VM |
| `environment.proxyManaged` | Env var names whose values are injected by proxy at request time |

In the sections that follow, you'll build two real kits and run them against this workspace.
