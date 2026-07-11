---
title: "Action in Docker Agent - Tool Execution + Sub-Agent Delegation"
---

Action is **how the agent changes its environment**. In cagent, action has two forms: calling tools directly (filesystem, shell, MCP) and delegating tasks to specialized sub-agents.

## Step 1: Create a project that needs multiple specialists

```bash
mkdir ~/action-test && cd ~/action-test

# A messy Python file that needs fixing, docs, and tests
cat > calculator.py << 'EOF'
# no docstrings, no error handling, inconsistent style
def add(a,b):
    return a+b
def subtract(a,b):
    return a-b
def divide(a,b):
    return a/b
def multiply(a,b):
    return a*b
EOF
```

## Step 2: Create a multi-agent team with distinct actions

```yaml
# action.yaml
version: "2"

agents:
  root:
    model: openai/gpt-5-mini
    description: Tech lead that delegates tasks to specialists
    instruction: |
      You are a tech lead. You have 3 specialists:
      - coder: Refactors code, adds error handling, improves style
      - tester: Writes comprehensive test files
      - documenter: Writes README and docstrings
      
      For calculator.py:
      1. Delegate to coder to refactor and add error handling
      2. Delegate to tester to write tests
      3. Delegate to documenter to write a README
      4. Verify everything works by running the tests yourself
      
      Coordinate the team. Do NOT do the work yourself.
    sub_agents: [coder, tester, documenter]
    toolsets:
      - type: shell

  coder:
    model: openai/gpt-5-mini
    description: Refactors code and adds error handling
    instruction: |
      You are a senior Python developer. Your ACTION is to:
      - Read the existing code
      - Rewrite it with proper style (PEP 8)
      - Add docstrings to every function
      - Add error handling (e.g., ZeroDivisionError for divide)
      - Write the improved file back
    toolsets:
      - type: filesystem

  tester:
    model: openai/gpt-5-mini
    description: Writes comprehensive test suites
    instruction: |
      You are a QA engineer. Your ACTION is to:
      - Read the source code
      - Write a test file (test_calculator.py) with pytest
      - Cover happy paths, edge cases, and error cases
      - Include at least 2 tests per function
    toolsets:
      - type: filesystem

  documenter:
    model: openai/gpt-5-mini
    description: Writes documentation and README files
    instruction: |
      You are a technical writer. Your ACTION is to:
      - Read the source code
      - Write a clear README.md with usage examples
      - Include installation, usage, and API reference sections
    toolsets:
      - type: filesystem
```

## Step 3: Run it

```bash
export OPENAI_API_KEY=<your_key>
cagent run ./action.yaml
```

Then type:

```
Refactor calculator.py, write tests, and create documentation. Use your team.
```

## What you should see

```
[root]        → Delegates to coder          ← ACTION: delegation
[coder]       ✓ Read  calculator.py         ← ACTION: perceive
[coder]       ✓ Edit  calculator.py         ← ACTION: modify environment
[root]        → Delegates to tester         ← ACTION: delegation
[tester]      ✓ Read  calculator.py         ← ACTION: perceive
[tester]      ✓ Write test_calculator.py    ← ACTION: create new file
[root]        → Delegates to documenter     ← ACTION: delegation
[documenter]  ✓ Read  calculator.py         ← ACTION: perceive
[documenter]  ✓ Write README.md             ← ACTION: create new file
[root]        ✓ Shell pytest -q             ← ACTION: verify everything works
```

## Key Teaching Point

| Action Type | cagent Mechanism | Example |
|---|---|---|
| **Direct tool call** | `toolsets: [filesystem, shell]` | Read file, write file, run command |
| **Sub-agent delegation** | `sub_agents: [coder, tester]` | Root hands off task to specialist |
| **Environment change** | Edit, Write, Shell | Files created, code modified, tests run |

The critical insight: the **root agent never touches a file**. It only has `shell` access to verify at the end. All the real work is delegated to specialists. This is the "Agents are the New Microservices" pattern - each agent has a single responsibility and its own action space.
