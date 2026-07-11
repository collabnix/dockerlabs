---
title: "Your First Sandbox"
---

Time to get hands-on. In this module you'll start your sandbox, explore the architecture from inside and outside the VM, and get your agent running.

---

## Start the sandbox

From your host terminal, in `~/sbx-lab`:

```bash
sbx run sbxlab
```

On first run, the agent may auto-update itself:

:::note[If you chose OpenAI + Codex]

```
Starting codex agent in sandbox 'sbxlab'...
Workspace: /your/project/path

Updating Codex via `npm install -g @openai/codex`...

changed 2 packages in 4s

🎉 Update ran successfully! Please restart Codex.
```
:::

:::note[If you chose Anthropic + Claude]

```
Starting claude agent in sandbox 'sbxlab'...
Workspace: /your/project/path

Updating Claude Code via `npm install -g @anthropic-ai/claude-code`...

changed 2 packages in 4s

🎉 Update ran successfully! Please restart Claude Code.
```
:::

:::note[If you chose Google + Gemini]

```
Starting gemini agent in sandbox 'sbxlab'...
Workspace: /your/project/path

Updating Gemini CLI...
```
:::

If you see an update message, re-run `sbx run sbxlab`. You will then see the trust prompt:

```
  Do you trust the contents of this directory? Working with untrusted
  contents comes with higher risk of prompt injection.

› 1. Yes, continue
  2. No, quit
```

Select **1. Yes, continue**.

---

## Explore the codebase

Once the agent is running, give it this prompt:

```
Explore this codebase and give me:
1. A summary of the architecture and tech stack
2. How to run it locally without Docker Compose
3. What the test suite covers
4. Any obvious issues or areas of concern
```

The agent will read the source files and report back. Watch it work - it's reading the actual files from your `~/sbx-lab` directory.

---

## What's happening under the hood

While the agent is working, open a **second terminal on your host** and run:

```bash
# These show the sandbox is a VM, not a container
docker ps          # sbxlab does NOT appear here
sbx ls             # sbxlab appears HERE instead
```

Expected output from `sbx ls`:

```
SANDBOX   AGENT      STATUS    PORTS   WORKSPACE
sbxlab    <agent>   running           /your/project/path
```

The sandbox isn't a container on your host - it's a VM. That distinction matters, and you'll prove it hands-on in the next module.

---

## Understanding the workspace mount

Your `~/sbx-lab` directory is mounted into the VM at the same absolute path. This means:

- **Changes you make on the host** appear instantly inside the sandbox
- **Changes the agent makes inside the sandbox** appear instantly on your host
- **Nothing else from your host** is accessible inside the VM

Open one of the source files in your editor on the host. Make a small change and save it. Then ask the agent inside the sandbox to read that file. It sees your change immediately - no sync delay, no copy step.

---

## Controlling the session

| Action | Command |
|---|---|
| Exit the agent session | Press `Ctrl-C` twice |
| Open the interactive dashboard | Run `sbx` with no arguments (new terminal) |

---

## The interactive TUI dashboard

In a separate host terminal, run:

```bash
sbx
```

The dashboard shows your sandboxes as cards with live CPU and memory usage. Press `Tab` to switch to the **Network panel** - a live log of every outbound connection the sandbox makes.

Press `Ctrl-C` then `Y` to exit without stopping your sandboxes.

---

## ✅ Checkpoint

Before moving on, confirm:
- `sbx run sbxlab` worked and the agent responded
- `docker ps` on the host shows no sandbox
- `sbx ls` on the host shows `sbxlab` with status `running`
- The agent can read the codebase files

Next: the isolation proof - where you'll systematically try to break out of the VM.
