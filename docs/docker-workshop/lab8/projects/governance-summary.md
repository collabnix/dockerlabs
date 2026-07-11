---
title: "AI Governance at Enterprise Scale"
---

You've run through every major capability of Docker Sandboxes. Now let's connect what you learned to the bigger picture - and to your own team.

---

## What you proved in this lab

Go back to your reflection from Module 3. You wrote down what specific resources were not accessible from inside the sandbox. Everything you listed there is what governance protects.

Here's what you demonstrated hands-on:

| Governance Capability | How You Proved It |
|---|---|
| **Structural isolation** | Tried to access `~/.aws/credentials` and `~/.ssh/id_rsa` - not there |
| **Credential proxy injection** | Asked the agent to print its API key - it couldn't |
| **Network enforcement** | Blocked PyPI, saw the install fail in real time |
| **Audit trail** | Watched `sbx policy log` show every connection |
| **Safe review workflow** | Used branch mode to get a clean diff before merging |
| **Scale** | Ran two agents in parallel, zero conflicts |
| **Local inference** | Ran Docker Model Runner on the host, agent in the VM, zero cloud dependency |

None of these relied on a policy document. None relied on a system prompt instruction. All of them are structural.

---

## The four enterprise requirements - answered

If you were presenting this to a risk team, here's how each requirement maps:

**1. Sandbox isolation (structural, not advisory)**
MicroVM boundary. Agent runs inside its own kernel. Host credentials don't exist inside the VM. Verified by you in Module 3.

**2. BYOLLM / LLM Gateway**
Secrets are stored in the OS keychain, injected at the proxy layer. All LLM traffic routes through the host-side proxy. The gateway is the proxy. Verified in Module 4. For air-gapped deployments, local models via Docker Model Runner give you the same architecture with zero cloud dependency.

**3. Telemetry and audit logging**
`sbx policy log` shows every outbound connection - allowed or blocked - with timestamps and agent attribution. Verified in Module 5.

**4. Container customisation**
Custom templates let you pre-bake certs, proxy settings, toolchains into the sandbox image. The same policy applies whether agents run on a developer laptop, in CI, or in the cloud.

---

## The autonomy scale - where does your team sit?

| Stage | Name | Description | Governance needed |
|---|---|---|---|
| 1 | Autocomplete | Code suggestions | None |
| 2 | Assistant | Chat, explanations | None |
| 3 | Specialist | Multi-step tasks | Recommended |
| **4** | **Semi-Autonomous** | **Agent loops** | **Required** |
| **5** | **Autonomous** | **Self-directed** | **Required** |
| 6 | Steward | Long-term trust | Required + audit |

Most teams today are at stage 2–3. The question isn't whether they'll move to 4–5 - agents will get more capable, and developers will use them more autonomously. The question is whether governance is in place before that happens.

---

## Your reflection

Answer these questions before finishing the lab:

> **1.** Before this lab, how did your team run AI coding agents? Were any governance controls in place?
>
> **2.** What specific risks does your codebase have that an ungoverned agent could trigger? (Think: credentials, production configs, sensitive data files)
>
> **3.** Which of the four governance capabilities would be hardest to add after the fact, once agents are already widely deployed?
>
> **4.** What would a 20-developer pilot look like for your team? What would "success" mean after 2 weeks?

---

## What's next

**For individuals:**
- Read the [sbx documentation](https://docs.docker.com/ai/sandboxes/)
- Try the [sbx-quickstart](https://github.com/dockersamples/sbx-quickstart) with your own codebase
- Explore custom templates for your stack

**For teams:**
- Map your team's current agent usage (who's using what, with what access)
- Identify the highest-risk credential exposure scenarios
- Define your network policy - start with Balanced, move to Locked Down for production use
- Set up branch mode as the default for autonomous agent runs

**For enterprises:**
- The admin console provides org-wide policy configuration
- Pilot with 20–30 developers, 2 weeks, defined success criteria
- Audit log integration with your SIEM
- Docker Hardened Images as the sandbox base image for minimal attack surface

---

## CLI Reference

```bash
# Lifecycle
sbx create --name=X <agent> .        # create sandbox with your chosen agent
sbx run X                              # attach to sandbox
sbx run X --branch=NAME                # branch mode
sbx ls                                 # list sandboxes
sbx stop X / sbx rm X                  # pause / delete

# Inspection
sbx exec -it X bash                    # shell inside sandbox
sbx ports X --publish H:S              # port forwarding

# Network policy
sbx policy ls                          # show rules
sbx policy log X                       # live connection log
sbx policy allow network DOMAIN        # allow a domain
sbx policy deny network DOMAIN         # block a domain
sbx policy reset                       # choose new default policy

# Secrets
sbx secret set -g SERVICE              # store globally
sbx secret ls                          # list secrets
```

Valid agent values for `sbx create`: `codex`, `claude`, `gemini`, `copilot`, `kiro`, `opencode`, `docker-agent`, `shell`.

---

## ✅ Lab complete

You've earned it. You didn't just read about microVM isolation - you tried to break it. You didn't just read about secret injection - you asked the agent to expose its own key. You didn't just read about network policy - you blocked domains and watched things fail.

That's what "show don't tell" means. And that's what governance you can trust looks like.
