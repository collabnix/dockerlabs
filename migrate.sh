#!/bin/bash

# Script to create all migrated Docker lab files
# Run this after setting up the repository structure

echo "🚀 Creating migrated Docker lab files..."

# Create the lab type definition
cat > src/types/lab.ts << 'EOF'
export interface Lab {
  id: string;
  title: string;
  description: string;
  category: 'beginners' | 'intermediate' | 'advanced' | 'networking' | 'security' | 'cloud';
  difficulty: 1 | 2 | 3 | 4 | 5;
  duration: string;
  prerequisites: string[];
  tags: string[];
  author: string;
  lastUpdated: string;
  featured: boolean;
  sections: LabSection[];
  nextLab?: string;
  previousLab?: string;
}

export interface LabSection {
  id: string;
  title: string;
  type: 'text' | 'code' | 'command' | 'warning' | 'info' | 'image';
  content: string;
  language?: string;
  imageUrl?: string;
}
EOF

# Create Lab 1: Hello World
cat > src/labs/beginners/hello-world.ts << 'EOF'
import { Lab } from '@/types/lab';

export const helloWorldLab: Lab = {
  id: 'docker-hello-world',
  title: 'Docker Hello World: Your First Container',
  description: 'Learn Docker fundamentals by running your very first container. Understand the Docker workflow and basic commands through the classic hello-world example.',
  category: 'beginners',
  difficulty: 1,
  duration: '5-10 minutes',
  prerequisites: [
    'Docker installed on your system',
    'Access to command line/terminal'
  ],
  tags: [
    'docker',
    'hello-world',
    'containers',
    'beginner',
    'first-steps',
    'docker-run'
  ],
  author: 'Docker Community',
  lastUpdated: '2024-06-30',
  featured: true,
  sections: [
    {
      id: 'introduction',
      title: 'Introduction to Docker Containers',
      type: 'text',
      content: `
Welcome to your first Docker lab! In this tutorial, you'll run your very first Docker container using the famous "hello-world" image.

**What you'll learn:**
- How to run your first Docker container
- Understanding the Docker workflow
- Basic Docker commands
- How Docker pulls images from Docker Hub
- Container lifecycle basics

The hello-world image is a minimal Docker image designed to demonstrate that Docker is working correctly on your system.
      `
    },
    {
      id: 'run-hello-world',
      title: 'Run Your First Container',
      type: 'command',
      content: 'docker run hello-world'
    },
    {
      id: 'understanding-output',
      title: 'Understanding the Output',
      type: 'text',
      content: `
When you ran the command above, you should see output similar to this:

\`\`\`
Unable to find image 'hello-world:latest' locally
latest: Pulling from library/hello-world
b8dfde127a29: Pull complete
Digest: sha256:5122f6204b6a3596e048758cabba3c46b1c937a46b5be6225b835d091b90e46c
Status: Downloaded newer image for hello-world:latest

Hello from Docker!
This message shows that your installation appears to be working correctly.
\`\`\`

**What happened step by step:**
1. Docker client contacted the Docker daemon
2. Daemon looked for the image locally (didn't find it)
3. Daemon pulled the image from Docker Hub
4. Daemon created a new container from the image
5. Container executed and produced the output
6. Container exited after completing its task
      `
    },
    {
      id: 'docker-workflow-info',
      title: 'The Docker Workflow',
      type: 'info',
      content: `
<div class="space-y-3">
  <p>Understanding what happened when you ran <code>docker run hello-world</code>:</p>
  <ul class="list-disc list-inside space-y-1">
    <li><strong>Image Pull:</strong> Docker automatically downloaded the hello-world image from Docker Hub</li>
    <li><strong>Container Creation:</strong> A new container was created from the image</li>
    <li><strong>Execution:</strong> The container ran its program (printing the message)</li>
    <li><strong>Exit:</strong> The container stopped after completing its task</li>
  </ul>
</div>
      `
    },
    {
      id: 'list-containers',
      title: 'View Your Container',
      type: 'command',
      content: 'docker ps -a'
    },
    {
      id: 'explain-docker-ps',
      title: 'Understanding Container States',
      type: 'text',
      content: `
The \`docker ps -a\` command shows all containers (running and stopped). You'll see something like:

\`\`\`
CONTAINER ID   IMAGE         COMMAND    CREATED          STATUS                      PORTS   NAMES
c0ba7d45168a   hello-world   "/hello"   2 minutes ago    Exited (0) 2 minutes ago           thirsty_poitras
\`\`\`

**Key information:**
- **CONTAINER ID**: Unique identifier for the container
- **IMAGE**: The image used to create this container
- **STATUS**: Shows "Exited (0)" meaning it completed successfully
- **NAMES**: Docker assigned a random name (you can specify custom names)
      `
    },
    {
      id: 'list-images',
      title: 'View Downloaded Images',
      type: 'command',
      content: 'docker images'
    },
    {
      id: 'explain-docker-images',
      title: 'Understanding Docker Images',
      type: 'text',
      content: `
The \`docker images\` command lists all images stored locally. You'll see the hello-world image:

\`\`\`
REPOSITORY    TAG       IMAGE ID       CREATED       SIZE
hello-world   latest    9c7a54a9a43c   3 months ago  13.3kB
\`\`\`

**Key concepts:**
- **REPOSITORY**: The image name
- **TAG**: Version identifier (latest is the default)
- **SIZE**: The hello-world image is incredibly small at just 13.3kB!
      `
    },
    {
      id: 'try-interactive',
      title: 'Try an Interactive Container',
      type: 'command',
      content: 'docker run -it ubuntu bash'
    },
    {
      id: 'interactive-explanation',
      title: 'Interactive Containers',
      type: 'text',
      content: `
The command above starts an Ubuntu container interactively:
- \`-i\` flag keeps STDIN open (interactive)
- \`-t\` flag allocates a pseudo-TTY (terminal)
- \`bash\` is the command to run inside the container

You'll be inside the Ubuntu container's shell. Try some commands:
- \`ls\` to list files
- \`cat /etc/os-release\` to see OS info
- \`exit\` to leave the container

This demonstrates that containers provide isolated environments with their own filesystem.
      `
    },
    {
      id: 'cleanup-warning',
      title: 'Container Cleanup',
      type: 'warning',
      content: `
<p><strong>Note:</strong> Each time you run <code>docker run</code>, it creates a new container. Over time, you may accumulate many stopped containers. Use <code>docker container prune</code> to clean up stopped containers when needed.</p>
      `
    },
    {
      id: 'next-steps',
      title: 'What\'s Next?',
      type: 'text',
      content: `
Congratulations! You've successfully:
- ✅ Run your first Docker container
- ✅ Understood the Docker workflow
- ✅ Learned basic Docker commands
- ✅ Explored container and image concepts

**Ready for more?** In the next lab, you'll learn about:
- Building your own Docker images
- Working with Dockerfiles
- Managing container data
      `
    }
  ],
  nextLab: 'docker-images-basics',
  previousLab: null
};
EOF

# Create Lab 2: Docker Images
cat > src/labs/beginners/docker-images.ts << 'EOF'
import { Lab } from '@/types/lab';

export const dockerImagesLab: Lab = {
  id: 'docker-images-basics',
  title: 'Working with Docker Images',
  description: 'Learn how to search, pull, inspect, and manage Docker images. Understand the difference between images and containers, and explore Docker Hub.',
  category: 'beginners',
  difficulty: 2,
  duration: '15-20 minutes',
  prerequisites: [
    'Docker installed on your system',
    'Completed "Docker Hello World" lab',
    'Basic command line knowledge'
  ],
  tags: [
    'docker',
    'images',
    'docker-hub',
    'pull',
    'search',
    'inspect',
    'beginner'
  ],
  author: 'Docker Community',
  lastUpdated: '2024-06-30',
  featured: false,
  sections: [
    {
      id: 'introduction',
      title: 'Understanding Docker Images',
      type: 'text',
      content: `
Docker images are the foundation of containers. Think of an image as a read-only template that contains:
- Application code
- Runtime environment
- System tools and libraries
- Settings and configurations

**Key concepts:**
- **Images** are templates used to create containers
- **Containers** are running instances of images
- **Docker Hub** is the default public registry for images
- Images are built in layers for efficiency

In this lab, you'll learn how to find, download, and inspect Docker images.
      `
    },
    {
      id: 'search-images',
      title: 'Search for Images on Docker Hub',
      type: 'command',
      content: 'docker search nginx'
    },
    {
      id: 'search-explanation',
      title: 'Understanding Search Results',
      type: 'text',
      content: `
The search command shows available images on Docker Hub. You'll see output like:

\`\`\`
NAME                DESCRIPTION                     STARS     OFFICIAL   AUTOMATED
nginx               Official build of Nginx.       15000     [OK]       
nginx/nginx-...     NGINX Plus and NGINX based...  75        
nginxinc/nginx-...  NGINX Unprivileged              20        
\`\`\`

**Key columns:**
- **NAME**: Repository name (official images have simple names)
- **DESCRIPTION**: Brief description of the image
- **STARS**: Community rating (like GitHub stars)
- **OFFICIAL**: Maintained by Docker or the original software vendor
- **AUTOMATED**: Automatically built from source code
      `
    },
    {
      id: 'pull-image',
      title: 'Pull an Image',
      type: 'command',
      content: 'docker pull nginx:alpine'
    },
    {
      id: 'pull-explanation',
      title: 'Understanding Image Tags',
      type: 'text',
      content: `
The \`docker pull\` command downloads an image to your local system. Notice we used \`nginx:alpine\`:

- **nginx** is the image name
- **alpine** is the tag (version)
- If no tag is specified, Docker uses \`:latest\` by default

**Common tag patterns:**
- \`latest\` - Most recent stable version
- \`alpine\` - Smaller version based on Alpine Linux
- \`1.21\` - Specific version number
- \`1.21-alpine\` - Specific version with Alpine base
      `
    },
    {
      id: 'list-local-images',
      title: 'List Local Images',
      type: 'command',
      content: 'docker images'
    },
    {
      id: 'inspect-image',
      title: 'Inspect an Image',
      type: 'command',
      content: 'docker inspect nginx:alpine'
    },
    {
      id: 'inspect-explanation',
      title: 'Understanding Image Details',
      type: 'text',
      content: `
The \`docker inspect\` command provides detailed information about an image including:
- Configuration settings
- Environment variables
- Exposed ports
- Volume mount points
- Layer information
- Creation date and size

This metadata helps you understand how to properly run containers from the image.
      `
    },
    {
      id: 'image-history',
      title: 'View Image Layers',
      type: 'command',
      content: 'docker history nginx:alpine'
    },
    {
      id: 'layers-explanation',
      title: 'Understanding Image Layers',
      type: 'info',
      content: `
<div class="space-y-3">
  <p>Docker images are built in layers for efficiency:</p>
  <ul class="list-disc list-inside space-y-1">
    <li><strong>Base Layer:</strong> Usually an OS like Alpine or Ubuntu</li>
    <li><strong>Application Layers:</strong> Your app code and dependencies</li>
    <li><strong>Configuration Layers:</strong> Settings and metadata</li>
    <li><strong>Shared Layers:</strong> Common layers are reused between images</li>
  </ul>
  <p>This layered approach saves disk space and speeds up image downloads!</p>
</div>
      `
    },
    {
      id: 'run-nginx',
      title: 'Run a Container from the Image',
      type: 'command',
      content: 'docker run -d -p 8080:80 --name my-nginx nginx:alpine'
    },
    {
      id: 'run-explanation',
      title: 'Understanding the Run Command',
      type: 'text',
      content: `
Let's break down the command flags:
- \`-d\` runs the container in detached mode (background)
- \`-p 8080:80\` maps port 8080 on your host to port 80 in the container
- \`--name my-nginx\` gives the container a friendly name
- \`nginx:alpine\` is the image to use

The nginx web server is now running! You can visit http://localhost:8080 to see it.
      `
    },
    {
      id: 'check-running',
      title: 'Check Running Containers',
      type: 'command',
      content: 'docker ps'
    },
    {
      id: 'stop-container',
      title: 'Stop the Container',
      type: 'command',
      content: 'docker stop my-nginx'
    },
    {
      id: 'remove-container',
      title: 'Remove the Container',
      type: 'command',
      content: 'docker rm my-nginx'
    },
    {
      id: 'official-images-info',
      title: 'Official vs Community Images',
      type: 'info',
      content: `
<div class="space-y-3">
  <p><strong>Official Images:</strong></p>
  <ul class="list-disc list-inside space-y-1">
    <li>Maintained by Docker or the software vendor</li>
    <li>Regularly updated and security-patched</li>
    <li>Simple names like <code>nginx</code>, <code>mysql</code>, <code>python</code></li>
    <li>Best choice for production use</li>
  </ul>
  <p><strong>Community Images:</strong></p>
  <ul class="list-disc list-inside space-y-1">
    <li>Created by community members</li>
    <li>Format: <code>username/imagename</code></li>
    <li>May include specialized configurations</li>
    <li>Always verify trustworthiness before use</li>
  </ul>
</div>
      `
    },
    {
      id: 'image-cleanup',
      title: 'Clean Up Images',
      type: 'command',
      content: 'docker image prune'
    },
    {
      id: 'cleanup-warning',
      title: 'Image Management Best Practices',
      type: 'warning',
      content: `
<p><strong>Important:</strong> Images can consume significant disk space. Use <code>docker system df</code> to see space usage and <code>docker image prune</code> to remove unused images. Be careful not to remove images you still need!</p>
      `
    },
    {
      id: 'next-steps',
      title: 'What You\'ve Learned',
      type: 'text',
      content: `
Excellent work! You now understand:
- ✅ How to search for images on Docker Hub
- ✅ How to pull images with specific tags
- ✅ How to inspect image details and layers
- ✅ The difference between official and community images
- ✅ How to run containers from images
- ✅ Basic image management and cleanup

**Coming up next:** Learn how to create your own custom Docker images using Dockerfiles!
      `
    }
  ],
  nextLab: 'dockerfile-basics',
  previousLab: 'docker-hello-world'
};
EOF

# Create Lab 3: Dockerfile Basics
cat > src/labs/beginners/dockerfile-basics.ts << 'EOF'
import { Lab } from '@/types/lab';

export const dockerfileBasicsLab: Lab = {
  id: 'dockerfile-basics',
  title: 'Dockerfile Basics: Building Your First Image',
  description: 'Learn how to create Dockerfiles and build custom Docker images. Understand essential Dockerfile instructions and best practices for creating efficient images.',
  category: 'beginners',
  difficulty: 3,
  duration: '25-30 minutes',
  prerequisites: [
    'Docker installed on your system',
    'Completed "Working with Docker Images" lab',
    'Basic understanding of containers and images',
    'Text editor knowledge'
  ],
  tags: [
    'dockerfile',
    'docker-build',
    'custom-images',
    'FROM',
    'RUN',
    'COPY',
    'CMD',
    'EXPOSE',
    'beginner'
  ],
  author: 'Docker Community',
  lastUpdated: '2024-06-30',
  featured: false,
  sections: [
    {
      id: 'introduction',
      title: 'What is a Dockerfile?',
      type: 'text',
      content: `
A **Dockerfile** is a text file containing a series of instructions that Docker uses to automatically build images. Think of it as a recipe for creating your custom Docker image.

**Key benefits:**
- **Reproducible**: Same Dockerfile always builds the same image
- **Version controlled**: Store Dockerfiles in Git alongside your code
- **Automated**: No manual steps required to build images
- **Portable**: Works the same way on any Docker-enabled system

**Common Dockerfile instructions:**
- \`FROM\` - Specifies the base image
- \`RUN\` - Executes commands during build
- \`COPY\` - Copies files from host to image
- \`CMD\` - Specifies the default command to run
- \`EXPOSE\` - Documents which ports the app uses
      `
    },
    {
      id: 'create-project',
      title: 'Create a Project Directory',
      type: 'command',
      content: 'mkdir my-first-dockerfile && cd my-first-dockerfile'
    },
    {
      id: 'create-html-file',
      title: 'Create a Simple HTML File',
      type: 'code',
      language: 'bash',
      content: `cat > index.html << 'EOF'
<!DOCTYPE html>
<html>
<head>
    <title>My First Docker App</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 50px; }
        .container { text-align: center; padding: 50px; background: #f0f0f0; }
        h1 { color: #333; }
    </style>
</head>
<body>
    <div class="container">
        <h1>🐳 Hello from Docker!</h1>
        <p>This HTML file is served from a custom Docker container.</p>
        <p>Built with: <strong>Dockerfile</strong></p>
    </div>
</body>
</html>
EOF`
    },
    {
      id: 'create-dockerfile',
      title: 'Create Your First Dockerfile',
      type: 'code',
      language: 'dockerfile',
      content: `# Create the Dockerfile
cat > Dockerfile << 'EOF'
# Use nginx:alpine as the base image
FROM nginx:alpine

# Set metadata
LABEL maintainer="your-email@example.com"
LABEL description="My first custom Docker image"

# Copy our HTML file to nginx's web directory
COPY index.html /usr/share/nginx/html/

# Expose port 80 (standard HTTP port)
EXPOSE 80

# The default CMD is inherited from nginx:alpine
# It starts the nginx web server
EOF`
    },
    {
      id: 'dockerfile-explanation',
      title: 'Understanding the Dockerfile',
      type: 'info',
      content: `
<div class="space-y-3">
  <p>Let's break down each instruction:</p>
  <ul class="list-disc list-inside space-y-2">
    <li><strong>FROM nginx:alpine</strong> - Starts with the official nginx image based on Alpine Linux</li>
    <li><strong>LABEL</strong> - Adds metadata to the image (like version info or maintainer)</li>
    <li><strong>COPY index.html /usr/share/nginx/html/</strong> - Copies our HTML file into the nginx web directory</li>
    <li><strong>EXPOSE 80</strong> - Documents that this container listens on port 80</li>
    <li><strong>CMD</strong> - Not needed here since nginx:alpine already has a CMD to start the web server</li>
  </ul>
</div>
      `
    },
    {
      id: 'build-image',
      title: 'Build Your Custom Image',
      type: 'command',
      content: 'docker build -t my-web-app:v1.0 .'
    },
    {
      id: 'build-explanation',
      title: 'Understanding the Build Process',
      type: 'text',
      content: `
The \`docker build\` command creates an image from your Dockerfile:
- \`-t my-web-app:v1.0\` tags the image with a name and version
- \`.\` tells Docker to look for the Dockerfile in the current directory

Watch the build output - you'll see Docker:
1. Download the base image (if not already present)
2. Execute each instruction in order
3. Create a new layer for each instruction
4. Tag the final image

Each step is cached, so subsequent builds are faster!
      `
    },
    {
      id: 'verify-image',
      title: 'Verify Your Image was Built',
      type: 'command',
      content: 'docker images my-web-app'
    },
    {
      id: 'run-custom-container',
      title: 'Run Your Custom Container',
      type: 'command',
      content: 'docker run -d -p 8080:80 --name my-app my-web-app:v1.0'
    },
    {
      id: 'test-app',
      title: 'Test Your Application',
      type: 'text',
      content: `
Your custom web application is now running! Open your browser and navigate to:

**http://localhost:8080**

You should see your custom HTML page served from the Docker container. This demonstrates how you've successfully:
1. Created a custom Dockerfile
2. Built a custom image
3. Run a container from your image
4. Served custom content

Try refreshing the page or opening it in multiple browser tabs to see it working!
      `
    },
    {
      id: 'dockerfile-best-practices',
      title: 'Dockerfile Best Practices',
      type: 'info',
      content: `
<div class="space-y-3">
  <p><strong>Key best practices for writing Dockerfiles:</strong></p>
  <ul class="list-disc list-inside space-y-1">
    <li><strong>Use official base images</strong> when possible (more secure and maintained)</li>
    <li><strong>Keep images small</strong> - use Alpine variants for smaller size</li>
    <li><strong>Minimize layers</strong> - combine RUN commands with && when logical</li>
    <li><strong>Use .dockerignore</strong> to exclude unnecessary files</li>
    <li><strong>Don't run as root</strong> - create and use a non-root user</li>
    <li><strong>Use specific tags</strong> - avoid 'latest' in production</li>
  </ul>
</div>
      `
    },
    {
      id: 'more-dockerfile-instructions',
      title: 'Common Dockerfile Instructions',
      type: 'code',
      language: 'dockerfile',
      content: `# Example showing more Dockerfile instructions
FROM node:18-alpine

# Set working directory
WORKDIR /app

# Install dependencies first (for better caching)
COPY package*.json ./
RUN npm install --only=production

# Copy application code
COPY . .

# Create non-root user
RUN addgroup -g 1001 -S nodejs && \\
    adduser -S nextjs -u 1001

# Change ownership and switch to non-root user
RUN chown -R nextjs:nodejs /app
USER nextjs

# Expose port
EXPOSE 3000

# Define environment variable
ENV NODE_ENV=production

# Start the application
CMD ["npm", "start"]`
    },
    {
      id: 'advanced-instructions',
      title: 'Understanding Advanced Instructions',
      type: 'text',
      content: `
**Additional Dockerfile instructions you'll encounter:**

- **WORKDIR** - Sets the working directory for subsequent instructions
- **ENV** - Sets environment variables
- **ARG** - Defines build-time variables
- **USER** - Specifies which user to run as (security best practice)
- **VOLUME** - Declares mount points for persistent data
- **ENTRYPOINT** - Configures container to run as an executable
- **HEALTHCHECK** - Tells Docker how to test if the container is healthy

Each serves a specific purpose in creating robust, secure, and maintainable images.
      `
    },
    {
      id: 'cleanup-containers',
      title: 'Clean Up',
      type: 'command',
      content: 'docker stop my-app && docker rm my-app'
    },
    {
      id: 'security-warning',
      title: 'Security Considerations',
      type: 'warning',
      content: `
<p><strong>Security Best Practice:</strong> Always avoid including sensitive information like passwords, API keys, or certificates directly in Dockerfiles. Use environment variables, Docker secrets, or external configuration management instead.</p>
      `
    },
    {
      id: 'next-steps',
      title: 'Congratulations!',
      type: 'text',
      content: `
You've successfully learned Dockerfile fundamentals! You can now:
- ✅ Write basic Dockerfiles with essential instructions
- ✅ Build custom Docker images from source code
- ✅ Understand the layered architecture of images
- ✅ Apply basic security and efficiency best practices
- ✅ Run containers from your custom images

**Next up:** Learn about Docker volumes for persistent data and advanced container networking!
      `
    }
  ],
  nextLab: 'docker-volumes-basics',
  previousLab: 'docker-images-basics'
};
EOF

# Create Lab 4: Docker Volumes
cat > src/labs/beginners/docker-volumes.ts << 'EOF'
import { Lab } from '@/types/lab';

export const dockerVolumesLab: Lab = {
  id: 'docker-volumes-basics',
  title: 'Docker Volumes: Managing Persistent Data',
  description: 'Learn how to use Docker volumes to persist data, share files between containers and host, and manage container storage effectively.',
  category: 'beginners',
  difficulty: 3,
  duration: '20-25 minutes',
  prerequisites: [
    'Docker installed on your system',
    'Completed "Dockerfile Basics" lab',
    'Understanding of containers and images',
    'Basic file system knowledge'
  ],
  tags: [
    'docker',
    'volumes',
    'persistent-data',
    'bind-mounts',
    'storage',
    'data-management',
    'beginner'
  ],
  author: 'Docker Community',
  lastUpdated: '2024-06-30',
  featured: false,
  sections: [
    {
      id: 'introduction',
      title: 'Understanding Docker Storage',
      type: 'text',
      content: `
By default, data created inside a Docker container is lost when the container is removed. This is where **Docker volumes** come to the rescue!

**Storage types in Docker:**
- **Container layer**: Temporary, lost when container is removed
- **Bind mounts**: Direct access to host filesystem
- **Volumes**: Docker-managed storage (recommended)
- **tmpfs mounts**: In-memory storage (temporary)

**Why use volumes?**
- Persist data beyond container lifecycle
- Share data between containers
- Back up and migrate data easily
- Better performance than bind mounts on Windows/Mac
      `
    },
    {
      id: 'problem-demo',
      title: 'Demonstrate the Problem',
      type: 'command',
      content: 'docker run --rm -it alpine sh -c "echo Hello > /tmp/test.txt && cat /tmp/test.txt"'
    },
    {
      id: 'problem-explanation',
      title: 'The Data Loss Problem',
      type: 'text',
      content: `
The command above created a file inside the container, displayed it, then the container was removed (--rm flag). 

Let's verify the data is gone by trying to access it again:
      `
    },
    {
      id: 'verify-data-loss',
      title: 'Verify Data is Lost',
      type: 'command',
      content: 'docker run --rm -it alpine sh -c "cat /tmp/test.txt || echo File not found"'
    },
    {
      id: 'create-volume',
      title: 'Create a Named Volume',
      type: 'command',
      content: 'docker volume create my-data-volume'
    },
    {
      id: 'list-volumes',
      title: 'List Docker Volumes',
      type: 'command',
      content: 'docker volume ls'
    },
    {
      id: 'inspect-volume',
      title: 'Inspect Volume Details',
      type: 'command',
      content: 'docker volume inspect my-data-volume'
    },
    {
      id: 'volume-info',
      title: 'Understanding Volume Details',
      type: 'info',
      content: `
<div class="space-y-3">
  <p>The <code>docker volume inspect</code> command shows important information:</p>
  <ul class="list-disc list-inside space-y-1">
    <li><strong>Mountpoint:</strong> Where Docker stores the volume data on the host</li>
    <li><strong>Driver:</strong> Storage driver used (usually 'local')</li>
    <li><strong>Labels:</strong> Metadata attached to the volume</li>
    <li><strong>Options:</strong> Additional configuration options</li>
  </ul>
  <p><em>Note: Don't directly access the mountpoint - always use Docker commands!</em></p>
</div>
      `
    },
    {
      id: 'use-volume',
      title: 'Use Volume with Container',
      type: 'command',
      content: 'docker run -it --rm -v my-data-volume:/data alpine sh'
    },
    {
      id: 'volume-demo-commands',
      title: 'Test Persistent Storage',
      type: 'code',
      language: 'bash',
      content: `# Inside the container, run these commands:
echo "This data will persist!" > /data/persistent.txt
echo "Container ID: $(hostname)" >> /data/persistent.txt
date >> /data/persistent.txt
ls -la /data/
cat /data/persistent.txt
exit`
    },
    {
      id: 'verify-persistence',
      title: 'Verify Data Persisted',
      type: 'command',
      content: 'docker run --rm -v my-data-volume:/data alpine cat /data/persistent.txt'
    },
    {
      id: 'persistence-success',
      title: 'Success! Data Persisted',
      type: 'text',
      content: `
Amazing! The data survived even though we created a completely new container. This demonstrates the power of Docker volumes for persistent storage.

The file we created in the first container is accessible in the second container because both containers mounted the same volume at \`/data\`.
      `
    },
    {
      id: 'bind-mount-demo',
      title: 'Bind Mount Example',
      type: 'command',
      content: 'mkdir -p ~/docker-demo && echo "Host file content" > ~/docker-demo/host-file.txt'
    },
    {
      id: 'run-with-bind-mount',
      title: 'Run Container with Bind Mount',
      type: 'command',
      content: 'docker run --rm -v ~/docker-demo:/host-data alpine ls -la /host-data'
    },
    {
      id: 'bind-vs-volume',
      title: 'Bind Mounts vs Volumes',
      type: 'info',
      content: `
<div class="space-y-3">
  <p><strong>Bind Mounts:</strong></p>
  <ul class="list-disc list-inside space-y-1">
    <li>Mount a specific host path into container</li>
    <li>Syntax: <code>-v /host/path:/container/path</code></li>
    <li>Good for development (editing files with host tools)</li>
    <li>Host-dependent (path must exist on host)</li>
  </ul>
  <p><strong>Named Volumes:</strong></p>
  <ul class="list-disc list-inside space-y-1">
    <li>Docker manages the storage location</li>
    <li>Syntax: <code>-v volume-name:/container/path</code></li>
    <li>Good for production (portable, managed by Docker)</li>
    <li>Better performance on Windows/Mac</li>
  </ul>
</div>
      `
    },
    {
      id: 'practical-example',
      title: 'Practical Example: Web Server with Persistent Content',
      type: 'command',
      content: 'docker run -d -p 8080:80 -v my-data-volume:/usr/share/nginx/html --name web-server nginx:alpine'
    },
    {
      id: 'add-content',
      title: 'Add Content to Volume',
      type: 'command',
      content: 'docker run --rm -v my-data-volume:/data alpine sh -c "echo \'<h1>Hello from Volume!</h1><p>This content is stored in a Docker volume.</p>\' > /data/index.html"'
    },
    {
      id: 'test-web-server',
      title: 'Test the Web Server',
      type: 'text',
      content: `
Visit **http://localhost:8080** in your browser. You should see the HTML content we just created!

This demonstrates how volumes can be used to:
- Provide content to web servers
- Share data between containers
- Persist important application data
      `
    },
    {
      id: 'sharing-volumes',
      title: 'Share Volume Between Containers',
      type: 'command',
      content: 'docker run --rm -v my-data-volume:/shared alpine sh -c "echo Additional content >> /shared/index.html"'
    },
    {
      id: 'volume-backup',
      title: 'Backup Volume Data',
      type: 'command',
      content: 'docker run --rm -v my-data-volume:/backup-source -v $(pwd):/backup-dest alpine tar czf /backup-dest/my-volume-backup.tar.gz -C /backup-source .'
    },
    {
      id: 'backup-explanation',
      title: 'Understanding Volume Backup',
      type: 'text',
      content: `
The backup command above:
1. Mounts the volume as \`/backup-source\`
2. Mounts current directory as \`/backup-dest\`
3. Creates a compressed archive of the volume content
4. Saves it to your host filesystem

This is a common pattern for backing up Docker volume data. You can restore by reversing the process!
      `
    },
    {
      id: 'cleanup-containers',
      title: 'Clean Up Containers',
      type: 'command',
      content: 'docker stop web-server && docker rm web-server'
    },
    {
      id: 'volume-commands',
      title: 'Essential Volume Commands',
      type: 'code',
      language: 'bash',
      content: `# List all volumes
docker volume ls

# Create a volume
docker volume create volume-name

# Inspect volume details
docker volume inspect volume-name

# Remove a volume (only if not in use)
docker volume rm volume-name

# Remove all unused volumes
docker volume prune

# Run container with volume
docker run -v volume-name:/mount/path image-name`
    },
    {
      id: 'volume-warning',
      title: 'Important Volume Notes',
      type: 'warning',
      content: `
<p><strong>Warning:</strong> Removing a volume deletes all its data permanently! Always backup important volumes before removal. Use <code>docker volume prune</code> carefully as it removes ALL unused volumes.</p>
      `
    },
    {
      id: 'volume-cleanup',
      title: 'Clean Up Demo Volume',
      type: 'command',
      content: 'docker volume rm my-data-volume'
    },
    {
      id: 'next-steps',
      title: 'Volume Mastery Complete!',
      type: 'text',
      content: `
Excellent! You now understand Docker volume fundamentals:
- ✅ Why volumes are needed for persistent storage
- ✅ How to create and manage named volumes
- ✅ Difference between volumes and bind mounts
- ✅ How to share data between containers
- ✅ How to backup and restore volume data
- ✅ Essential volume management commands

**Coming next:** Learn about Docker Compose to orchestrate multi-container applications!
      `
    }
  ],
  nextLab: 'docker-compose-basics',
  previousLab: 'dockerfile-basics'
};
EOF

# Create Lab 5: Docker Compose
cat > src/labs/beginners/docker-compose.ts << 'EOF'
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
EOF

# Create the lab registry
cat > src/utils/labRegistry.ts << 'EOF'
import { Lab } from '@/types/lab';
import { helloWorldLab } from '@/labs/beginners/hello-world';
import { dockerImagesLab } from '@/labs/beginners/docker-images';
import { dockerfileBasicsLab } from '@/labs/beginners/dockerfile-basics';
import { dockerVolumesLab } from '@/labs/beginners/docker-volumes';
import { dockerComposeLab } from '@/labs/beginners/docker-compose';

export const labRegistry: Record<string, Lab> = {
  'docker-hello-world': helloWorldLab,
  'docker-images-basics': dockerImagesLab,
  'dockerfile-basics': dockerfileBasicsLab,
  'docker-volumes-basics': dockerVolumesLab,
  'docker-compose-basics': dockerComposeLab,
};

export const getLabById = (id: string): Lab | undefined => {
  return labRegistry[id];
};

export const getLabsByCategory = (category: string): Lab[] => {
  return Object.values(labRegistry).filter(lab => lab.category === category);
};

export const getAllLabs = (): Lab[] => {
  return Object.values(labRegistry);
};

export const getFeaturedLabs = (): Lab[] => {
  return Object.values(labRegistry).filter(lab => lab.featured);
};
EOF

echo "✅ All Docker lab files created successfully!"
echo ""
echo "📁 Files created:"
echo "  - src/types/lab.ts (TypeScript interfaces)"
echo "  - src/labs/beginners/hello-world.ts"
echo "  - src/labs/beginners/docker-images.ts"  
echo "  - src/labs/beginners/dockerfile-basics.ts"
echo "  - src/labs/beginners/docker-volumes.ts"
echo "  - src/labs/beginners/docker-compose.ts"
echo "  - src/utils/labRegistry.ts (Lab management)"
echo ""
echo "🚀 Next steps:"
echo "  1. Run this script after setting up your repository structure"
echo "  2. Install dependencies: npm install"
echo "  3. Create the React components for the modern UI"
echo "  4. Test the labs with Docker Desktop"
echo "  5. Push to your repository!"
echo ""
echo "🎉 You now have 5 fully migrated Docker labs ready to use!"
