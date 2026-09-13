# Docker Compose Best Practices

A guide to writing effective and maintainable Docker Compose files.

## Structure Your Compose File

### Use Named Volumes for Persistence

```yaml
services:
  db:
    image: postgres:16
    volumes:
      - db-data:/var/lib/postgresql/data

volumes:
  db-data:
```

### Use Networks for Service Isolation

```yaml
services:
  frontend:
    networks:
      - frontend
  backend:
    networks:
      - frontend
      - backend
  db:
    networks:
      - backend

networks:
  frontend:
  backend:
```

### Use Environment Variables

```yaml
services:
  app:
    image: myapp
    env_file:
      - .env
    environment:
      - NODE_ENV=production
```

## Production Tips

### Always Use Specific Image Tags

```yaml
# Bad - uses latest tag
services:
  app:
    image: node

# Good - uses specific version
services:
  app:
    image: node:20-alpine
```

### Set Restart Policies

```yaml
services:
  app:
    restart: unless-stopped
```

### Add Health Checks

```yaml
services:
  web:
    image: nginx
    healthcheck:
      test: ["CMD", "curl", "-f", "http://localhost"]
      interval: 30s
      timeout: 10s
      retries: 3
```

### Use Dependencies

```yaml
services:
  db:
    image: postgres:16
  app:
    image: myapp
    depends_on:
      db:
        condition: service_healthy
```

## Development Tips

### Use Development Overrides

Create `docker-compose.override.yml` for development:

```yaml
# docker-compose.yml
services:
  app:
    build: .
    volumes:
      - ./src:/app/src

# docker-compose.override.yml (development)
services:
  app:
    environment:
      - DEBUG=true
    volumes:
      - ./src:/app/src
```

### Use Profiles for Optional Services

```yaml
services:
  app:
    image: myapp
  debug:
    image: busybox
    profiles:
      - debug
```

## Common Patterns

### Multi-Service Application

```yaml
services:
  frontend:
    build: ./frontend
    ports:
      - "3000:3000"
    depends_on:
      - backend

  backend:
    build: ./backend
    ports:
      - "8080:8080"
    depends_on:
      - db

  db:
    image: postgres:16
    volumes:
      - db-data:/var/lib/postgresql/data
    environment:
      - POSTGRES_PASSWORD=secret

volumes:
  db-data:
```

### Reverse Proxy Setup

```yaml
services:
  nginx:
    image: nginx:alpine
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - app

  app:
    image: myapp
    expose:
      - "3000"
```

## Useful Commands

```bash
# Start services
docker compose up -d

# View logs
docker compose logs -f

# Rebuild and start
docker compose up --build

# Stop and remove
docker compose down

# Stop and remove volumes
docker compose down -v

# Scale a service
docker compose up -d --scale web=3

# Execute command in service
docker compose exec app sh
```

## Troubleshooting

### View Service Configuration

```bash
docker compose config
```

### Check Service Status

```bash
docker compose ps
```

### View Resource Usage

```bash
docker compose top
```
