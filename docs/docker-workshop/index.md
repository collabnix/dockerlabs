---
title: "Welcome to Docker Workshop"
---

A hands-on, workshop covering the full Docker developer experience - from inner-loop workflows and containerization basics all the way to AI agents, MCP servers, security hardening, and Sandboxing.


## 🗺️ What's Covered

### 🐳 Docker 101

Get comfortable with core Docker concepts and a real-world sample app.

| Topic | Link |
| --- | --- |
| Inner vs Outer Loop Development | [Start →](/docker-workshop/lab1/overview) |
| What is a Container | [Start →](/docker-workshop/lab1/what-is-a-container) |
| Running Postgres Containers | [Start →](/docker-workshop/lab1/postgres) |
| Product Catalog - Overview | [Start →](/docker-workshop/product-catalog/overview) |
| Product Catalog - Tech Stack | [Start →](/docker-workshop/product-catalog/tech-stack) |
| Product Catalog - Develop | [Start →](/docker-workshop/product-catalog/develop) |
| Product Catalog - Test | [Start →](/docker-workshop/product-catalog/test) |
| Product Catalog - Build | [Start →](/docker-workshop/product-catalog/build) |
| Product Catalog - Secure | [Start →](/docker-workshop/product-catalog/secure) |

---

### 🧠 Docker & AI

Run AI models locally, connect them to tools via MCP, build agents, and safely sandbox AI-generated actions - all inside Docker.

#### 🤖 Docker Agent

Build, run, and share AI agents using Docker's declarative multi-agent runtime.

| Topic | Link |
| --- | --- |
| Overview | [Start →](/docker-workshop/lab10/overview) |
| Getting Started | [Start →](/docker-workshop/lab10/getting-started) |
| **Concepts** | |
| Autonomy | [Start →](/docker-workshop/lab10/concept/autonomy) |
| Perception | [Start →](/docker-workshop/lab10/concept/perception) |
| Reasoning | [Start →](/docker-workshop/lab10/concept/reasoning) |
| Action | [Start →](/docker-workshop/lab10/concept/action) |
| Goal-oriented | [Start →](/docker-workshop/lab10/concept/goal) |
| **Built-in Tools** | |
| memory | [Start →](/docker-workshop/lab10/tools/memory) |
| think | [Start →](/docker-workshop/lab10/tools/think) |
| todo | [Start →](/docker-workshop/lab10/tools/todo) |
| shell | [Start →](/docker-workshop/lab10/tools/shell) |
| filesystem | [Start →](/docker-workshop/lab10/tools/filesystem) |
| environment | [Start →](/docker-workshop/lab10/tools/environment) |
| **Integrations** | |
| Docker Agent with MCP | [Start →](/docker-workshop/lab10/integration/mcp) |
| Docker Agent with Docker Model Runner | [Start →](/docker-workshop/lab10/integration/dmr) |
| Docker Agent with RAG | [Start →](/docker-workshop/lab10/integration/rag) |
| **Projects** | |
| A Simple Pirate Agent | [Start →](/docker-workshop/lab10/projects/pirate) |
| Learning Agent with Alloy Models | [Start →](/docker-workshop/lab10/projects/alloy) |
| Developer Agent with Tools | [Start →](/docker-workshop/lab10/projects/dev) |
| Financial Analysis Team | [Start →](/docker-workshop/lab10/projects/financial) |
| Docker Expert Team | [Start →](/docker-workshop/lab10/projects/docker-expert) |
| Bug Investigator | [Start →](/docker-workshop/lab10/projects/bug-investigator) |
| Auto Curator Agent | [Start →](/docker-workshop/lab10/projects/auto-curator-agent) |
| Sharing Agents | [Start →](/docker-workshop/lab10/sharing) |

#### 🚀 Docker Model Runner

Run LLMs locally inside Docker - no cloud required, GPU-accelerated inference out of the box.

| Topic | Link |
| --- | --- |
| Overview | [Start →](/docker-workshop/lab4/overview) |
| Getting Started | [Start →](/docker-workshop/lab4/getting-started) |
| Product Catalog Chatbot | [Start →](/docker-workshop/lab4/projects/catalog-chatbot) |
| GenAI Chatbot | [Start →](/docker-workshop/lab4/projects/genai-chatbot) |

#### 🔌 Docker MCP Catalog and Toolkit

Connect AI models to real tools and services via the Model Context Protocol, managed securely through Docker.

| Topic | Link |
| --- | --- |
| Overview | [Start →](/docker-workshop/lab5/overview) |
| Getting Started | [Start →](/docker-workshop/lab5/getting-started) |
| Visual Chatbot | [Start →](/docker-workshop/lab5/projects/visual-chatbot) |
| Running your First MCP Server | [Start →](/docker-workshop/lab5/projects/visual-chatbot/mcp) |
| GitHub MCP Server and Claude Desktop | [Start →](/docker-workshop/lab5/projects/GitHub-Claude) |
| Docker MCP Server and Gordon | [Start →](/docker-workshop/lab5/projects/Docker-CLI-With-Gordon) |
| Docker MCP Server and VS Code | [Start →](/docker-workshop/lab5/projects/Docker-CLI-With-VSCode) |
| GitHub MCP Server and Gordon | [Start →](/docker-workshop/lab5/projects/GitHub-MCP-Gordon) |
| Kubernetes MCP Server and Claude | [Start →](/docker-workshop/lab5/projects/Kubernetes-MCP) |
| Slack MCP Server and Claude | [Start →](/docker-workshop/lab5/projects/Slack-MCP-With-Claude) |

#### 🧪 Sandboxing with Docker

Safely execute AI-generated code and agent actions in isolated containers to prevent unintended side effects.

| Topic | Link |
| --- | --- |
| Overview | [Start →](/docker-workshop/lab8/overview) |
| Getting Started | [Start →](/docker-workshop/lab8/getting-started) |
| Playwright Browser Testing | [Start →](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab8/projects/playwright-browser-testing) |

---

### 🧩 Agentic Compose

Multi-agent workflows orchestrated with Docker Compose.

| Topic | Link |
| --- | --- |
| Overview | [Start →](/docker-workshop/lab6/overview) |
| Getting Started | [Start →](/docker-workshop/lab6/getting-started) |
| DevDuck - Overview | [Start →](/docker-workshop/lab6/projects/devduck/overview) |
| DevDuck - Prerequisite | [Start →](/docker-workshop/lab6/projects/devduck/prereq) |
| DevDuck - Getting Started | [Start →](/docker-workshop/lab6/projects/devduck/getting-started) |
| DevDuck - Local Agent Interaction | [Start →](/docker-workshop/lab6/projects/devduck/local-agent) |
| DevDuck - Cerebras Interaction | [Start →](/docker-workshop/lab6/projects/devduck/cerebras-interaction) |
| Agentic Product Catalog | [Start →](/docker-workshop/lab6/projects/agentic-catalog) |
| Hackathon Recommender | [Start →](/docker-workshop/lab6/projects/hackathon-recommender) |
| A2A Multi-Agent Fact Checker | [Start →](/docker-workshop/lab6/projects/a2a-multi-agent-fact-checker) |

---

### 🔒 Docker and Security

Harden your images and meet compliance requirements with Docker Hardened Images.

| Topic | Link |
| --- | --- |
| Overview | [Start →](/docker-workshop/lab9/dhi/overview) |
| Getting Started | [Start →](/docker-workshop/lab9/dhi/getting-started) |
| Image Scanning | [Start →](/docker-workshop/lab9/dhi/image-scanning) |
| Switch to DHI | [Start →](/docker-workshop/lab9/dhi/switch-to-dhi) |
| Compliance & Attestations | [Start →](/docker-workshop/lab9/dhi/compliance) |

---

### ⚡ Docker Offload

Offload GPU-intensive workloads to the cloud seamlessly.

| Topic | Link |
| --- | --- |
| Overview | [Start →](/docker-workshop/lab7/overview) |
| Getting Started | [Start →](/docker-workshop/lab7/getting-started) |

---

### ☸️ Kubernetes 101

Deploy a real app to a live cluster and learn the core building blocks hands-on - Pods, Deployments, Services, scaling, rolling updates, and Ingress.

| Topic | Link |
| --- | --- |
| Introduction & Your Cluster | [Start →](/docker-workshop/kubernetes-101/overview) |
| Pods | [Start →](/docker-workshop/kubernetes-101/pods) |
| Deployments | [Start →](/docker-workshop/kubernetes-101/deployments) |
| Services | [Start →](/docker-workshop/kubernetes-101/services) |
| Scaling & Rolling Updates | [Start →](/docker-workshop/kubernetes-101/scaling-and-updates) |
| Exposing Your App with Ingress | [Start →](/docker-workshop/kubernetes-101/ingress) |
| Bonus: Compose to Kubernetes with Compose Bridge | [Start →](/docker-workshop/kubernetes-101/compose-bridge) |
| Bonus: Talk to Your Model & Wrap-Up | [Start →](/docker-workshop/kubernetes-101/genai-on-kubernetes) |

---

## 🗓️ Suggested Learning Paths

This workshop is **self-paced and modular** - pick any topic and go. Here are a few suggested paths based on your goals:

| Goal | Suggested Topics |
| --- | --- |
| 🐣 New to Docker | Docker 101 → Product Catalog |
| 🤖 Build AI Apps | Docker Model Runner → Docker MCP → Docker Agent → Agentic Compose |
| 🔐 Focus on Security | Docker 101 → Docker and Security (DHI) |
| 🧠 Multi-Agent Systems | Docker Agent → Agentic Compose → Docker MCP |
| ⚡ GPU & Cloud Offload | Docker Model Runner → Docker Offload |
| 🔒 Safe AI Execution | Docker Model Runner → Sandboxing with Docker |
