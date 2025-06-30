import { Lab } from '@/types/lab';

export const helloWorldLab: Lab = {
  id: 'hello-world',
  title: 'Hello World - Your First Docker Container',
  description: 'Learn the basics of Docker by running your first container with the classic hello-world image.',
  category: 'beginners',
  difficulty: 1,
  duration: '5-10 minutes',
  prerequisites: [
    'Docker installed on your system',
    'Basic command line knowledge'
  ],
  tags: ['basics', 'getting-started', 'containers', 'hello-world'],
  author: 'Docker Community',
  lastUpdated: '2024-06-30',
  featured: true,
  sections: [
    {
      id: 'tested-infrastructure',
      title: 'Tested Infrastructure',
      type: 'info',
      content: `
        <div class="overflow-x-auto">
          <table class="min-w-full divide-y divide-gray-200">
            <thead class="bg-gray-50">
              <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Platform</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Number of Instance</th>
                <th class="px-6 py-3 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">Reading Time</th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-gray-200">
              <tr>
                <td class="px-6 py-4 whitespace-nowrap text-sm font-medium text-gray-900">Play with Docker</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">1</td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-gray-500">5 min</td>
              </tr>
            </tbody>
          </table>
        </div>
      `
    },
    {
      id: 'prerequisites',
      title: 'Prerequisites',
      type: 'info',
      content: `
        Before starting this lab, ensure you have:
        <ul class="list-disc list-inside mt-2 space-y-1">
          <li>Created an account with <a href="https://hub.docker.com" class="text-blue-600 hover:text-blue-800">DockerHub</a></li>
          <li>Opened <a href="https://labs.play-with-docker.com/" class="text-blue-600 hover:text-blue-800">Play With Docker</a> platform on your browser</li>
          <li>Clicked on <strong>Add New Instance</strong> on the left side to bring up Alpine OS instance</li>
        </ul>
      `
    },
    {
      id: 'running-hello-world',
      title: 'Running Hello World Example',
      type: 'text',
      content: `
        Now let's run your first Docker container! The hello-world image is perfect for testing your Docker installation.
      `
    },
    {
      id: 'hello-world-command',
      title: '',
      type: 'command',
      content: 'docker run hello-world'
    },
    {
      id: 'hello-world-image',
      title: 'Expected Output',
      type: 'image',
      imageUrl: 'https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/images/b301_helloworld.png',
      content: 'Screenshot showing the hello-world container output'
    },
    {
      id: 'explanation',
      title: 'What Just Happened?',
      type: 'text',
      content: `
        <p class="mb-4">This image is a prime example of using the scratch image effectively. The hello-world image demonstrates the minimal footprint possible for a Docker container.</p>
        
        <p class="mb-4">Here's what happened when you ran the command:</p>
        
        <ol class="list-decimal list-inside space-y-2">
          <li><strong>Docker searched locally:</strong> First, Docker looked for the "hello-world" image on your local machine.</li>
          <li><strong>Downloaded from DockerHub:</strong> Since the image wasn't found locally, Docker downloaded it from DockerHub.</li>
          <li><strong>Created a container:</strong> Docker turned the image into a running container.</li>
          <li><strong>Executed the program:</strong> The container ran its embedded program and displayed the message.</li>
          <li><strong>Container exited:</strong> After displaying the message, the container completed its task and stopped.</li>
        </ol>
      `
    },
    {
      id: 'did-you-know',
      title: 'Did You Know?',
      type: 'info',
      content: `
        <div class="space-y-4">
          <div>
            <h4 class="font-semibold text-lg mb-2">1. Incredibly Small Size</h4>
            <p class="mb-2">The Hello World Docker Image is only <strong>1.84 KB</strong> in size!</p>
          </div>
          
          <div>
            <h4 class="font-semibold text-lg mb-2">2. No Running Containers</h4>
            <p>When you run <code class="bg-gray-100 px-1 rounded">docker ps</code>, you won't see any running containers because the hello-world container executes once and exits immediately.</p>
          </div>
          
          <div>
            <h4 class="font-semibold text-lg mb-2">3. Inspect the Image</h4>
            <p>You can use <code class="bg-gray-100 px-1 rounded">docker inspect hello-world</code> to see detailed information about this image, including its layers, configuration, and metadata.</p>
          </div>
        </div>
      `
    },
    {
      id: 'verify-size',
      title: 'Verify the Image Size',
      type: 'text',
      content: 'Let\'s verify the small size of the hello-world image:'
    },
    {
      id: 'size-command',
      title: '',
      type: 'command',
      content: 'docker images hello-world'
    },
    {
      id: 'size-output',
      title: '',
      type: 'code',
      language: 'bash',
      content: `REPOSITORY    TAG       IMAGE ID       CREATED        SIZE
hello-world   latest    4ab4c602aa5e   6 weeks ago    1.84kB`
    },
    {
      id: 'no-running-containers',
      title: 'Check Running Containers',
      type: 'text',
      content: 'As mentioned, the container doesn\'t stay running. Let\'s verify this:'
    },
    {
      id: 'ps-command',
      title: '',
      type: 'command',
      content: 'docker ps'
    },
    {
      id: 'ps-output',
      title: '',
      type: 'code',
      language: 'bash',
      content: `CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES`
    },
    {
      id: 'inspect-example',
      title: 'Inspecting the Image (Optional)',
      type: 'text',
      content: 'For those curious about the image details, you can inspect it:'
    },
    {
      id: 'inspect-command',
      title: '',
      type: 'command',
      content: 'docker inspect hello-world'
    },
    {
      id: 'key-takeaways',
      title: 'Key Takeaways',
      type: 'info',
      content: `
        <ul class="list-disc list-inside space-y-2">
          <li><strong>Docker Run:</strong> The <code>docker run</code> command is used to create and start containers</li>
          <li><strong>Image Discovery:</strong> Docker searches locally first, then pulls from registries like DockerHub</li>
          <li><strong>Ephemeral Containers:</strong> Containers can be designed to run once and exit</li>
          <li><strong>Minimal Images:</strong> Docker images can be extremely small (hello-world is only 1.84KB)</li>
          <li><strong>Scratch Base:</strong> The hello-world image demonstrates using the minimal "scratch" base image</li>
        </ul>
      `
    },
    {
      id: 'additional-resources',
      title: 'Additional Resources',
      type: 'text',
      content: `
        <div class="space-y-4">
          <div>
            <h4 class="font-semibold">Source Code:</h4>
            <p>You can view the source code for the hello binary at: 
            <a href="https://github.com/docker-library/hello-world" class="text-blue-600 hover:text-blue-800">https://github.com/docker-library/hello-world</a></p>
          </div>
          
          <div>
            <h4 class="font-semibold">Get Help:</h4>
            <ul class="list-disc list-inside">
              <li>Docker Community Forums</li>
              <li>Docker Community Slack</li>
              <li>Stack Overflow</li>
            </ul>
          </div>
          
          <div>
            <h4 class="font-semibold">File Issues:</h4>
            <p><a href="https://github.com/docker-library/hello-world/issues" class="text-blue-600 hover:text-blue-800">https://github.com/docker-library/hello-world/issues</a></p>
          </div>
          
          <div>
            <h4 class="font-semibold">Supported Architectures:</h4>
            <p>amd64, arm32v5, arm32v7, arm64v8, i386, ppc64le, s390x, windows-amd64</p>
          </div>
        </div>
      `
    }
  ],
  nextLab: 'first-ubuntu-container'
};
