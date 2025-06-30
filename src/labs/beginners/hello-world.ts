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
