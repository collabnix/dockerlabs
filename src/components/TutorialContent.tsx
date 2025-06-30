
import { ArrowRight, ArrowLeft, CheckCircle, Copy, Play, Terminal } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";

interface TutorialContentProps {
  currentTopic: string;
}

const tutorialContent = {
  introduction: {
    title: "What is Docker?",
    description: "Learn the fundamentals of containerization with Docker",
    duration: "10 min read",
    difficulty: "Beginner",
    content: `
      Docker is a platform that enables developers to package applications into containers—lightweight, 
      portable units that include everything needed to run an application: code, runtime, system tools, 
      libraries, and settings.

      ## Why Docker?
      
      - **Consistency**: Your application runs the same way everywhere
      - **Efficiency**: Containers share the host OS kernel, making them lightweight
      - **Scalability**: Easy to scale applications up or down
      - **Isolation**: Applications run in isolated environments

      ## Key Concepts

      ### Containers vs Virtual Machines
      
      While virtual machines virtualize entire operating systems, containers virtualize at the 
      application layer, sharing the host OS kernel. This makes containers much more efficient.

      ### Docker Architecture
      
      Docker uses a client-server architecture:
      - **Docker Client**: The command-line interface you use
      - **Docker Daemon**: The background service that manages containers
      - **Docker Images**: Templates used to create containers
      - **Docker Registry**: Where images are stored (like Docker Hub)
    `,
    codeExample: {
      title: "Your First Docker Command",
      description: "Let's verify Docker is installed and working",
      code: `# Check Docker version
docker --version

# Run your first container
docker run hello-world`,
      language: "bash"
    }
  },
  installation: {
    title: "Installing Docker",
    description: "Get Docker up and running on your system",
    duration: "15 min",
    difficulty: "Beginner",
    content: `
      ## Installing Docker Desktop

      Docker Desktop is the easiest way to get started with Docker on Windows and macOS. 
      It includes everything you need: Docker Engine, Docker CLI, Docker Compose, and more.

      ### Windows Installation

      1. Download Docker Desktop from [docker.com](https://docker.com)
      2. Run the installer and follow the setup wizard
      3. Restart your computer when prompted
      4. Launch Docker Desktop from the Start menu

      ### macOS Installation

      1. Download Docker Desktop for Mac
      2. Drag Docker to your Applications folder
      3. Launch Docker from Applications
      4. Follow the setup assistant

      ### Linux Installation

      For Ubuntu/Debian:
    `,
    codeExample: {
      title: "Install Docker on Ubuntu",
      description: "Step-by-step installation commands",
      code: `# Update package index
sudo apt-get update

# Install prerequisites
sudo apt-get install \\
    ca-certificates \\
    curl \\
    gnupg \\
    lsb-release

# Add Docker's official GPG key
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Add the repository
echo \\
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \\
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Install Docker Engine
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io

# Verify installation
sudo docker run hello-world`,
      language: "bash"
    }
  },
  "first-container": {
    title: "Your First Container",
    description: "Run your first Docker container and understand the basics",
    duration: "20 min",
    difficulty: "Beginner",
    content: `
      ## Running Your First Container

      Now that Docker is installed, let's run your first container! We'll start with a simple 
      web server to demonstrate key concepts.

      ## The docker run Command

      The \`docker run\` command creates and starts a new container from an image. 
      It's the most fundamental Docker command you'll use.

      ### Basic Syntax
      \`\`\`
      docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
      \`\`\`

      ## Interactive Containers

      Let's start with an interactive container where we can explore:
    `,
    codeExample: {
      title: "Running an Interactive Container",
      description: "Start an Ubuntu container and interact with it",
      code: `# Run an interactive Ubuntu container
docker run -it ubuntu:latest /bin/bash

# Once inside the container, try these commands:
ls -la
cat /etc/os-release
echo "Hello from inside Docker!"

# Exit the container
exit`,
      language: "bash"
    }
  }
};

export function TutorialContent({ currentTopic }: TutorialContentProps) {
  const content = tutorialContent[currentTopic as keyof typeof tutorialContent];
  
  if (!content) {
    return (
      <div className="p-8 text-center">
        <h2 className="text-2xl font-bold text-gray-900 mb-4">Content Coming Soon</h2>
        <p className="text-gray-600">This tutorial section is being prepared.</p>
      </div>
    );
  }

  const copyToClipboard = (text: string) => {
    navigator.clipboard.writeText(text);
  };

  return (
    <div className="max-w-4xl mx-auto p-8">
      {/* Header */}
      <div className="mb-8">
        <div className="flex items-center space-x-4 mb-4">
          <Badge variant="outline" className="bg-blue-50 text-blue-700 border-blue-200">
            {content.difficulty}
          </Badge>
          <span className="text-sm text-gray-500">{content.duration}</span>
        </div>
        <h1 className="text-4xl font-bold text-gray-900 mb-4">{content.title}</h1>
        <p className="text-xl text-gray-600">{content.description}</p>
      </div>

      {/* Content */}
      <div className="prose prose-lg max-w-none mb-8">
        <div className="whitespace-pre-line text-gray-700 leading-relaxed">
          {content.content}
        </div>
      </div>

      {/* Code Example */}
      {content.codeExample && (
        <Card className="mb-8 border-gray-200 shadow-sm">
          <CardHeader className="bg-gray-50">
            <div className="flex items-center justify-between">
              <div>
                <CardTitle className="text-lg flex items-center space-x-2">
                  <Terminal className="w-5 h-5 text-gray-600" />
                  <span>{content.codeExample.title}</span>
                </CardTitle>
                <CardDescription>{content.codeExample.description}</CardDescription>
              </div>
              <Button
                variant="outline"
                size="sm"
                onClick={() => copyToClipboard(content.codeExample.code)}
                className="flex items-center space-x-2"
              >
                <Copy className="w-4 h-4" />
                <span>Copy</span>
              </Button>
            </div>
          </CardHeader>
          <CardContent className="p-0">
            <pre className="bg-gray-900 text-gray-100 p-6 overflow-x-auto rounded-b-lg">
              <code>{content.codeExample.code}</code>
            </pre>
          </CardContent>
        </Card>
      )}

      {/* Navigation */}
      <div className="flex justify-between items-center pt-8 border-t border-gray-200">
        <Button variant="outline" className="flex items-center space-x-2">
          <ArrowLeft className="w-4 h-4" />
          <span>Previous</span>
        </Button>
        
        <div className="flex items-center space-x-2">
          <CheckCircle className="w-5 h-5 text-green-500" />
          <span className="text-sm text-gray-600">Mark as Complete</span>
        </div>
        
        <Button className="flex items-center space-x-2 bg-blue-600 hover:bg-blue-700">
          <span>Next</span>
          <ArrowRight className="w-4 h-4" />
        </Button>
      </div>
    </div>
  );
}
