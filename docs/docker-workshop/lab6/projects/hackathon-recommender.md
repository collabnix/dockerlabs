---
title: "AI Agents Hackathon Project Recommender"
---

![AI Agents](https://img.shields.io/badge/AI-Agents-blue) ![Next.js](https://img.shields.io/badge/Next.js-13-black) ![Python](https://img.shields.io/badge/Python-3.11-blue) ![Docker](https://img.shields.io/badge/Docker-Compose-blue) ![MCP](https://img.shields.io/badge/MCP-Protocol-green)


> **Discover your perfect hackathon project with AI-powered GitHub profile analysis**


An intelligent system that analyzes GitHub profiles and generates personalized hackathon project recommendations using AI agents, Model Context Protocol (MCP), and real-time data integration.


<img width="818" height="695" alt="image" src="https://github.com/user-attachments/assets/d0f4ef56-6877-4cdc-8f01-c71ba853c8ea" />


## Features

- **AI-Powered Analysis**: Intelligent GitHub profile analysis using AI agents
- **Real-Time Data**: Live integration with GitHub API through MCP servers
- **Personalized Recommendations**: Tailored hackathon projects based on skills and interests
- **Secure Architecture**: Containerized microservices with proper secrets management
- **Modern Stack**: Next.js + Python + Docker + MCP integration
- **Production Ready**: Scalable architecture with comprehensive tooling

## Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Next.js UI    │───▶│  Python Agents  │───▶│   MCP Gateway   │
│   (Port 3003)   │    │   (Port 7777)   │    │   (Port 8811)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
         │                       │                       │
         │                       │                       ▼
         │                       │              ┌─────────────────┐
         │                       │              │  GitHub Tools   │
         │                       │              │  DuckDuckGo     │
         │                       │              │  Fetch Tools    │
         │                       │              │  (76 tools)     │
         │                       │              └─────────────────┘
         │                       ▼
         │              ┌─────────────────┐
         │              │   AI Models     │
         │              │   Qwen3 Small   │
         │              │   (Local/API)   │
         │              └─────────────────┘
         ▼
┌─────────────────┐
│     User        │
│   Browser       │
└─────────────────┘
```

## Quick Start

### Prerequisites

- Docker & Docker Compose
- GitHub Personal Access Token
- 8GB+ RAM (for local AI models)

### 1. Clone & Setup

```bash
git clone https://github.com/ajeetraina/ai-agents-hackathon-recommender
cd ai-agents-hackathon-recommender
```

### 2. Configure Secrets

Create a file .mcp.env and add your GitHub PAT

```bash
nano .mcp.env
github.personal_access_token=XXX
```



### 3. Launch the Application

```bash
# Build and start all services
docker compose up -d --build

# Monitor the logs
docker compose logs -f
```

### 4. Access the Application

- **Web Interface**: http://localhost:3003
- **Agents API**: http://localhost:7777
- **Health Check**: http://localhost:7777/health

## 🎯 Usage

1. **Open** the web interface at http://localhost:3003
2. **Enter** any GitHub username (e.g., "microsoft", "torvalds", "ajeetraina")
3. **Click** "Get Recommendations"
4. **Receive** personalized hackathon project suggestions!

## 🔧 Development

### Local Development Setup

```bash
# Start in development mode
docker compose up --build

# Watch logs
docker compose logs -f agents-ui
docker compose logs -f agents
```

### API Endpoints

#### Agents Service (Port 7777)

- `GET /health` - Health check
- `POST /analyze` - Analyze GitHub profile
- `GET /agents` - List available agents

```bash
# Example API usage
curl -X POST http://localhost:7777/analyze \
  -H "Content-Type: application/json" \
  -d '{"username": "microsoft", "agent": "hackathon_recommender"}'
```
