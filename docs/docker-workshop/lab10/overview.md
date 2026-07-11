---
title: "Who's This For"
---

## What is Docker Agent?

[Docker Agent](https://github.com/docker/docker-agent) is an open-source, multi-agent runtime designed to simplify the development and deployment of autonomous AI systems. Unlike traditional chatbots, this tool allows developers to orchestrate specialized teams of agents that can plan, reason, and execute complex tasks through a declarative YAML configuration. 

## What problem it solves?

AI agents today work alone. They can't collaborate or specialize. This creates several challenges:

- **Single Point of Failure**: One agent handles everything. No specialization means lower quality results.
- **No Task Delegation**: Complex projects need different expertise. Current agents can't hand off work to specialists.
- **Tool Access Chaos**: Each agent manages its own tools separately. No unified tool ecosystem across agents.
- **Configuration Complexity**: Setting up multiple AI systems requires separate configurations. Each client needs different setup.
- **Security Gaps**: Running AI tools with full system access. No container isolation or proper secret management.
- **Scaling Problems**: Can't distribute workload across multiple specialized agents. Everything bottlenecks through one system.

## The Solution

Docker introduces Docker Agent - a multi-agent orchestration platform that solves these problems through:

- **Hierarchical Agent Teams**: Root agents coordinate with specialized sub-agents. Each agent has specific expertise and tools.
- **Unified Tool Ecosystem**: All agents share the same secure tool infrastructure. Built-in tools plus MCP server integration.
- **Enterprise Security**: Container isolation for tool execution. Proper secret management and multi-tenant support.

Docker Agent enables you to create intelligent agent teams where each agent has specialized knowledge, tools, and capabilities. Think of it as building a virtual team of AI experts that collaborate to solve complex problems.

Built in Go by Docker, Docker Agent brings enterprise-grade security and scalability to multi-agent AI systems.

## Key Features

- Multi-Agent Architecture: Create specialized agents for different domains. Root agents delegate tasks to expert sub-agents automatically.
- Rich Tool Ecosystem: Built-in tools (think, todo, memory, filesystem, shell). Plus MCP protocol integration for external tools.
- Multiple AI Providers: Support for OpenAI, Anthropic, Gemini, and Docker Model Runner (DMR). Mix different models in one conversation with "alloy models".
- Flexible Interfaces: CLI, Web UI, TUI, and MCP Server modes. Same agent configs work across all interfaces.
- YAML Configuration: Simple, declarative setup for agents, models, and tools. Version control friendly configurations.
- Docker Integration: Push and pull agent configs like container images. Share agents through Docker Hub.
- Built-in Security: Container isolation, secret management, and multi-tenant support. Production-ready from day one.


- AI Application Developers: Build sophisticated AI applications with specialized agent teams. Focus on business logic while Docker Agent handles coordination.
- Enterprise Development Teams: Deploy secure, scalable AI agent systems. Centralized management with proper access controls.
- DevOps Engineers: Container-native AI agent platform. Integrates with existing Docker workflows and Kubernetes deployments.
- AI Researchers: Experiment with multi-agent architectures. Easy configuration and tool integration for research projects.
