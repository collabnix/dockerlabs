# Dockerfile Best Practices

A guide to writing efficient and secure Dockerfiles.

## Use Multi-Stage Builds

Multi-stage builds reduce final image size by only including what's needed for production.

```dockerfile
# Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# Production stage
FROM node:20-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

## Choose the Right Base Image

```dockerfile
# Bad - uses full Ubuntu image
FROM ubuntu:22.04

# Good - uses Alpine (smaller)
FROM node:20-alpine

# Better - uses distroless (minimal)
FROM gcr.io/distroless/nodejs20-debian12
```

## Order Instructions by Change Frequency

Put rarely changing instructions first to maximize cache usage.

```dockerfile
# 1. System dependencies (rarely change)
RUN apk add --no-cache curl git

# 2. Application dependencies (change sometimes)
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

# 3. Application code (changes frequently)
COPY . .
```

## Use .dockerignore

Create a `.dockerignore` file to exclude unnecessary files.

```
node_modules
.git
.env
*.md
docker-compose*.yml
Dockerfile
.dockerignore
```

## Security Best Practices

### Run as Non-Root User

```dockerfile
# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Switch to non-root user
USER appuser

# Run application
CMD ["node", "index.js"]
```

### Use Specific Image Tags

```dockerfile
# Bad - uses latest tag
FROM node

# Good - uses specific version
FROM node:20-alpine

# Better - uses digest
FROM node:20-alpine@sha256:abc123...
```

### Scan for Vulnerabilities

```bash
# Build image
docker build -t myapp .

# Scan with Docker Scout
docker scout cves myapp
```

## Reduce Image Size

### Combine RUN Commands

```dockerfile
# Bad - creates multiple layers
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get clean

# Good - single layer
RUN apt-get update && \
    apt-get install -y --no-install-recommends curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

### Use --no-install-recommends

```dockerfile
RUN apt-get update && \
    apt-get install -y --no-install-recommends package-name && \
    rm -rf /var/lib/apt/lists/*
```

### Clean Up After Install

```dockerfile
RUN pip install --no-cache-dir -r requirements.txt
RUN npm ci --only=production && npm cache clean --force
```

## Environment Variables

### Use ENV for Configuration

```dockerfile
ENV NODE_ENV=production
ENV PORT=3000
```

### Use ARG for Build-Time Variables

```dockerfile
ARG NODE_VERSION=20
FROM node:${NODE_VERSION}-alpine
```

## Health Checks

```dockerfile
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1
```

## Example: Production Dockerfile

```dockerfile
# Build stage
FROM node:20-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY . .
RUN npm run build

# Production stage
FROM node:20-alpine

# Create non-root user
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

WORKDIR /app

# Copy dependencies and build artifacts
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package.json ./

# Set environment variables
ENV NODE_ENV=production
ENV PORT=3000

# Expose port
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1

# Switch to non-root user
USER appuser

# Start application
CMD ["node", "dist/index.js"]
```

## Common Mistakes to Avoid

1. **Don't use `latest` tag** - Use specific versions for reproducibility
2. **Don't run as root** - Use non-root users for security
3. **Don't copy everything** - Use `.dockerignore` to exclude unnecessary files
4. **Don't create unnecessary layers** - Combine RUN commands
5. **Don't store secrets in images** - Use environment variables or Docker secrets
6. **Don't ignore security scans** - Regularly scan images for vulnerabilities

## Useful Commands

```bash
# Build image
docker build -t myapp .

# Build with specific Dockerfile
docker build -f Dockerfile.prod -t myapp .

# Build without cache
docker build --no-cache -t myapp .

# Inspect image layers
docker history myapp

# Analyze image size
docker images myapp
```
