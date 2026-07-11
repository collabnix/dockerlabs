---
title: "Alloy Models"
---

This demo showcases cagent's "alloy models" feature - the ability to use multiple AI models within a single agent.

## Configuration

Create a file named `alloy.yaml`:

```yaml
agents:
  root:
    model: claude,gpt-4o  # Multiple models!
    description: An agent that helps you learn new things
    instruction: |
      You are an expert learning companion.
      Help users learn effectively and enjoyably.

models:
  claude:
    provider: anthropic
    model: claude-3-5-sonnet-latest
  gpt-4o:
    provider: openai 
    model: gpt-4o
```

## Prerequisites

Set up API keys for both providers:

```bash
export OPENAI_API_KEY=your_openai_key
export ANTHROPIC_API_KEY=your_anthropic_key
```

## Running the Agent

```bash
./bin/cagent run alloy.yaml
```

## How Alloy Models Work

When you specify multiple models separated by commas (`model: claude,gpt-4o`), cagent:

1. Routes requests intelligently between models
2. Can switch between Claude and GPT-4 automatically for best responses
3. Leverages each model's strengths for different types of queries

## Use Cases

- **Learning applications**: Get explanations from different perspectives
- **Research tasks**: Cross-validate information across models
- **Creative work**: Combine different AI "voices" and styles
- **Reliability**: Fallback to another model if one is unavailable

## Key Takeaways

- Alloy models let you combine multiple AI providers in one agent
- Define models separately in the `models` section
- Reference them by name in the agent's `model` field
- Great for applications requiring diverse AI capabilities
