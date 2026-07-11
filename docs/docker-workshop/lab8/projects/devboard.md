---
title: "DevBoard - Fix a Real Bug Inside a Sandbox"
---

So far each module of this lab has focused on *one* primitive - isolation,
secret injection, network policy, branch mode. This project ties them all
together against a real codebase: **DevBoard**, a FastAPI + Next.js issue
tracker with five documented intentional bugs.

You'll pick one of them, point an agent at it inside `sbxlab`, watch it
investigate and fix, then review and merge - without the agent ever touching
your host credentials or making a network call you didn't allow.

---

## What you'll build

By the end of this project you'll have:

- A running DevBoard stack (Postgres + FastAPI + Next.js) on your host
- A running agent inside `sbxlab` with read/write access to the DevBoard repo
- A fix for one of the known bugs, landed on its own Git branch
- A passing `pytest` run inside the sandbox proving the fix
- A clean diff you reviewed before merging

---

## The codebase

DevBoard is a small but realistic project tracker. It's the same repo the
labspace clones into `~/sbx-lab` - if you've worked through Module 2, you
already have it.

```
devboard/
├── backend/                    # FastAPI + SQLAlchemy + PostgreSQL
│   ├── app/
│   │   ├── main.py
│   │   ├── models.py
│   │   ├── routers/
│   │   │   ├── auth.py
│   │   │   ├── projects.py
│   │   │   ├── issues.py       # most of the bugs live here
│   │   │   └── comments.py
│   │   └── services/
│   │       └── notifications.py
│   └── tests/
│       └── test_issues.py      # tests that expose the known bugs
├── frontend/                   # Next.js 14 App Router + Tailwind
└── docker-compose.yml
```

If you don't have it cloned yet:

```bash
git clone https://github.com/dockersamples/sbx-quickstart ~/sbx-lab
cd ~/sbx-lab
```

---

## The bugs

DevBoard ships with five intentional issues, ordered roughly easiest to hardest:

| # | Bug | File |
|---|---|---|
| 1 | **Pagination off-by-one** - `list_issues` uses `page * page_size` instead of `(page - 1) * page_size`, so page 1 always skips items. | `backend/app/routers/issues.py` |
| 2 | **`updated_at` never updates** - SQLAlchemy `updated_at` columns are missing `onupdate=datetime.utcnow`. | `backend/app/models.py` |
| 3 | **Missing authorization on issue update** - any project member can edit any issue. | `backend/app/routers/issues.py` |
| 4 | **Search not implemented** - `GET /projects/{id}/issues/search` returns `501`. | `backend/app/routers/issues.py` |
| 5 | **Email notifications are stubs** - `services/notifications.py` logs but doesn't send. | `backend/app/services/notifications.py` |

The walkthrough below uses **bug #1 (pagination)** because it's the cleanest
demonstration - single function, clear root cause, existing test coverage.
The same workflow works for any of them.

---

## Step 1 - Boot DevBoard on your host

In a host terminal, from `~/sbx-lab`:

```bash
docker compose up --build -d
```

Wait for all three services to be healthy:

```bash
docker compose ps
```

Expected output: `db`, `backend`, and `frontend` all `running`. The API is at
`http://localhost:8000/docs` and the UI at `http://localhost:3000`.

> **Why on the host and not in the sandbox?** DevBoard is the *application*.
> The agent's job is to read and modify its source files - not to run it.
> Running the stack on the host means you can poke at `localhost:3000` while
> the agent works.

---

## Step 2 - Confirm the bug exists

Hit the issues endpoint with `page=1` and a small page size:

```bash
curl -s "http://localhost:8000/projects/1/issues?page=1&page_size=2" | jq '.[] | .id'
```

You'll see issues `3` and `4` - *not* `1` and `2`. That's the bug.

The test suite already has a case that fails because of this:

```bash
docker compose exec backend pytest tests/test_issues.py::test_pagination_first_page -v
```

Expected: `FAILED`. Good - that's a failing test the agent will turn green.

---

## Step 3 - Run the agent on the codebase in branch mode

You've used **direct mode** so far (Module 6). For this exercise, use
**branch mode** instead - the agent works on its own Git worktree and you
review the diff before merging.

From the host, in `~/sbx-lab`:

```bash
sbx run sbxlab --branch fix/pagination
```

The sandbox starts up, creates a worktree at `~/sbx-lab-sbxlab-fix-pagination`,
and drops you into the agent prompt. The trust prompt appears once - choose
**1. Yes, continue**.

---

## Step 4 - Brief the agent

Paste this prompt:

```
Read backend/app/routers/issues.py and backend/tests/test_issues.py.
There's a known pagination bug in list_issues: it skips page * page_size
items instead of (page - 1) * page_size, so page 1 returns the wrong
results.

1. Locate the bug.
2. Fix it.
3. Run the test that exercises it: pytest tests/test_issues.py::test_pagination_first_page -v
4. Run the full issues test file once it passes.
5. Summarise the change.
```

The agent will:

- Read the two files using its `filesystem` tool
- Edit `list_issues` (typically replacing `skip = page * page_size` with `skip = (page - 1) * page_size`)
- Run pytest inside the sandbox via the `shell` tool

Watch the output. Inside `sbxlab`, `pytest` has access to `pypi.org` and
`files.pythonhosted.org` (default network policy) but cannot reach your host
filesystem.

---

## Step 5 - Verify what just happened

In a separate host terminal, while the agent is still running:

```bash
sbx ls
```

You'll see `sbxlab` with status `running` and the worktree path. Now look at
the worktree from the host:

```bash
cd ~/sbx-lab-sbxlab-fix-pagination
git diff
```

You should see the one-line fix to `list_issues`. The host's main worktree at
`~/sbx-lab` is untouched - `git status` there is still clean.

```bash
cd ~/sbx-lab
git status   # clean
```

Open the network panel of the dashboard while you're at it:

```bash
sbx
# press Tab to switch to Network
```

You'll see allowed connections to `pypi.org` (the agent installing test deps)
and nothing to `~/.aws`, `~/.ssh`, or any host service. The proof remains the
same as in Module 3 - only now you're running it on a real codebase change.

---

## Step 6 - Review and merge

Back in `~/sbx-lab-sbxlab-fix-pagination`:

```bash
# Re-run the test on the host to double-check
docker compose exec backend pytest tests/test_issues.py -v
```

If it's green, merge:

```bash
cd ~/sbx-lab
git merge sbxlab/fix-pagination
git branch -d sbxlab/fix-pagination
```

The agent's branch is gone, the fix is on `main`, and your working tree
matches what you reviewed.

---

## Step 7 - Tear down

```bash
sbx stop sbxlab
docker compose down
```

`sbx stop` halts the VM; the worktree on your host stays so you can re-enter
it later. `docker compose down` stops DevBoard.

---

## Pick another bug

Same flow, different brief. A few suggestions for prompts:

**Bug #2 - `updated_at` never updates:**

```
backend/app/models.py defines updated_at columns that never change after
creation. They're missing the onupdate parameter on the Column definition.
Find every affected model, add onupdate=datetime.utcnow, and write a test
that updates an issue and asserts updated_at changed.
```

**Bug #4 - implement search** (the labspace ships a prompt for this in
`prompts/implement-search.txt`):

```
Implement the issue search endpoint in backend/app/routers/issues.py.
GET /issues/search?q= currently returns 501. It should search title and
description case-insensitively (use Issue.title.ilike(f"%{q}%")) and return
the same schema as list_issues. Make the existing search tests pass.
```

**Bug #5 - implement email notifications** (a more open-ended task - needs
SMTP config and gracefully handling its absence):

```
services/notifications.py has a stub send_status_change_notification.
Implement it using smtplib (no new dependencies). Read SMTP config from
SMTP_HOST/PORT/USER/PASS env vars and warn-and-return when missing.
Include the issue title, old status, new status, and a URL in the body.
Add a test that mocks smtplib.SMTP and asserts send_message was called.
```

For #5, notice the agent will need to make outbound SMTP connections to
verify behaviour - but the default `Balanced` policy doesn't allow arbitrary
SMTP. This is a good moment to revisit Module 5: either add an `allow` rule
for your test SMTP host, or have the agent rely entirely on mocked transport
and never actually open a socket.

---

## ✅ Checkpoint

You've now run the full sandbox workflow end-to-end:

- [x] Real codebase (DevBoard) running on the host
- [x] Real agent inside the sandbox, reading and modifying source
- [x] Real fix landed on a branch, with a passing test
- [x] Reviewed the diff before it touched main
- [x] Verified - via `sbx ls` and the network panel - that the agent only
      reached what the policy allowed

That's the complete loop the rest of this lab was building toward.
