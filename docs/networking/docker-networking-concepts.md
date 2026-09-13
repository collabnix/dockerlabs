# Docker Networking Concepts

A guide to understanding Docker networking and choosing the right network type.

## Network Types

### Bridge Network (Default)

The default network driver. Containers on the same bridge network can communicate with each other.

```bash
# Create a bridge network
docker network create my-bridge

# Run containers on the network
docker run -d --name web --network my-bridge nginx
docker run -d --name app --network my-bridge myapp
```

**Use cases:**
- Single-host communication between containers
- Development environments
- Simple multi-container applications

### Host Network

Container shares the host's network stack. No network isolation.

```bash
# Run with host networking
docker run -d --network host nginx
```

**Use cases:**
- Performance-critical applications
- When container needs to use host's network interfaces directly
- Legacy applications that expect host networking

### Overlay Network

Enables communication between containers across multiple Docker hosts (Swarm mode).

```bash
# Create an overlay network
docker network create --driver overlay my-overlay
```

**Use cases:**
- Multi-host communication in Docker Swarm
- Distributed applications
- Clustered services

### Macvlan Network

Assigns a MAC address to each container, making it appear as a physical device on the network.

```bash
# Create a macvlan network
docker network create -d macvlan \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.1 \
  -o parent=eth0 \
  my-macvlan
```

**Use cases:**
- Legacy applications that expect to be directly connected to the physical network
- Applications that require MAC address-based identification
- Network monitoring tools

### None Network

Disables all networking for the container.

```bash
# Run with no networking
docker run -d --network none myapp
```

**Use cases:**
- Security-sensitive applications
- Batch processing jobs
- When network access is not required

## Container Communication

### By Container Name

Docker provides DNS resolution for containers on the same network.

```bash
# Containers can reach each other by name
docker exec app ping web
```

### By IP Address

```bash
# Get container IP
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' web

# Connect to container by IP
docker exec app ping 172.18.0.2
```

## Port Mapping

### Publish Container Ports to Host

```bash
# Map host port 8080 to container port 80
docker run -p 8080:80 nginx

# Map to specific host interface
docker run -p 127.0.0.1:8080:80 nginx

# Map UDP ports
docker run -p 53:53/udp dns-server
```

### Expose Ports Without Publishing

```bash
# Expose port to linked containers
docker run --expose 8080 myapp
```

## DNS Configuration

### Custom DNS Server

```bash
# Use custom DNS
docker run --dns 8.8.8.8 myapp
```

### Custom DNS Search Domain

```bash
# Add DNS search domain
docker run --dns-search example.com myapp
```

## Network Security

### Isolate Containers

```bash
# Create isolated network
docker network create isolated

# Run sensitive container on isolated network
docker run -d --network isolated db
```

### Restrict Inter-Container Communication

```bash
# Disable container-to-container communication
docker network create --opt com.docker.network.bridge.enable_icc=false my-network
```

## Common Commands

```bash
# List networks
docker network ls

# Inspect a network
docker network inspect my-network

# Connect container to network
docker network connect my-network my-container

# Disconnect container from network
docker network disconnect my-network my-container

# Remove a network
docker network rm my-network

# Remove unused networks
docker network prune
```

## Choosing a Network

| Network Type | Isolation | Multi-Host | Performance | Use Case |
|-------------|-----------|------------|-------------|----------|
| Bridge | Container | No | Good | Default, single-host apps |
| Host | None | No | Best | Performance-critical apps |
| Overlay | Container | Yes | Good | Swarm, distributed apps |
| Macvlan | Container | No | Good | Legacy apps, network tools |
| None | Complete | No | Best | Security, batch jobs |

## Troubleshooting

### Check Container Network Settings

```bash
docker inspect --format='{{json .NetworkSettings}}' container
```

### Test Network Connectivity

```bash
# From host to container
docker exec container ping localhost

# Between containers
docker exec container1 ping container2

# DNS resolution
docker exec container nslookup container2
```

### View Network Connections

```bash
docker network inspect my-network | grep -A 5 "Containers"
```
