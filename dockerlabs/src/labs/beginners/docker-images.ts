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
      id: 'pull-image',
      title: 'Pull an Image',
      type: 'command',
      content: 'docker pull nginx:alpine'
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
      id: 'run-nginx',
      title: 'Run a Container from the Image',
      type: 'command',
      content: 'docker run -d -p 8080:80 --name my-nginx nginx:alpine'
    },
    {
      id: 'stop-container',
      title: 'Stop and Remove the Container',
      type: 'command',
      content: 'docker stop my-nginx && docker rm my-nginx'
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
