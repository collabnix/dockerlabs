---
title: "Branch Mode - Agent on Its Own Worktree"
---

So far the agent has been editing files directly in your workspace. That's **direct mode** - fast, visible, bidirectional. Good for interactive work.

**Branch mode** is different. The agent gets its own Git worktree and branch, isolated from your main working tree. You keep working normally. The agent works on its branch. You review the diff and decide whether to merge.

---

## When to use branch mode

| Direct Mode | Branch Mode |
|---|---|
| Interactive back-and-forth | Longer autonomous runs |
| Quick edits you want immediately | Changes you want to review before merging |
| Exploratory work | Production-ready feature work |
| Single agent | Multiple parallel agents |

---

## Exit your current session first

Press **Ctrl-C twice** to exit the agent session and return to your host terminal.

---

## Start a branch mode session

```bash
sbx run sbxlab --branch=fix-bugs
```

sbx creates a Git worktree at `.sbx/sbxlab-worktrees/fix-bugs` in your repo root. The agent works on its own branch and directory without touching your main working tree.

---

## Give the agent a real task

Inside the sandbox, give it this prompt:

```
Run the test suite for the FastAPI backend. Find the failing tests.
Fix the pagination bug in backend/app/main.py. Commit with a descriptive message.

Use: cd backend && pytest tests/ -v
```

The agent will take 3–5 minutes to run tests, diagnose failures, fix the bug, and commit.

---

## Monitor without interrupting

While the agent works, open a **second host terminal** and watch the worktree:

```bash
cd ~/sbx-lab

# See the worktree
ls .sbx/

# See all worktrees
git worktree list

# Watch commits appear in real time
git log --oneline fix-bugs
```

You can see exactly what the agent is doing without interrupting the session.

---

## Review the changes

When the agent is done, exit the session (Ctrl-C twice) and review:

```bash
# See the full diff
git diff main..fix-bugs

# Or just the changed files
git diff main..fix-bugs --name-only
```

The diff is clean. The agent worked on its branch. Your `main` is untouched.

---

## Push and open a PR

If you're happy with the changes:

```bash
git push origin fix-bugs

gh pr create \
  --head fix-bugs \
  --title "Fix: pagination offset bug" \
  --body "Fixes off-by-one error in list_issues() pagination"
```

This is the same PR workflow your team already uses - just with the agent as the author.

---

## Auto-naming branches

You don't have to name the branch yourself:

```bash
sbx run sbxlab --branch auto
```

sbx generates a name. Useful when you just want isolation without thinking about naming.

---

## The worktree directory

```bash
ls .sbx/
# sbxlab-worktrees/
#   fix-bugs/    ← the agent worked here
```

The worktree is a real Git worktree. It has the full repo history. It shares objects with your main clone (no duplication). When you delete the sandbox:

```bash
sbx rm sbxlab
```

The VM is deleted along with all its worktrees under `.sbx/`. Your source files in `~/sbx-lab` are untouched.

---

## ✅ Checkpoint

Confirm:
- `sbx run sbxlab --branch=fix-bugs` created a worktree at `.sbx/sbxlab-worktrees/fix-bugs`
- `git diff main..fix-bugs` shows the agent's changes
- Your `main` branch is unchanged
- `git worktree list` shows both branches

Next: running multiple agents in parallel - without conflicts.
