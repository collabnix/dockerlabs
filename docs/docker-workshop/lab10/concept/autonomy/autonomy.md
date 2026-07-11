---
title: "Autonomy in Docker Agent - The Agentic Loop"
---

The agent **loops independently** - deciding, acting, observing - up to N iterations with zero human intervention.

## Step 1: Create a directory structure and add buggy Python file

```bash
mkdir ~/autonomy-test && cd ~/autonomy-test

# Create a buggy Python file
cat > app.py << 'EOF'
def add(a, b):
    return a - b  # BUG: should be a + b

def multiply(a, b):
    return a * b

if __name__ == "__main__":
    print(f"2 + 3 = {add(2, 3)}")
    print(f"4 * 5 = {multiply(4, 5)}")
EOF

# Create a test file
cat > test_app.py << 'EOF'
from app import add, multiply

def test_add():
    assert add(2, 3) == 5, f"Expected 5, got {add(2, 3)}"

def test_multiply():
    assert multiply(4, 5) == 20, f"Expected 20, got {multiply(4, 5)}"

if __name__ == "__main__":
    test_add()
    print("test_add passed")
    test_multiply()
    print("test_multiply passed")
    print("All tests passed!")
EOF
```

## Step 2: Setup OpenAI API Key

```bash
export OPENAI_API_KEY=<your_key>
```

## Step 3: Create a Docker Agent file

```yaml
# autonomy.yaml
version: "2"

agents:
  root:
    model: openai/gpt-5-mini
    description: Autonomous bug debugger
    instruction: |
      You are an autonomous debugging agent.
      1. Run the tests using: python test_app.py
      2. Read the error output
      3. Read the source code to find the bug
      4. Fix the bug
      5. Run the tests again to verify
      6. Stop only when all tests pass

      Do NOT ask for permission. Just do it.
    toolsets:
      - type: filesystem
      - type: shell
```

> Did you notice?
> We've defined the built-in tools:
>
> - filesystem - to Read and Edit app.py
> - shell - to run pytest -q

> If you remove type: shell from the YAML, the agent might be able to read and edit files but won't run tests - it would be like a developer who can write code but has no terminal. 

## Step 4: Run Docker Agent

```bash
docker agent run ./autonomy.yaml
```

Then type:

```
Start
```

## What you should see

The agent will autonomously:

```
Iteration 1 → shell: python test_app.py
             → sees "AssertionError: Expected 5, got -1"

Iteration 2 → filesystem: reads app.py
             → spots "return a - b"

Iteration 3 → think: "The add function subtracts instead of adding"

Iteration 4 → filesystem: writes fixed app.py (a + b)

Iteration 5 → shell: python test_app.py
             → "All tests passed!"

Agent stops ✅
```

With `docker agent run`, the autonomy boundary is defined by:

- The **instruction** itself (telling the agent when to stop)
- The **model's built-in tool-calling loop** (the runtime keeps looping as long as the model makes tool calls)
- **Ctrl+C** to manually stop

No human told it what to do between steps - that's **autonomy** in action.


## Step 5: Quick test for cagent new with --max-iterations

```bash
# This one lets you set the guardrail explicitly
docker agent new --model openai/gpt-5-mini --max-iterations 10
```

Then give it the same task. Watch it stop after 10 loops max even if it hasn't finished - that's the autonomy boundary at work.

## Conclusion

This is what makes it truly agentic - compared to a simple chatbot that just responds once, this system makes a chain of independent decisions across multiple specialists. The `--max-iterations` gives the entire team a budget of autonomous cycles to work with.

Here the autonomy is **multi-layered**:

- The **root agent** autonomously decides *who* to delegate to
- Each **sub-agent** autonomously decides *how* to do its job
- The **root agent** autonomously decides *when the job is done*
