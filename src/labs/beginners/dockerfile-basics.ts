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
