import { Lab } from '@/types/lab';

export const dockerComposeLab: Lab = {
  id: 'docker-compose-basics',
  title: 'Docker Compose: Multi-Container Applications',
  description: 'Learn how to use Docker Compose to define, run, and manage multi-container applications with YAML configuration files.',
  category: 'beginners',
  difficulty: 4,
  duration: '30-35 minutes',
  prerequisites: [
    'Docker installed on your system',
    'Docker Compose installed (included with Docker Desktop)',
    'Completed previous Docker labs',
    'Basic YAML syntax knowledge',
    'Understanding of containers, images, and volumes'
  ],
  tags: [
    'docker-compose',
    'yaml',
    'multi-container',
    'microservices',
    'orchestration',
    'services',
    'networks',
    'beginner'
  ],
  author: 'Docker Community',
  lastUpdated: '2024-06-30',
  featured: true,
  sections: [
    {
      id: 'introduction',
      title: 'What is Docker Compose?',
      type: 'text',
      content: `
**Docker Compose** is a tool for defining and running multi-container Docker applications. Instead of running multiple \`docker run\` commands, you define your entire application stack in a single YAML file.

**Key benefits:**
- **Single file configuration** - Define all services in one place
- **Easy orchestration** - Start/stop entire application with one command
- **Environment management** - Different configs for dev/staging/prod
- **Service dependencies** - Control startup order and dependencies
- **Network isolation** - Automatic network creation between services
- **Volume management** - Persistent data across service restarts

**Common use cases:**
- Web application + database
- Microservices architecture
- Development environments
- Testing and CI/CD pipelines
      `
    },
    {
      id: 'verify-compose',
      title: 'Verify Docker Compose Installation',
      type: 'command',
      content: 'docker-compose --version'
    },
    {
      id: 'create-project-directory',
      title: 'Create Project Directory',
      type: 'command',
      content: 'mkdir wordpress-app && cd wordpress-app'
    },
    {
      id: 'create-compose-file',
      title: 'Create Docker Compose File',
      type: 'code',
      language: 'yaml',
      content: `# Create docker-compose.yml
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  # WordPress web application
  wordpress:
    image: wordpress:latest
    ports:
      - "8080:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: secure_password
      WORDPRESS_DB_NAME: wordpress_db
    volumes:
      - wordpress_data:/var/www/html
    depends_on:
      - db
    restart: unless-stopped

  # MySQL database
  db:
    image: mysql:8.0
    environment:
      MYSQL_DATABASE: wordpress_db
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: secure_password
      MYSQL_ROOT_PASSWORD: root_password
    volumes:
      - db_data:/var/lib/mysql
    restart: unless-stopped

# Named volumes for persistent data
volumes:
  wordpress_data:
  db_data:
EOF`
    },
    {
      id: 'compose-explanation',
      title: 'Understanding the Compose File',
      type: 'info',
      content: `
<div class="space-y-3">
  <p>Let's break down the docker-compose.yml structure:</p>
  <ul class="list-disc list-inside space-y-2">
    <li><strong>version:</strong> Compose file format version (3.8 is recommended)</li>
    <li><strong>services:</strong> Defines the containers in your application</li>
    <li><strong>image:</strong> Specifies which Docker image to use</li>
    <li><strong>ports:</strong> Maps host ports to container ports</li>
    <li><strong>environment:</strong> Sets environment variables</li>
    <li><strong>volumes:</strong> Mounts volumes for persistent data</li>
    <li><strong>depends_on:</strong> Controls service startup order</li>
    <li><strong>restart:</strong> Restart policy for containers</li>
  </ul>
</div>
      `
    },
    {
      id: 'start-application',
      title: 'Start the Application',
      type: 'command',
      content: 'docker-compose up -d'
    },
    {
      id: 'startup-explanation',
      title: 'Understanding Compose Startup',
      type: 'text',
      content: `
The \`docker-compose up -d\` command:
- \`up\` starts all services defined in the file
- \`-d\` runs in detached mode (background)

Watch the output - Compose will:
1. Create a dedicated network for the application
2. Create named volumes
3. Pull required images (if not available locally)
4. Start containers in dependency order (db first, then wordpress)
5. Apply all configuration from the YAML file

This replaces what would have been multiple \`docker run\` commands!
      `
    },
    {
      id: 'check-services',
      title: 'Check Running Services',
      type: 'command',
      content: 'docker-compose ps'
    },
    {
      id: 'test-application',
      title: 'Test the WordPress Application',
      type: 'text',
      content: `
Your WordPress application is now running! Open your browser and navigate to:

**http://localhost:8080**

You should see the WordPress installation page. This demonstrates a complete multi-container application:
- **Frontend**: WordPress container handling web requests
- **Backend**: MySQL container managing database
- **Communication**: Containers can communicate using service names
- **Data**: Both services have persistent data via volumes

Go ahead and complete the WordPress setup to see it working!
      `
    },
    {
      id: 'view-logs',
      title: 'View Application Logs',
      type: 'command',
      content: 'docker-compose logs'
    },
    {
      id: 'view-specific-logs',
      title: 'View Logs for Specific Service',
      type: 'command',
      content: 'docker-compose logs wordpress'
    },
    {
      id: 'logs-explanation',
      title: 'Understanding Compose Logs',
      type: 'text',
      content: `
Docker Compose aggregates logs from all services, making debugging easier:
- \`docker-compose logs\` shows logs from all services
- \`docker-compose logs service-name\` shows logs from one service
- \`docker-compose logs -f\` follows logs in real-time
- Logs are color-coded by service for easy identification

This is much more convenient than checking individual container logs!
      `
    },
    {
      id: 'scale-service',
      title: 'Scale a Service',
      type: 'command',
      content: 'docker-compose up -d --scale wordpress=2'
    },
    {
      id: 'scaling-warning',
      title: 'Port Conflict Resolution',
      type: 'warning',
      content: `
<p><strong>Note:</strong> The scaling command above will fail because both WordPress containers try to use port 8080. In production, you'd use a load balancer. For now, let's scale back to 1 instance.</p>
      `
    },
    {
      id: 'scale-back',
      title: 'Scale Back to Single Instance',
      type: 'command',
      content: 'docker-compose up -d --scale wordpress=1'
    },
    {
      id: 'exec-into-service',
      title: 'Execute Commands in Services',
      type: 'command',
      content: 'docker-compose exec wordpress bash'
    },
    {
      id: 'exec-commands',
      title: 'Test Service Communication',
      type: 'code',
      language: 'bash',
      content: `# Inside the WordPress container, test database connection:
mysql -h db -u wordpress -psecure_password wordpress_db -e "SHOW TABLES;"

# Check if we can resolve the database service name:
nslookup db

# Exit the container:
exit`
    },
    {
      id: 'networking-explanation',
      title: 'Compose Networking Magic',
      type: 'info',
      content: `
<div class="space-y-3">
  <p>Docker Compose automatically creates:</p>
  <ul class="list-disc list-inside space-y-1">
    <li><strong>Dedicated network:</strong> All services can communicate</li>
    <li><strong>Service discovery:</strong> Services can reach each other by name</li>
    <li><strong>DNS resolution:</strong> "db" resolves to the database container's IP</li>
    <li><strong>Isolation:</strong> Your app is isolated from other Docker applications</li>
  </ul>
  <p>This is why WordPress can connect to MySQL using "db:3306" as the host!</p>
</div>
      `
    },
    {
      id: 'environment-override',
      title: 'Environment-Specific Configuration',
      type: 'code',
      language: 'bash',
      content: `# Create a development override file
cat > docker-compose.override.yml << 'EOF'
version: '3.8'

services:
  wordpress:
    environment:
      WORDPRESS_DEBUG: 1
    volumes:
      - ./wp-content:/var/www/html/wp-content

  db:
    ports:
      - "3306:3306"  # Expose database port for debugging
EOF`
    },
    {
      id: 'override-explanation',
      title: 'Configuration Overrides',
      type: 'text',
      content: `
Docker Compose automatically reads \`docker-compose.override.yml\` if it exists. This allows you to:
- Add development-specific settings
- Override production configurations
- Expose additional ports for debugging
- Mount source code for live editing

The override file extends the base configuration without modifying it.
      `
    },
    {
      id: 'essential-commands',
      title: 'Essential Compose Commands',
      type: 'code',
      language: 'bash',
      content: `# Start services in background
docker-compose up -d

# View running services
docker-compose ps

# View logs (all services)
docker-compose logs

# Follow logs in real-time
docker-compose logs -f

# Stop services (containers remain)
docker-compose stop

# Start stopped services
docker-compose start

# Restart services
docker-compose restart

# Stop and remove containers, networks
docker-compose down

# Stop and remove everything including volumes
docker-compose down -v

# Execute command in running service
docker-compose exec service-name command

# Run one-off command in new container
docker-compose run service-name command`
    },
    {
      id: 'stop-application',
      title: 'Stop the Application',
      type: 'command',
      content: 'docker-compose stop'
    },
    {
      id: 'clean-shutdown',
      title: 'Clean Shutdown',
      type: 'command',
      content: 'docker-compose down'
    },
    {
      id: 'down-explanation',
      title: 'Stop vs Down',
      type: 'text',
      content: `
**Important difference:**
- \`docker-compose stop\` - Stops containers but keeps them and networks
- \`docker-compose down\` - Stops and removes containers and networks
- \`docker-compose down -v\` - Also removes volumes (deletes all data!)

The \`down\` command is like a complete cleanup, while \`stop\` just pauses everything.
      `
    },
    {
      id: 'compose-best-practices',
      title: 'Compose Best Practices',
      type: 'info',
      content: `
<div class="space-y-3">
  <p><strong>Best practices for Docker Compose:</strong></p>
  <ul class="list-disc list-inside space-y-1">
    <li><strong>Use specific image tags</strong> instead of 'latest' for predictability</li>
    <li><strong>Set restart policies</strong> for production services</li>
    <li><strong>Use environment files</strong> (.env) for secrets and config</li>
    <li><strong>Name your volumes</strong> for easier management</li>
    <li><strong>Use health checks</strong> for critical services</li>
    <li><strong>Keep compose files in version control</strong> with your code</li>
    <li><strong>Use override files</strong> for environment-specific settings</li>
  </ul>
</div>
      `
    },
    {
      id: 'production-considerations',
      title: 'Production Considerations',
      type: 'warning',
      content: `
<p><strong>Important:</strong> While Compose is great for development and simple deployments, consider using Docker Swarm, Kubernetes, or other orchestration tools for production environments that require high availability, scaling, and advanced networking.</p>
      `
    },
    {
      id: 'completion',
      title: 'Docker Compose Mastery!',
      type: 'text',
      content: `
Outstanding! You've mastered Docker Compose fundamentals:
- ✅ Understanding multi-container application architecture
- ✅ Writing docker-compose.yml files with proper syntax
- ✅ Managing services, networks, and volumes declaratively
- ✅ Using essential Compose commands for daily workflows
- ✅ Understanding service communication and networking
- ✅ Managing different environments with override files
- ✅ Following best practices for maintainable applications

**You've completed the Docker Beginner track!** You now have the foundation to build and deploy containerized applications. Consider exploring intermediate topics like Docker Swarm, container security, and production deployment strategies.
      `
    }
  ],
  nextLab: 'docker-networking-basics',
  previousLab: 'docker-volumes-basics'
};
