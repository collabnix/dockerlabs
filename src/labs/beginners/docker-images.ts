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
