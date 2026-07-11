---
title: "Developer Tools"
---

This demo introduces cagent's built-in toolsets, enabling agents to interact with files and manage tasks.

## Configuration

Create a file named `todo.yaml`:

```yaml
agents:
  root:
    model: anthropic/claude-3-5-sonnet-latest
    description: Expert developer
    instruction: |
      Help user with coding queries.
      Edit code directly using tools.
    toolsets:
      - type: filesystem  # File operations
      - type: todo       # Task management
```

## Prerequisites

```bash
export ANTHROPIC_API_KEY=your_anthropic_key
```

## Running the Agent

```bash
./bin/cagent run todo.yaml
```

## Built-in Toolsets

cagent provides several built-in tools that agents can use:

| Toolset | Description |
|---------|-------------|
| `filesystem` | Read, write, and manipulate files safely |
| `todo` | Task management across agents |
| `memory` | Persistent SQLite storage |
| `think` | Step-by-step reasoning |
| `shell` | Execute commands securely |
| `transfer_task` | Agent-to-agent delegation |

## Example Interactions

### File Operations

```
> Create a Python script that prints "Hello, World!"

--- Agent: root ---

I'll create that script for you.

[Using filesystem tool to create hello.py]

Done! I've created `hello.py` with the following content:
print("Hello, World!")
```

### Task Management

```
> Add a task to review the PR for the authentication module

--- Agent: root ---

[Using todo tool]

Task added: "Review PR for authentication module"
Your current tasks:
1. Review PR for authentication module
```

## Key Takeaways

- Toolsets extend what agents can do beyond conversation
- Multiple toolsets can be combined in one agent
- Tools execute securely within the cagent environment
- This foundation enables building powerful development assistants
