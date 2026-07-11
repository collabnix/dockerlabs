---
title: "Filesystem Enforcement Demo"
---

Network was the first half of Pillar 1. Filesystem is the other half - and arguably the more visceral one for security teams. *"The agent can't steal SSH keys"* lands harder than *"the agent can't reach paste.ee."*

:::note[A key difference from the Network demo]
Filesystem rules are checked **at sandbox creation time**, not at file-access time inside the sandbox. The sandbox refuses to be created with a denied mount, instead of letting it in and blocking reads later. That's a stronger model - the denied mount never exists inside the sandbox.
:::

:::info[At a glance]
**Time:** ~10 minutes &nbsp;&nbsp;|&nbsp;&nbsp; **Prerequisites:** You completed the Network Enforcement Demo.
:::

---

## What you'll prove

- Sandbox creation **fails** for paths not covered by any allow rule (default-deny)
- Sandbox creation **fails** when an additional mount targets a denied path
- Sandbox creation **succeeds** for paths in an allow rule
- Read and Write are scoped independently at the mount layer

---

## Step 1 - Open the Admin Console

Open **`https://app.docker.com/accounts/<your-org>`** and navigate to **AI governance** → **Filesystem access**.

The page works the same way as Network access, but rules are scoped to paths (with glob support) and actions (Read / Write).

---

## Step 2 - Add the allow rule for the test directory

You need at least one allow rule so the sandbox can be created. Add:

- Action: **Allow**
- Filesystem path: `~/labspace-fs-test/**`
- Action scope: **Read, Write**
- Name: `allow lab test directory`

The `**` matches recursively. You can add other allow rules for `~/work/`, `~/code/`, etc., but the dedicated test directory keeps the lab isolated.

---

## Step 3 - Add the deny rule

This is the rule that earns its keep.

- Action: **Deny**
- Filesystem path:
  ```
  ~/.ssh/**
  ~/.aws/**
  ~/.config/gcloud/**
  ~/.kube/config
  ~/.docker/config.json
  ```
- Action scope: **Read, Write** (both)
- Name: `deny credentials`

That covers SSH keys, AWS creds, GCloud creds, K8s config, and Docker registry auth - the five places agents most commonly leak secrets from.

---

## Step 4 - Remove any catch-all

If a rule exists with path `~/**` or `/**` and action Allow, **delete it**. A catch-all allow defeats every deny rule - same trap as Network.

---

## Step 5 - Verify policies reached your machine

```bash
sbx policy reset
```

Choose **Balanced** when prompted.

```bash
sbx policy ls
```

Scroll to filesystem rules. You should see `allow lab test directory` and `deny credentials` with `ORIGIN: remote`.

---

## Step 6 - Create the test directories

Three separate workdirs so each `sbx run` creates a fresh sandbox without name collision:

```bash
mkdir -p ~/labspace-fs-test/test-1
mkdir -p ~/labspace-fs-test/test-2
mkdir -p /tmp/labspace-fs-test-3
```

---

## Step 7 - Test 1: Allowed workdir, no extra mounts

```bash
cd ~/labspace-fs-test/test-1
sbx run shell .
```

**Expected:** sandbox starts. You land at the shell prompt.

```bash
exit
```

✅ The `allow lab test directory` rule permits the mount.

---

## Step 8 - Test 2: Allowed workdir + denied extra mount

```bash
cd ~/labspace-fs-test/test-2
sbx run shell . ~/.ssh:ro
```

**Expected error:**

```
ERROR: failed to create sandbox: ... status 403: mount policy denied:
/Users/<you>/.ssh: ... action=fs:mount:read,
resource=fs:path:/Users/<you>/.ssh
```

✅ The sandbox **never starts**. The `deny credentials` rule blocks `~/.ssh:ro` at creation.

---

## Step 9 - Test 3: Unallowed workdir (default-deny)

```bash
cd /tmp/labspace-fs-test-3
sbx run shell .
```

**Expected error:**

```
ERROR: failed to create sandbox: ... status 403: mount policy denied:
/private/tmp/labspace-fs-test-3: no applicable policies for
op(action=fs:mount:write, resource=fs:path:/private/tmp/labspace-fs-test-3)
```

✅ The sandbox **never starts**. No allow rule covers `/tmp/labspace-fs-test-3`, default-deny applies.

:::note
macOS resolves `/tmp` to `/private/tmp` - the policy engine sees the canonical path.
:::

---

## Step 10 - Read the results

| Test | Workdir | Extra mount | Outcome | Why |
| --- | --- | --- | --- | --- |
| 1 | `~/labspace-fs-test/test-1` | none | Sandbox starts | Covered by `allow lab test directory` |
| 2 | `~/labspace-fs-test/test-2` | `~/.ssh:ro` | 403, no sandbox | Blocked by `deny credentials` |
| 3 | `/tmp/labspace-fs-test-3` | none | 403, no sandbox | No applicable policy → default-deny |

Same three-decision pattern as the network demo, just at a different layer:

| Layer | Pattern |
| --- | --- |
| Network (previous section) | curl gets 200/404 (allowed) or 403 (denied) |
| Filesystem (this section) | sandbox creation succeeds (allowed) or fails with 403 (denied) |

---

## Cleanup (optional)

If you want to remove the test sandboxes between runs:

```bash
sbx ls
```

Then remove the entries listed. Cleanup subcommand varies by sbx version - check `sbx --help` for `rm`, `delete`, or `stop`.

---

## What you just demonstrated

The policy engine **prevents the sandbox from being created** with a denied mount. Enforcement happens *before* the agent ever runs.

This is stronger than runtime filtering - no race condition where the agent might briefly see denied data, no partial reads, no leaked file handles. The denied mount simply never exists in the sandbox.

Combined with the Network demo, Pillar 1 is now proven end-to-end:

- **Network egress** - agent can't reach unapproved destinations (proxy intercept)
- **Filesystem access** - agent can't even mount unapproved paths (creation-time denial)

---

## Common questions

**"What if the developer runs sbx from outside an allowed directory?"**
They get the default-deny error from Test 3. They have to work in an org-approved directory or get a rule added.

**"What about files written inside the sandbox?"**
Writes go to the explicit workspace (the mount that got `fs:mount:write`). When the sandbox exits, writes persist on the host - but only at allowed paths.

**"Can the developer override governance locally?"**
No. Local sbx options can adjust convenience flags but can't bypass `ORIGIN: remote` policies. Once the org sets filesystem rules, they're authoritative.

**"How does this interact with the Network rules from the previous section?"**
Both run through the same policy engine. Filesystem ops hit `fs:mount:*` checks; network calls hit network checks. Both share the audit trail covered in Observability.

Move on to **MCP Hands-On** to get your hands on Pillar 2.
