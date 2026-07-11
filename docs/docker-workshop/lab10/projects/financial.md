---
title: "A Financial Analysis Team"
---

This demo shows how to integrate external MCP (Model Context Protocol) servers to create a specialized financial research team.

## Configuration

Create a file named `finance.yaml`:

```yaml
agents:
  root:
    model: openai/gpt-4o
    description: Financial research and analysis coordinator
    sub_agents: [finance_agent, web_search_agent]

  finance_agent:
    model: openai/gpt-4o
    description: Analyze given stock
    toolsets:
      - type: mcp
        command: uvx
        args: ["yfmcp"]  # Yahoo Finance MCP server

  web_search_agent:
    model: openai/gpt-4o
    description: Search web for information
    toolsets:
      - type: mcp
        command: uvx
        args: ["duckduckgo-mcp-server"]
```

## Prerequisites

1. Install `uv` (Python package manager):
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

2. Set API key:
```bash
export OPENAI_API_KEY=your_openai_key
```

## Running the Agent

```bash
./bin/cagent run finance.yaml
```

## MCP Server Integration

MCP (Model Context Protocol) servers extend agent capabilities with external tools:

| MCP Server | Purpose |
|------------|---------|
| `yfmcp` | Yahoo Finance data - stock prices, financials, history |
| `duckduckgo-mcp-server` | Web search for news and information |

### MCP Toolset Configuration

```yaml
toolsets:
  - type: mcp
    command: uvx          # Command to run the MCP server
    args: ["yfmcp"]       # Arguments passed to the command
```

## Agent Workflow

```
User Query: "Analyze Tesla stock"
        ↓
Root Agent (Coordinator)
        ↓
    ┌───┴───┐
    ↓       ↓
Web Search  Finance Agent
(News)      (Stock Data)
    ↓       ↓
    └───┬───┘
        ↓
Combined Analysis
```

## Example Interaction

```
> What's the current state of Tesla stock and recent news?

--- Agent: root ---

I'll gather comprehensive information for you.

[Delegating to web_search_agent for news]
[Delegating to finance_agent for stock data]

--- Agent: web_search_agent ---

[Searching DuckDuckGo for Tesla news...]

Recent headlines:
- Tesla Q3 deliveries exceed expectations
- New Gigafactory expansion announced
- FSD v12 rolling out to more users

--- Agent: finance_agent ---

[Fetching Yahoo Finance data...]

TSLA Current Price: $248.50
52-Week Range: $152.37 - $299.29
Market Cap: $790B
P/E Ratio: 62.4

--- Agent: root ---

Based on the analysis:
- Tesla stock is trading at $248.50, well within its 52-week range
- Recent positive news about deliveries and FSD could support momentum
- The P/E ratio suggests growth expectations remain high
```

## Key Takeaways

- MCP servers provide specialized capabilities (finance, search, databases, etc.)
- Tools run in isolated containers for security
- Coordinator agents combine insights from multiple specialized agents
- This pattern works for any domain requiring external data sources
