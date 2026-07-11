---
title: "Reviewing Agent Changes"
---

The agent has full write access to your workspace directory. Files it creates
or modifies appear on your host immediately. This is by design, it's what
makes the agent useful.

But full write access includes files that **execute code automatically** when
you commit, build, or open your project. Review these before you act on them.

---

## What the agent can touch

The agent can create, modify, and delete any file in the workspace including:

| File type | When it executes |
|---|---|
| `.git/hooks/` | On every `git commit`, `git push`, etc. |
| `.github/workflows/` | On every push to GitHub |
| `Makefile`, `package.json` scripts | During build or install |
| `.vscode/tasks.json`, `.idea/` | When you open the project in your IDE |
| Shell scripts and executables | When run directly |
| `.env`, config files | When your app starts |

> **The risk:** An agent running malicious or buggy code could modify a Git
> hook that then runs on your host every time you commit. The microVM protects
> your host *while the agent is running* but files written to your workspace
> persist after the session ends.

---

## Always review before you act

After every agent session, before you commit, build, or open the project:

### Direct mode (default)

Run `git diff` to see changes in your working tree, and `git status` to check
what files were modified.

### Branch mode

Run `git diff main..my-feature` to see the agent's changes on a separate branch.

---

## The hidden danger: Git hooks

Git hooks live inside `.git/hooks/` - they are **not tracked by Git** and
do **not appear in `git diff` output**. An agent could modify a hook and you'd
never see it in a normal diff.

Always check hooks separately after an agent session by running
`ls -la .git/hooks/` and reading any recently modified files with
`cat .git/hooks/pre-commit` before running any Git commands.

---

## Prove it yourself

Let's demonstrate this. First, make sure you are in your sbx workspace:

```bash
cd ~/sbx-lab
```

Start your sandbox:

```bash
sbx run sbxlab
```

Ask the agent to create a Git hook:

```text
Create a pre-commit hook that prints "hello from the agent" before every commit
```

Exit the sandbox:

```bash
exit
```

The microVM is now gone. Check the hook on your host:

```bash
ls -la .git/hooks/
```

Look for `pre-commit` with a recent timestamp - created by the agent, now
living on your Mac.

```bash
cat .git/hooks/pre-commit
```

Expected output:

```
#!/usr/bin/env bash
echo "hello from the agent"
```

Now trigger it:

```bash
git commit --allow-empty -m "test hook"
```

Expected output:

```
hello from the agent
[main 9c1f07e] test hook
```

That's agent-written code running on your Mac. The microVM is gone - but the
file persists and executes with your full host privileges.

> **This is not a bug. This is the expected behavior.**
>
> sbx isolates the agent while it runs. It does not sanitize what the agent
> writes to your workspace. Review before you execute.

---

## Cleaning up

To remove the hook the agent created:

```bash
rm .git/hooks/pre-commit
```

To reset all hooks to their default state:

```bash
find .git/hooks -type f ! -name "*.sample" -delete
```

---

## Branch mode: the safer workflow for untrusted tasks

When you're not sure what an agent will do, use branch mode. The agent still
has full write access - but its changes land on a separate worktree and branch,
not your main working tree.

```bash
sbx run sbxlab --branch=agent-experiment
```

sbx creates a new worktree at `~/sbxlab-worktrees/agent-experiment` and opens
the agent there. Your `~/sbx-lab` working tree is untouched while the agent runs.

When the agent is done, exit the sandbox:

```bash
exit
```

Now review what changed before touching anything:

```bash
cd ~/sbx-lab
git diff main..agent-experiment
```

Check git hooks separately - they won't appear in the diff:

```bash
ls -la ~/sbxlab-worktrees/agent-experiment/.git/hooks/
```

If you're happy with the changes, merge:

```bash
git merge agent-experiment
```

If not, discard everything:

```bash
git branch -D agent-experiment
```

Pay special attention to the same file types - Git hooks, CI config, build
files, IDE config. Even in branch mode, review before you merge.

> **Branch mode is not a security boundary.** The agent still has full write
> access to the worktree. It gives you a clean diff to review - not protection
> from malicious writes.

---

## The mental model

Think of the agent like a contractor with keys to your workspace:

- **While inside the sandbox**: fully isolated, can't touch your other systems
- **Files written to workspace**: persist on your host after the session
- **Your responsibility**: review what was written before running any of it

This is the same trust model you'd apply to any open source dependency or
pull request from an external contributor. Review before you trust.

---

## ✅ Checkpoint

Before moving on:

- [ ] Run `cd ~/sbx-lab` before testing hooks - git hooks are per-repository
- [ ] Run `git diff` after an agent session and review the changes
- [ ] Check `.git/hooks/` separately - it won't appear in `git diff`
- [ ] Understand that branch mode gives you a clean diff to review, but is not
      a security boundary
- [ ] Know how to remove or reset hooks the agent created

Next: secrets without exposure - how sbx injects credentials without the agent
ever seeing them.
