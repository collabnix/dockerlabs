---
title: "Prerequisites"
---

### 1. Docker Desktop

Ensure that the latest version of Docker Desktop is installed on your system (Mac, Windows and Linux)


### 2. Download your preferred IDEs (optional)

- IntelliJ IDEA
- VS Code

### 3. Enabling WSL 2 / Hyper V based engine on Docker Desktop for Windows


In case you're using Windows 11, you will need to enable WSL 2 by opening Docker Desktop > Settings > Resources > WSL Integration

![wsl2](https://github.com/ajeetraina/docker-workshop/tree/main/docs/prereq/images/wsl2.png)

If you want to stick to Hyper-V, then you can enable the Windows Hypervisor Platform (requires an elevated terminal):

```
Enable-WindowsOptionalFeature -Online -FeatureName HypervisorPlatform -All
```

Restart your machine when prompted.

### 4. Install Nodejs

To demonstrate the container-first development workflow, you will require Nodejs installed on your system.


> Note: You must download and install the Node pre-built installer on your local system to get the npm install command to work seamlessly. [Click here to download](https://nodejs.org/en/download/)

### 5. Access to the repositories


- [https://github.com/dockersamples/catalog-service-node](https://github.com/dockersamples/catalog-service-node)
- [https://github.com/dockersamples/genai-model-runner-metrics](https://github.com/dockersamples/genai-model-runner-metrics)
- [https://github.com/ajeetraina/catalog-service-node-chatbot](https://github.com/ajeetraina/catalog-service-node-chatbot)
- [https://github.com/ajeetraina/catalog-service-ai-enhanced](https://github.com/ajeetraina/catalog-service-ai-enhanced)
- [https://github.com/dockersamples/visual-chatbot](https://github.com/dockersamples/visual-chatbot)
- [https://github.com/ajeetraina/pen-shop-demo](https://github.com/ajeetraina/pen-shop-demo)

### 6. Enable Docker Model Runner (For Docker AI workshop)

```
docker desktop enable model-runner
```

### 7. Download the models (For Docker AI workshop)

Ensure that you have sufficient space to download these models on your Macbook.

```
docker model pull ai/llama3.2:1B-Q8_0
docker model pull hf.co/menlo/jan-nano-gguf:q4_k_m
docker model pull hf.co/menlo/lucy-gguf:q8_0
```

### 8. Docker Labspace CLI installed on your system 

Install Labspace CLI using this link [https://github.com/docker/docker-labspace-cli](https://github.com/docker/docker-labspace-cli) 

### 9. Bring your own API Keys (for AI Governance and Sandbox Workshop) 

Bring your own OpenAI or Anthropic Key to test AI Coding Agent in a Sandbox environment 

