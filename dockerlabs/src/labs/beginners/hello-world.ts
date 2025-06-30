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
      id: 'list-images',
      title: 'View Downloaded Images',
      type: 'command',
      content: 'docker images'
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
