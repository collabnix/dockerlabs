---
title: "Basic Multi-Agent Interaction"
---

Now that your system is properly deployed and configured, it's time to explore how the multi-agent system works in practice. You'll learn to interact with DevDuck and understand how it coordinates between different agents to provide intelligent responses.

## Understanding the Interface

### 🌐 Web Interface Overview

Let's start by familiarizing yourself with the DevDuck interface:

1. **Open the Interface**: Navigate to [http://localhost:8000/dev-ui/?app=devduck](http://localhost:8000/dev-ui/?app=devduck)

2. **Interface Components**:
   - **Chat Area**: Main conversation interface
   - **Input Field**: Where you type your messages
   - **Agent Indicator**: Shows which agents are active
   - **System Status**: Connection and health indicators

### 🔍 Interface Features

Explore these key features:

#### Message Types
The interface supports various message formats:
- **Text Messages**: Standard conversation
- **Code Blocks**: Formatted code snippets
- **System Messages**: Agent status updates
- **Error Messages**: Troubleshooting information

#### Agent Status Indicators
Look for these visual cues:
- 🟢 **Green**: Agent is online and responding
- 🟡 **Yellow**: Agent is processing
- 🔴 **Red**: Agent is unavailable or erroring
- 🔵 **Blue**: Agent is initializing

## First Interactions

### 🤖 Basic Conversation

Let's start with simple interactions to test the system:

### Exercise 1: Introduction

**Try this conversation:**

```
You: Hello DevDuck! Can you introduce yourself?
```

**Expected Response Pattern:**
- DevDuck will introduce itself as a multi-agent system
- It should mention its capabilities and available agents
- The response might route to the Local Agent for a quick reply

#### Observation

Notice the tabs available - Trace, Events, State, Artifacts, Sessions, Eval - this gives developers comprehensive insight into agent behavior. 
You can track not just what the agent did, but how long each step took, what state changes occurred, and what artifacts were created. 

The Session ID at the top shows this is running in an isolated session, and the dropdown showing "devduck" indicates you can switch between different agent configurations.

 This interface transforms AI agent development from a "black box" experience into transparent, debuggable system. Wonder "Why did the agent make that decision?" or "What's taking so long?", they can use this exact interface to trace through every step, measure performance bottlenecks, and understand the agent's reasoning process. This is what makes DevDuck not just a demo, but a serious development platform for building production AI agents.



### Exercise 2: Agent Awareness

**Ask about the agents:**

```
You: What agents are available in this system?
```

**Expected Response:**
DevDuck should explain:
- Local Agent for quick processing
- Cerebras Agent for complex analysis
- Its own role as orchestrator
- How it decides which agent to use

#### Observation

- Notice how the devduck_agent is acting as the orchestrator - it can describe the other agents and route tasks appropriately.
- This confirms the architecture where the Local Agent  makes routing decisions about when to delegate to the high-performance Cerebras Agent for complex tasks.
- Tracing the Decision Process: The left panel shows this simple question took ~12.3 seconds to process, with most time spent in agent_run [devduck_agent] and the call_llm.
- This demonstrates the intelligent routing logic - even answering "what agents are available" requires the main agent to think through the system architecture and provide contextual information about each agent's capabilities.
-It's fascinating to see how they can trace every decision and understand exactly how the multi-agent system coordinates to provide responses.
- This is the "agentic loop" with full transparency that makes DevDuck so powerful for development!Retry

### 🧠 Understanding Agent Routing

DevDuck makes intelligent decisions about which agent should handle each request. Let's explore this:

### Exercise 3: Simple vs Complex Queries

**Simple Query (likely routed to Local Agent):**
```
You: What is Python?
```

**Complex Query (likely routed to Cerebras Agent):**
```
You: Can you analyze this algorithm and suggest optimizations?

def fibonacci(n):
    if n <= 1:
        return n
    return fibonacci(n-1) + fibonacci(n-2)
```

**Observation Points:**
- Notice response time differences
- Check which agent handles each request in the logs
- Compare the depth and quality of responses


**Controlling the agents**

You: Cerebras, can you analyze this algorithm and suggest optimizations?

**Observation Points:**

- Try to see if explicit agent targeting changes the routing behavior!
- By prefixing with "Cerebras," you overrode the automatic routing logic and forced the system to use the high-performance agent.
- This is exactly what you need to understand - they can control which agent handles their requests.



## Next Steps

In the next section, you'll dive deeper into local agent capabilities and learn how to optimize local processing for specific tasks.

Ready to explore local agent specialization? Let's continue! 🚀



