---
title: "🐛 Bug Investigator - Multi-Agent Debugging System"
---

A production-ready multi-agent system built with Docker cagent that helps developers debug and fix code issues.

## 🎯 What You'll Learn

1. Build a multi-agent system with specialized roles
2. Integrate MCP tools (search, filesystem)
3. Push agents to Docker Hub
4. Deploy to DigitalOcean for 24/7 availability

## 🏗️ Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                     BUG INVESTIGATOR                            │
│                     (Root Coordinator)                          │
│                                                                 │
│  • Analyzes errors & stack traces                              │
│  • Coordinates the debugging workflow                          │
│  • Provides final diagnosis                                     │
└─────────────────────┬───────────────────────────────────────────┘
                      │
        ┌─────────────┼─────────────┐
        ▼             ▼             ▼
┌───────────────┐ ┌───────────┐ ┌───────────┐
│  RESEARCHER   │ │   FIXER   │ │  TESTER   │
│               │ │           │ │           │
│ • Web search  │ │ • Write   │ │ • Validate│
│ • Find docs   │ │   fixes   │ │ • Test    │
│ • Solutions   │ │ • Code    │ │   cases   │
└───────────────┘ └───────────┘ └───────────┘
      │                 │             │
      ▼                 ▼             ▼
┌───────────┐    ┌───────────┐  ┌─────────┐
│ DuckDuckGo│    │ Filesystem│  │  Think  │
│    MCP    │    │   Tools   │  │  Tool   │
└───────────┘    └───────────┘  └─────────┘
```

## 🚀 Quick Start

### Prerequisites

- Docker Desktop 4.49+ (includes cagent)
- API key: `ANTHROPIC_API_KEY` or `OPENAI_API_KEY`

### Step 1: Clone and Run Locally

# Clone the repo

```
git clone https://github.com/ajeetraina/bug-investigator
cd bug-investigator/
```

# Set your API key

```
export ANTHROPIC_API_KEY=your_key_here
# OR
export OPENAI_API_KEY=your_key_here
```

# Run the agent (if using OpenAI)

```
cagent run ./cagent-openai.yaml "Read app.py and find all bugs"

```


## 📦 Deploy to Production

### Push to Docker Hub

```bash
# Login to Docker Hub
docker login

# Push your agent
cagent push ./cagent.yaml docker.io/YOUR_USERNAME/bug-investigator:latest

# Verify it's there
cagent pull docker.io/YOUR_USERNAME/bug-investigator:latest
```

### Deploy to DigitalOcean

#### Option 1: One-Click Marketplace

1. Go to [DigitalOcean Marketplace - cagent](https://marketplace.digitalocean.com/apps/cagent)
2. Click "Create cagent Droplet"
3. Choose size: `s-2vcpu-4gb` (recommended)
4. SSH into your droplet and run your agent

#### Option 2: API Deployment

```bash
# Set your DigitalOcean token
export DO_TOKEN=your_digitalocean_token

# Create droplet with cagent pre-installed
curl -X POST -H 'Content-Type: application/json' \
  -H "Authorization: Bearer $DO_TOKEN" \
  -d '{
    "name": "bug-investigator-prod",
    "region": "sfo2",
    "size": "s-2vcpu-4gb",
    "image": "cagent"
  }' \
  "https://api.digitalocean.com/v2/droplets"
```

### Run in Production

```bash
# SSH into your droplet
ssh root@YOUR_DROPLET_IP

# Set API keys
export ANTHROPIC_API_KEY=your_key

# Pull and run your agent
cagent run docker.io/YOUR_USERNAME/bug-investigator:latest
```

## 🧪 Example Bugs to Try

### Python: NoneType Error
```
TypeError: 'NoneType' object is not subscriptable
```

### JavaScript: Async/Await Issue
```
UnhandledPromiseRejectionWarning: TypeError: Cannot read property 'map' of undefined
```

### Go: Nil Pointer
```
panic: runtime error: invalid memory address or nil pointer dereference
```

### Docker: Build Failure
```
ERROR: failed to solve: failed to compute cache key: failed to calculate checksum of ref
```

### Kubernetes: CrashLoopBackOff
```
kubectl logs my-pod
Error: EACCES: permission denied, open '/app/data/config.json'
```

## 🔧 Customization

### Add GitHub Integration

```yaml
# Add to researcher agent toolsets
toolsets:
  - type: mcp
    ref: docker:github
```

### Add Slack Notifications

```yaml
# Add to root agent toolsets
toolsets:
  - type: mcp
    ref: docker:slack
```

### Use Local Models (No API Key)

```yaml
models:
  local:
    provider: dmr
    model: ai/gemma3:2B-Q4_0
    max_tokens: 4096

agents:
  root:
    model: local
    # ... rest of config
```

## 📊 Workshop Flow

```
┌──────────────────────────────────────────────────────────────────┐
│                    DEVELOPMENT TO PRODUCTION                      │
├──────────────────────────────────────────────────────────────────┤
│                                                                  │
│  1. LOCAL DEV          2. PACKAGE           3. PRODUCTION        │
│  ───────────          ─────────           ────────────           │
│                                                                  │
│  ┌──────────┐        ┌──────────┐        ┌──────────────┐       │
│  │  Create  │        │  Push to │        │  DigitalOcean │       │
│  │  Agent   │───────▶│  Docker  │───────▶│    Droplet    │       │
│  │  YAML    │        │   Hub    │        │   (1-Click)   │       │
│  └──────────┘        └──────────┘        └──────────────┘       │
│       │                   │                     │                │
│       ▼                   ▼                     ▼                │
│  cagent run         cagent push           cagent run            │
│  ./cagent.yaml      ./cagent.yaml         user/agent:tag        │
│                     user/agent:tag                               │
│                                                                  │
└──────────────────────────────────────────────────────────────────┘
```

## 🎓 Key Concepts Covered

| Concept | Description |
|---------|-------------|
| **Multi-Agent** | Specialized agents collaborating on complex tasks |
| **MCP Tools** | External capabilities via Model Context Protocol |
| **Agent Delegation** | Root agent routing tasks to specialists |
| **OCI Artifacts** | Packaging agents like container images |
| **Production Deploy** | Running agents 24/7 on cloud infrastructure |



