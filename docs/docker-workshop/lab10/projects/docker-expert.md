---
title: "Docker Expert Team"
---

This demo presents a complex multi-agent system with Docker specialists that can containerize applications, optimize Dockerfiles, and add some fun along the way.

## Configuration

Create a file named `docker-expert.yaml`:

```yaml
agents:
  root:
    model: openai/gpt-4o
    description: You are an expert in Docker
    sub_agents: [containerize, optimize_dockerfile, pirate]
    toolsets:
      - type: filesystem
      - type: think
      - type: memory
        path: docker_memory.db

  containerize:
    model: openai/gpt-4o
    description: Containerizing applications specialist
    instruction: |
      You specialize in creating Dockerfiles and docker-compose files.
      Analyze applications and create optimal containerization strategies.
    toolsets:
      - type: filesystem
      - type: think
      - type: memory
        path: docker_memory.db

  optimize_dockerfile:
    model: openai/gpt-4o
    description: Docker optimization specialist
    instruction: |
      You optimize existing Dockerfiles using BuildKit features.
      Focus on reducing image size, build time, and security.
    toolsets:
      - type: filesystem
      - type: think
      - type: memory
        path: docker_memory.db

  pirate:
    model: openai/gpt-4o
    description: An agent that talks like a pirate
    instruction: |
      Always respond in pirate speak.
      Add humor and nautical references to Docker concepts.
```

## Running the Agent

```bash
./bin/cagent run docker-expert.yaml
```

## Agent Specializations

| Agent | Expertise |
|-------|----------|
| `root` | Docker expert coordinator |
| `containerize` | Creates Dockerfiles and Compose files |
| `optimize_dockerfile` | Optimizes for size, speed, and security |
| `pirate` | Fun responses in pirate speak |

## Example Interactions

### Containerizing an Application

```
> I have a Node.js Express app, can you containerize it?

--- Agent: root ---

I'll delegate this to our containerization specialist.

--- Agent: containerize ---

I'll create optimized Docker configuration for your Express app.

[Creating Dockerfile...]

# Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# Production stage
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY . .
USER node
EXPOSE 3000
CMD ["node", "server.js"]

[Creating docker-compose.yml...]

version: '3.8'
services:
  app:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
```

### Optimizing a Dockerfile

```
> Can you optimize this Dockerfile? [pastes Dockerfile]

--- Agent: optimize_dockerfile ---

I'll analyze and optimize your Dockerfile:

Improvements applied:
1. ✅ Multi-stage build to reduce final image size
2. ✅ Using alpine base for smaller footprint
3. ✅ Layer caching optimization for faster builds
4. ✅ Non-root user for security
5. ✅ BuildKit cache mounts for dependencies
```

### Having Fun with Docker

```
> Explain Docker volumes in a fun way

--- Agent: pirate ---

Arrr, matey! Let me tell ye about Docker volumes, the treasure chests of the container seas!

Ye see, when yer container ships sink (or be stopped), all the booty inside goes down with 'em. But with volumes, ye can stash yer precious data in a secret cove on the mainland!

```bash
# Create a treasure chest, err... volume
docker volume create me_treasure

# Mount it to yer ship
docker run -v me_treasure:/app/data me_container
```

Now even if yer container walks the plank, yer data be safe on shore! Savvy? 🏴‍☠️
```

## Key Takeaways

- Complex agent teams can combine serious specialists with personality agents
- Each sub-agent has focused expertise and instructions
- The root agent intelligently routes based on query context
- This pattern creates engaging, capable AI assistants
