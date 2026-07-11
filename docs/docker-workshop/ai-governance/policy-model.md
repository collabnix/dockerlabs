---
title: "The Policy Model"
---

Before you run the live demo, here's the mental model.

---

## Where policies live

Policies for your organization are defined in one place:

**`https://app.docker.com/accounts/<your-org>`** → AI governance

Only org admins can modify policies. Developers cannot override them locally. That's the point.

---

## How policies reach developers

When a developer runs `docker login` with org credentials, the Docker client fetches the org's AI governance policies as part of authentication. The local `sbx` daemon caches them and applies them to every sandbox launched on that machine.

```
Admin Console  ──auth flow──▶  Developer Docker Desktop  ──cache──▶  Every sandbox
(one source
 of truth)
```

When the admin changes a policy, developers pick up the change on next sync. To force an immediate refresh:

```bash
sbx policy reset
```

(You'll be prompted to choose a default baseline. Pick **Balanced**.)

---

## How rules evaluate

Rules are evaluated **per request** at the sandbox network proxy. For an outbound HTTP request from inside a sandbox, the proxy checks:

1. Does any **deny** rule match? → Block (403)
2. Does any **allow** rule match? → Forward
3. Otherwise → Default-deny (block)

This means:

- **Explicit deny always wins.** Adding a deny rule for `paste.ee` blocks paste.ee even when a broader allow rule exists.
- **Default-deny posture** means you don't need to enumerate every bad destination. If you didn't explicitly allow it, it's blocked.
- **A `0.0.0.0/0` catch-all allow rule defeats this model** - it permits everything. We'll remove it in the next section if it's present.

---

## Local vs remote policies

Run this to see what's currently active:

```bash
sbx policy ls
```

You'll see two kinds of policies:

| `ORIGIN` column | Meaning |
| --- | --- |
| `local` | Defaults shipped with sbx, or rules you added with `sbx policy allow ...` |
| `remote` | Pulled from your org's Admin Console |

When the org has policies set for a rule type (e.g., network), local rules of that type go **inactive** - you'll see `corporate policy takes precedence and does not delegate this rule type to local policy`.

The CISO has the wheel.

---

## Confirm governance is active

Look at the top of the `sbx policy ls` output. You should see:

```
Governance: managed by <your-org>
[OK] last synced HH:MM:SS
```

If `Governance` says anything other than your org, check that you're logged in with the right account (`docker login`) and that the account is a member of your org.

That's the model. Now let's prove it works end-to-end.
