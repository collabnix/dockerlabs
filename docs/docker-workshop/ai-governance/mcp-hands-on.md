---
title: "MCP Hands-On - Registering Servers with sbx mcp"
---

*What's Next* frames **Pillar 2 - MCP Tool Governance** as roadmap. This section gets your hands on the part that's already shipping: the `sbx mcp` subcommand for registering MCP servers, fronted by the **Docker MCP Gateway**, that your sandboxed agents can call.

By the end you will have:

- An `sbx` with the `mcp` subtree enabled
- A **gateway** fronting your servers - run one locally, or use Docker's hosted control plane
- A registered MCP server, attached to a sandbox, and **verified inside the agent**

:::info[At a glance]
**Time:** ~15 minutes &nbsp;&nbsp;|&nbsp;&nbsp; **Prerequisites:** Setup and *Why AI Governance*, plus `sbx login`.
:::

---

## The one concept: `SBX_MCP_URL` must point at a gateway

The `sbx mcp` command exists in recent `sbx` builds but is **hidden** until an environment variable enables it:

```
SBX_MCP_URL is not set; MCP is not enabled
```

Setting `SBX_MCP_URL` to an absolute http/https URL does two things: it **unlocks** the `mcp` subtree in `sbx --help`, and it tells `sbx` **which gateway** to talk to. That gateway is what provisions the connection, proxies tool calls, and applies governance.

:::warning[Point `SBX_MCP_URL` at a real gateway - nothing else]
Only two values carry the full governed flow:

1. a **local Docker MCP Gateway** (`http://localhost:8811`), or
2. Docker's **hosted control plane** (`https://connect.docker.com`).

Do **not** point it at the public MCP registry (`registry.modelcontextprotocol.io`). A registry is a *catalog, not a gateway* - it can't provision anything. With it, `sbx mcp add` appears to succeed but attaching fails: the daemon logs `501` / `WARN: mcp gateway setup failed` and the agent reports **"No MCP servers configured."**
:::

---

## Step 1 - Install or upgrade `sbx`

The stable Homebrew formula may lag behind on MCP features. Use the nightly tap on macOS:

```bash
brew install docker/tap/sbx@nightly
```

If you already have stable installed, switch the symlink:

```bash
brew unlink sbx 2>/dev/null; brew link --overwrite sbx@nightly
```

On Linux or Windows, grab the latest pre-release asset from the [releases page](https://github.com/docker/sbx-releases/releases). Verify your version:

```bash
sbx version
```

---

## Step 2 - Choose your gateway

Pick one of the two methods below. Both end with `SBX_MCP_URL` exported and the `sbx mcp` subtree unlocked - the rest of the lab is identical either way.

- **Method 1 (local gateway)** is self-contained, works offline, and needs no org enablement - best for learning the mechanics.
- **Method 2 (`connect.docker.com`)** is **MCP Gateway Enterprise**: the org-governed path where policy and audit actually apply.

**🐳 Method 1 - Local gateway**


### Run a local Docker MCP Gateway

You need a gateway listening on `localhost:8811`. Get one **either** way below - they produce the same gateway.

#### Option A - Compose (self-contained, no Docker Desktop needed)

The open-source [`docker/mcp-gateway`](https://github.com/docker/mcp-gateway) is the data plane - it proxies MCP traffic to backing servers. Pull the lab's Compose file and start it:

```bash
mkdir -p ~/workdemo/mcp-gateway-lab && cd ~/workdemo/mcp-gateway-lab
curl -fsSL https://raw.githubusercontent.com/ajeetraina/labspace-ai-governance/main/labspace/assets/mcp-gateway-compose.yaml -o compose.yaml
docker compose up -d
```

:::tip[Docker CE / WSL2 without Docker Desktop]
If the gateway errors with `Docker Desktop is not running`, set `export DOCKER_MCP_IN_CONTAINER=1` before `docker compose up -d`.
:::

#### Option B - Docker Desktop MCP Toolkit

Docker Desktop **4.62+** ships the *same* gateway, managed for you:

1. **Docker Desktop → Settings → MCP Toolkit** → enable it.
2. In the **MCP Toolkit** view, enable at least one server (e.g. **DuckDuckGo**) so the gateway has something to proxy.
3. Leave Desktop running - the gateway stays up on `localhost:8811`.

#### Point `sbx` at it

```bash
export SBX_MCP_URL=http://localhost:8811
sbx daemon stop && sbx daemon start -d
```

**🏢 Method 2 - connect.docker.com**


### Docker's hosted control plane (`connect.docker.com`)

The endgame of **Pillar 2**: instead of running your own `localhost:8811`, `SBX_MCP_URL` points at Docker's **hosted MCP control plane**, which provisions a governed gateway per sandbox - the same control plane that enforces the network and filesystem policies you proved in the *Network* and *Filesystem Enforcement* demos. This is **MCP Gateway Enterprise**.

There's nothing to stand up - point `sbx` at it and restart the daemon:

```bash
export SBX_MCP_URL=https://connect.docker.com
sbx daemon stop && sbx daemon start -d
```

When you attach a server (Step 4), the daemon calls this control plane to provision a gateway and the agent connects to it. A successful attach logs a clean `200` and `mcp gateway started ... backends:N` in `sandboxd/daemon.log`. The gateway can **reject** a registration that violates org policy, inject backend secrets per request, and write every tool call to the audit trail (see *Observability*). Check [docker.com/products/ai-governance](https://www.docker.com/products/ai-governance/) for your org's enablement status.

:::tip[If servers attach but every network call is denied]
If the agent can't reach its own API and `apt`/downloads fail, check your realm. `governance policy evaluation ... allowed:false ... policy_deny_reason:"implicit"` in the daemon log means **no policies loaded** - usually because the policy/audit backend is unreachable. If the log shows a `*.stage-*.aws.dckr.io` endpoint timing out, you're on the **staging** realm: `unset DOCKER_AUTH_STAGING && docker logout && docker login` to your prod org, then restart the daemon. Governance is **fail-closed** - no policy means deny-all.
:::


### Confirm the subtree is unlocked

Either method leaves `SBX_MCP_URL` exported. Confirm the commands appear:

```bash
sbx mcp --help
```

```
Available Commands:
  add         Register an MCP server
  auth        Authorize MCP servers
  bundle      Manage MCP server bundles
  inspect     Show MCP server details
  load        Load an already-registered MCP server into a running sandbox
  ls          List registered MCP servers
  rm          Remove a registered MCP server
```

Note `load` (attaches into a **running** sandbox) and that the attach flag on `sbx run` is `--static-mcp`, **not** `--mcp` (Step 4).

---

## Step 3 - Register a server

We'll register the Wikipedia MCP server as a **local stdio** container - the most reliable path, needs nothing beyond your machine:

```bash
sbx mcp add local-wiki --command docker --args "run,-i,--rm,mcp/wikipedia-mcp"
```

`--command` is an executable path (not a shell string) and `--args` is a **comma-separated** list - these map to `docker run -i --rm mcp/wikipedia-mcp`. Confirm it landed:

```bash
sbx mcp ls
sbx mcp inspect local-wiki
```

:::note
`sbx mcp inspect` shows only the **registration record** (name, type, resolved command). It does **not** start the server or list its tools - the real proof comes inside the agent in Step 5.
:::

:::warning[Local stdio servers run on the HOST, not in the sandbox]
They run with your full user permissions. Use them for development, not for code you don't trust. This is exactly the risk the gateway exists to govern.
:::

Two other registration modes work the same way against either gateway:

- **Remote OAuth:** `sbx mcp add notion --url https://mcp.notion.com/mcp` (must be `https`; add `--skip_auth` to register before completing OAuth).
- **docker.io image:** `sbx mcp add ddg-image --url docker.io/mcp/duckduckgo` (OCI refs must be on `docker.io`; the gateway pulls and runs it with container isolation).

---

## Step 4 - Attach the server to a sandbox

:::warning[The flag is `--static-mcp`, not `--mcp`]
Registering only *records* the server. `sbx run claude --mcp local-wiki` fails with `ERROR: unknown flag: --mcp` - that flag doesn't exist. The attach flag is **`--static-mcp`**.
:::

```bash
# Bring up a sandbox with the server attached from the start
sbx run claude --static-mcp local-wiki

# ...or load it into a sandbox that's already running
sbx mcp load local-wiki
```

---

## Step 5 - Verify inside the agent

The real proof is in the running agent. In the sandbox's Claude Code, run:

```
/mcp
```

You'll see **one** server - the gateway - aggregating every backend you attached:

```
Manage MCP servers
1 server
  mcp-gateway · ✔ connected · 24 tools
```

:::info[The agent connects to one `mcp-gateway` endpoint, not to your servers directly]
Your backend's tools are aggregated *behind* the gateway. Press Enter on `mcp-gateway` to expand them - each tool is namespaced `mcp__mcp-gateway__<tool>` (e.g. `mcp__mcp-gateway__search_wikipedia`). That single governed endpoint is the whole point of Pillar 2: every tool call flows through the gateway, where policy and audit apply.

If `/mcp` instead lists `claude.ai …` connectors plus `claude-in-chrome` / `computer-use` built-ins, you're looking at your **host** Claude Code, not the sandbox - switch to the window launched by `sbx run`.
:::

Now make the agent actually call a tool. Esc out of `/mcp` and prompt it:

```
Use the wiki tools to search Wikipedia for "Eiffel Tower", then give me the
summary and 3 key facts. Tell me which tool(s) you called.
```

A tool-call line such as `mcp-gateway · search_wikipedia` (approve it if prompted) and an answer drawn from the live article confirm the **complete chain**: `sbx → mcp-gateway → local-wiki → Wikipedia`, every call through the governed gateway.

---

## Step 6 - Clean up

```bash
sbx mcp rm local-wiki 2>/dev/null; sbx mcp ls
```

If you ran the Compose gateway (Method 1, Option A), stop it too:

```bash
cd ~/workdemo/mcp-gateway-lab && docker compose down
```

---

## How this connects to Pillar 2

Everything you did was on the **developer side**: registering servers from your CLI, fronted by the Docker MCP Gateway. The governance side - the org admin approving catalogs, restricting tool sets, injecting per-request secrets, auditing every call - sits in front of the same `sbx mcp` machinery and the same gateway that `SBX_MCP_URL` points at.

With **Method 1** you front your own gateway and control what's registered. With **Method 2 (`connect.docker.com`)** your org admin controls what's *registerable*, and every tool call lands in the audit trail you'll explore in *Observability*.

---

## Quick recap

You proved:

- `sbx mcp` is gated behind `SBX_MCP_URL`, which must point at a **real gateway** - a **local** one (`localhost:8811`) or Docker's **hosted control plane** (`https://connect.docker.com`). The public registry is a catalog and cannot carry the flow.
- A local gateway can be run via your own Compose stack or Docker Desktop's MCP Toolkit - interchangeable.
- The attach flag is `--static-mcp` (not `--mcp`); `sbx mcp load` attaches into an already-running sandbox.
- Inside the agent, the gateway appears as a single aggregated `mcp-gateway` server - the governed endpoint every tool call flows through.
