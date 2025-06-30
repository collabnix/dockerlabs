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
