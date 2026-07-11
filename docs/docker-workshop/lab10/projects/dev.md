---
title: "A Complete Development Team"
---

This demo showcases cagent's multi-agent architecture with a complete development team including a Product Manager, Designer, and Engineer.

## Configuration

Create a file named `dev-team.yaml`:

```yaml
agents:
  root:
    model: model
    description: Product Manager - Leads the development team
    sub_agents: [designer, awesome_engineer]
    toolsets:
      - type: filesystem
      - type: think
      - type: todo
      - type: memory
        path: dev_memory.db

  designer:
    model: model
    description: UI/UX Designer - Creates user interface designs
    toolsets:
      - type: filesystem
      - type: think
      - type: memory
        path: dev_memory.db

  awesome_engineer:
    model: model
    description: Full Stack Engineer - Frontend and backend development
    toolsets:
      - type: filesystem
      - type: shell
      - type: think
      - type: memory
        path: dev_memory.db

models:
  model:
    provider: openai
    model: gpt-4o
```

## Running the Agent

```bash
./bin/cagent run dev-team.yaml
```

## Agent Hierarchy

```
Root Agent (Product Manager)
├── Designer (UI/UX Specialist)
└── Engineer (Full Stack Developer)
```

## How Task Delegation Works

1. **User sends request** to the root agent (Product Manager)
2. **Product Manager analyzes** the task complexity and domain
3. **Routes to appropriate sub-agent** based on expertise:
   - Design tasks → Designer
   - Implementation tasks → Engineer
4. **Sub-agent processes** the task using its specialized tools
5. **Results flow back** through the Product Manager to the user

## Example Interaction

```
> Build a user login page with modern styling

--- Agent: root (Product Manager) ---

I'll coordinate the team to build this feature.

[Delegating design work to designer]

--- Agent: designer ---

I'll create a modern login page design with:
- Clean, minimalist layout
- Email and password fields
- "Remember me" checkbox
- Social login options
- Responsive design for mobile

[Creating design specs...]

--- Agent: root (Product Manager) ---

[Delegating implementation to awesome_engineer]

--- Agent: awesome_engineer ---

I'll implement the login page based on the design:

[Using shell and filesystem tools to create React component...]

Done! Created LoginPage.jsx with Tailwind CSS styling.
```

## Key Takeaways

- `sub_agents` defines which agents the root can delegate to
- Each agent has specialized tools for their role
- The root agent coordinates and routes tasks intelligently
- This pattern scales to complex, real-world development workflows
