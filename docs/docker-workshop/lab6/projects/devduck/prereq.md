---
title: "Prerequisites & System Overview"
---

Before diving into the hands-on exercises, let's ensure your environment is properly set up and understand the system architecture we'll be working with.

### Software Prerequisites

#### ✅ Required Software

1. **Docker Desktop** (Latest version - 4.46.0)
   - Windows: Docker Desktop for Windows
   - macOS: Docker Desktop for Mac  
   - Linux: Docker Engine + Docker Compose

2. **Git** (for cloning repositories)

3. **Web Browser** (Chrome, Firefox, Safari, Edge)



#### 🔧 Verification Commands

Run these commands to verify your setup:

```bash
# Check Docker version
docker --version

# Check Docker Compose version
docker compose version

# Verify Docker is running
docker ps

# Check available system resources
docker system info
```

### Enable Docker Model Runner

Open Docker Desktop Settings > AI > “Docker Model Runner” is enabled.


#### Download AI models

```bash
docker model pull ai/llama3.2:1B-Q8_0
docker model pull ai/mistral:7B-Q4_0
docker model pull hf.co/menlo/lucy-gguf:q8_0
docker model pull hf.co/menlo/jan-nano-gguf:q4_k_m

```

### API Requirements

#### Cerebras API Setup

1. **Create Account**: Visit [https://cloud.cerebras.ai/](https://cloud.cerebras.ai/)
2. **Get API Key**: Navigate to API section and generate a key
3. **Verify Access**: Test API connectivity (we'll do this together)


Note: Cerebras offers a generous free tier for testing and learning. You won't need to provide payment information for this workshop.

## Pre-flight Checklist

Before proceeding to the next section, ensure you have:

- [ ] Docker Desktop installed and running
- [ ] Cerebras API account created and key obtained
- [ ] At least 16GB RAM available
- [ ] Stable internet connection
- [ ] Basic understanding of Docker concepts
- [ ] Terminal/command prompt access


## Next Steps

Great! Now that you have verified your prerequisites, you're ready to start building. In the next section, you'll clone the repository and begin the deployment process.

The exciting hands-on work begins now! 🚀

