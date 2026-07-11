---
title: "Parallel Agents - Two Agents, One Sandbox, Zero Conflicts"
---

Branch mode isn't just for review workflows. It's how you run multiple agents simultaneously on the same codebase without any conflicts.

Each branch-mode run creates its own isolated Git worktree. Two agents on two branches never touch each other's files. Both are governed by the same network policy. Both generate audit logs.

---

## The DevBoard has two unfinished features

Perfect for parallel execution:

**Search** - `GET /issues/search?q=` returns HTTP 501. The query logic hasn't been written yet.

**Notifications** - `send_status_change_notification()` is a no-op stub. It should send emails when issue status changes.

These are independent - no shared code paths. Ideal for parallel work.

---

## Launch two agents simultaneously

Open **two host terminal windows**. Run each command in its own window at the same time.

**Terminal 1 - Search feature:**

```bash
cd ~/sbx-lab
sbx run sbxlab --branch=add-search -- "$(cat prompts/implement-search.txt)"
```

**Terminal 2 - Notifications feature:**

```bash
cd ~/sbx-lab
sbx run sbxlab --branch=add-notif -- "$(cat prompts/implement-notifications.txt)"
```

> **Note:** The `"$(cat ...)"` must be quoted or the prompt won't pass correctly.

Both run against the same `sbxlab` sandbox - no new sandbox is created. You still see one entry in `sbx ls`. Each agent has its own isolated worktree under `.sbx/sbxlab-worktrees/`.

---

## Watch both agents work

In a **third terminal**, watch the worktrees update in real time:

```bash
cd ~/sbx-lab

# Watch commits appear on each branch
watch -n 2 'git log --oneline add-search | head -5; echo "---"; git log --oneline add-notif | head -5'
```

Two agents. Two branches. Completely independent progress.

---

## Monitor the network policy log

In a **fourth terminal**:

```bash
sbx policy log sbxlab
```

You'll see both agents making API calls - all routed through the same proxy, all logged, all governed by the same policy.

---

## Review and open PRs

When both agents have finished (you'll see them exit or hit prompts):

```bash
# Review search implementation
git diff main..add-search
git diff main..add-search --stat

# Review notifications implementation
git diff main..add-notif
git diff main..add-notif --stat
```

Push and create PRs:

```bash
git push origin add-search
gh pr create --head add-search \
  --title "Implement issue search" \
  --body "Implements GET /issues/search endpoint"

git push origin add-notif
gh pr create --head add-notif \
  --title "Implement status change notifications" \
  --body "Implements email notifications on status changes"
```

---

## What this means at scale

You just ran two autonomous agents on the same repo simultaneously. Each had governance:
- Isolated VM boundary
- Secrets via proxy injection - no keys in the VM
- Network policy enforcing what they could reach
- Audit log of every connection
- Clean Git diffs for human review before merge

Now imagine this at 10,000 developers. Each developer might have 2–3 agents running simultaneously. That's potentially 30,000 concurrent agent sessions - all governed by the same central policy, all generating audit logs, all hitting the same LLM gateway.

That's the enterprise story. That's what the network policy and sandbox architecture are built for.

---

## Clean up worktrees

After reviewing and merging:

```bash
git worktree remove .sbx/sbxlab-worktrees/add-search
git worktree remove .sbx/sbxlab-worktrees/add-notif
git branch -d add-search add-notif
```

Or when you `sbx rm sbxlab`, all worktrees are cleaned up automatically.

---

## ✅ Checkpoint

Confirm:
- Two agents ran simultaneously without conflicts
- `git worktree list` showed both branches
- Both produced clean diffs reviewable by a human
- The policy log showed both agents' activity

Next: Docker Compose inside the sandbox - the full-stack use case.
