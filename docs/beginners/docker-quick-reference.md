# Docker Quick Reference

A concise reference for the most commonly used Docker commands.

## Images

| Command | Description |
|---------|-------------|
| `docker pull <image>` | Pull an image from a registry |
| `docker images` | List local images |
| `docker rmi <image>` | Remove an image |
| `docker image prune` | Remove unused images |
| `docker tag <image> <tag>` | Tag an image |
| `docker push <image>` | Push an image to a registry |
| `docker save <image> > file.tar` | Export an image to a tar file |
| `docker load < file.tar` | Import an image from a tar file |

## Containers

| Command | Description |
|---------|-------------|
| `docker run -d <image>` | Run a container in detached mode |
| `docker run -it <image> bash` | Run a container interactively with bash |
| `docker run -p 8080:80 <image>` | Run with port mapping |
| `docker run -v /host:/container <image>` | Run with volume mount |
| `docker run --name <name> <image>` | Run with a custom name |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers (including stopped) |
| `docker stop <container>` | Stop a running container |
| `docker start <container>` | Start a stopped container |
| `docker restart <container>` | Restart a container |
| `docker rm <container>` | Remove a stopped container |
| `docker rm -f <container>` | Force remove a running container |
| `docker exec -it <container> bash` | Execute bash in a running container |
| `docker logs <container>` | View container logs |
| `docker logs -f <container>` | Follow container logs |
| `docker inspect <container>` | View container details |
| `docker stats` | View resource usage for all containers |
| `docker cp <container>:<path> .` | Copy files from a container |
| `docker container prune` | Remove all stopped containers |

## Docker Compose

| Command | Description |
|---------|-------------|
| `docker compose up -d` | Start services in detached mode |
| `docker compose down` | Stop and remove services |
| `docker compose ps` | List running services |
| `docker compose logs` | View service logs |
| `docker compose build` | Build/rebuild services |
| `docker compose pull` | Pull service images |
| `docker compose exec <service> bash` | Execute bash in a service |
| `docker compose config` | Validate and view configuration |
| `docker compose up --build` | Rebuild and start services |

## Networking

| Command | Description |
|---------|-------------|
| `docker network ls` | List networks |
| `docker network create <name>` | Create a network |
| `docker network rm <name>` | Remove a network |
| `docker network inspect <name>` | View network details |
| `docker network connect <network> <container>` | Connect a container to a network |
| `docker network disconnect <network> <container>` | Disconnect a container from a network |

## Volumes

| Command | Description |
|---------|-------------|
| `docker volume ls` | List volumes |
| `docker volume create <name>` | Create a volume |
| `docker volume rm <name>` | Remove a volume |
| `docker volume inspect <name>` | View volume details |
| `docker volume prune` | Remove unused volumes |

## System

| Command | Description |
|---------|-------------|
| `docker info` | View system information |
| `docker version` | View Docker version |
| `docker system df` | View disk usage |
| `docker system prune` | Remove unused data |
| `docker system prune -a` | Remove all unused data (including images) |
| `docker login` | Log in to a registry |
| `docker logout` | Log out from a registry |

## Build

| Command | Description |
|---------|-------------|
| `docker build -t <tag> .` | Build an image from Dockerfile |
| `docker build --no-cache -t <tag> .` | Build without cache |
| `docker build -f <Dockerfile> .` | Build with a specific Dockerfile |

## Tips

- Use `--rm` flag with `docker run` to automatically remove the container when it exits
- Use `-d` flag to run containers in detached mode
- Use `--name` to give containers meaningful names
- Use `docker compose` (v2) instead of the deprecated `docker-compose` (v1)
- Use `.dockerignore` to exclude files from the build context
- Use multi-stage builds to reduce final image size
- Always use specific image tags (e.g., `nginx:1.25`) instead of `latest` in production
