---
title: "Clone and build"
---

## Prerequisite

- Install Go 1.24+, and Taskfile
- Docker (for tool isolation and MCP servers)
- API keys for your chosen AI providers

### Using Homebrew on Mac


```
brew install go-task/tap/go-task
brew upgrade go-task/tap/go-task
brew install docker-agent
```

### Using Git

```

git clone https://github.com/docker/docker-agent.git
cd docker-agent
task build-web  # Build React frontend first
task build      # Build Go binary
task link       # Optional: create symlink to ~/bin
```

### Set API Keys

```
# For OpenAI models
export OPENAI_API_KEY=your_api_key_here

# For Anthropic models  
export ANTHROPIC_API_KEY=your_api_key_here

# For Gemini models
export GOOGLE_API_KEY=your_api_key_here
```

### Your First Agent

Copy the content and save it in `my-agent.yaml` file


```
agents:
  root:
    model: openai/gpt-4o
    description: A helpful AI assistant
    instruction: |
      You are a knowledgeable assistant that helps users with various tasks.
      Be helpful, accurate, and concise in your responses.
```

Ensure that you have already export OPENAI_API_KEY.

Run it.

```
$ docker agent run my-first-agent.yaml

```

### Prompt 1: 

```
> Hello
```
### Result:

```
--- Agent: root ---

Hello! How can I assist you today?
```


🎉 Your Docker Agent is now running successfully! 

- ✅ Connected to OpenAI API
- ✅ Loaded the root agent from my-agent.yaml
- ✅ Ready to respond to messages




```
>  What can you help me with?
```

### Prompt 2:

```
I can assist with a wide range of tasks, including:

1. Answering general knowledge questions.
2. Providing explanations and summaries of topics.
3. Assisting with language translations.
4. Offering writing and editing support.
5. Helping with basic math calculations.
6. Assisting with coding and programming queries.
7. Providing guidance on using software applications.
8. Offering study tips and learning strategies.
9. Giving advice on various topics like technology, health, finance, and more.

Let me know how I can assist you today!
```

### Prompt 3:

```
> Tell me about Docker containers
```

### Result:

```
--- Agent: root ---

Docker containers are a form of lightweight, portable, and self-sufficient software packaging technology. They encapsulate an application and its dependencies into a single package that can run consistently across various environments. Here’s a brief overview of key concepts related to Docker containers:

1. **Isolation**: Containers provide an isolated environment for applications, ensuring they run consistently regardless of where they are deployed, whether it’s on a developer’s machine, a test environment, or in production.

2. **Portability**: Since containers encapsulate all necessary components, including the application code, dependencies, libraries, and configuration files, you can easily move them across different environments without compatibility issues.

3. **Efficiency**: Unlike virtual machines, containers share the host system's operating system kernel, which makes them lightweight and fast to start. This reduces overhead and allows you to run more containers on a single host compared to virtual machines.

4. **Reproducibility**: Docker uses images as the blueprint for containers. These images can be versioned and stored in registries, such as Docker Hub, allowing developers to share and reproduce environments consistently.

5. **Scalability**: Docker works well with orchestration tools like Kubernetes, enabling the efficient scaling of applications across a cluster of machines, providing robust solutions for deployment and management at scale.

Overall, Docker containers have become popular in development and deployment pipelines due to their flexibility, speed, and efficiency in managing and deploying applications.

> 
```

### Prompt 4:


```
> Help me write a Dockerfile based on Python
```

### Result:

```
--- Agent: root ---

Creating a Dockerfile for a Python application involves specifying the base image, copying your application code into the image, installing dependencies, and defining the command to run your application. Below is a basic example of a Dockerfile for a Python application:

dockerfile
# Use the official Python image from the Docker Hub
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Specify the command to run the application
CMD ["python", "your_application.py"]


### Instructions:

1. **Base Image**: The `FROM` instruction specifies the base image. In this example, we used `python:3.11-slim`, which is a minimal image containing Python 3.11. You can choose a different version based on your requirements.

2. **Working Directory**: The `WORKDIR` sets the working directory inside the container to `/app`.

3. **Copy Requirements**: The `COPY requirements.txt .` command copies the `requirements.txt` file from your host into the container's working directory. Make sure this file lists all the dependencies your application needs.

4. **Install Dependencies**: The `RUN pip install --no-cache-dir -r requirements.txt` command installs the dependencies listed in `requirements.txt`. The `--no-cache-dir` option helps reduce the image size by not caching the downloaded packages.

5. **Copy Application Code**: The `COPY . .` command copies all the content from your current directory (where your Dockerfile is located) into the container's working directory.

6. **Run Application**: The `CMD` instruction specifies the command to run your Python application. Replace `your_application.py` with the entry-point script for your application.

### Building and Running:

To build and run the image, use the following commands:

1. Build the Docker image:

   ```sh
   docker build -t my-python-app .
   ```

2. Run the Docker container:

   ```sh
   docker run my-python-app
   ```

These commands should be run in the directory containing your Dockerfile and application code. Adjust the instructions as needed to fit your specific application setup.

```


