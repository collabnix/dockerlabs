# Docker Troubleshooting Guide

Common Docker issues and their solutions.

## Container Won't Start

### Problem: Container exits immediately after starting

**Check container logs:**
```bash
docker logs <container>
```

**Common causes:**
- The container's main process exits (e.g., a script finishes)
- The image expects different arguments or environment variables
- Port is already in use

**Solution:**
```bash
# Check if port is in use
docker ps -a | grep <port>

# Run interactively to debug
docker run -it <image> sh
```

### Problem: "port is already allocated"

```bash
# Find what's using the port
docker ps --format "table {{.Names}}\t{{.Ports}}" | grep :8080

# Stop the conflicting container
docker stop <container>
```

## Permission Denied

### Problem: "permission denied while trying to connect to the Docker daemon socket"

```bash
# Add user to docker group (Linux)
sudo usermod -aG docker $USER

# Or run with sudo (not recommended for production)
sudo docker <command>
```

### Problem: "permission denied" for volume mounts

```bash
# Fix volume permissions
docker run -v $(pwd):/app -u $(id -u):$(id -g) <image>
```

## Image Issues

### Problem: "image not found" or "manifest unknown"

```bash
# Check if image exists locally
docker images | grep <image>

# Pull the image explicitly
docker pull <image>:<tag>

# Check available tags
docker search <image>
```

### Problem: "no space left on device"

```bash
# Check Docker disk usage
docker system df

# Clean up unused resources
docker system prune -a

# Remove specific images
docker rmi <image>
```

## Network Issues

### Problem: Containers can't communicate

```bash
# Check if containers are on the same network
docker network inspect <network>

# Connect container to network
docker network connect <network> <container>

# Test connectivity between containers
docker exec -it <container> ping <other-container>
```

### Problem: "name is already in use"

```bash
# Remove the old container with the same name
docker rm <container>

# Or run with a different name
docker run --name <new-name> <image>
```

## Docker Compose Issues

### Problem: "docker-compose" command not found

```bash
# Use docker compose (v2) instead
docker compose up

# Or install docker-compose v1 (deprecated)
sudo apt install docker-compose
```

### Problem: Services won't start together

```bash
# Check service dependencies
docker compose ps

# View logs for all services
docker compose logs

# Restart specific service
docker compose restart <service>
```

### Problem: "network already exists"

```bash
# Remove the network
docker network rm <network>

# Or use a different network name
docker compose -p <project> up
```

## Performance Issues

### Problem: Docker is slow

```bash
# Check resource usage
docker stats

# Limit container resources
docker run --cpus=1 --memory=512m <image>

# Check Docker Desktop settings (Mac/Windows)
# Increase CPU and memory allocation
```

## Getting More Help

- [Docker Documentation](https://docs.docker.com/)
- [Docker GitHub Issues](https://github.com/moby/moby/issues)
- [Stack Overflow - Docker Tag](https://stackoverflow.com/questions/tagged/docker)
- [Docker Community Slack](https://dockercommunity.slack.com/)
