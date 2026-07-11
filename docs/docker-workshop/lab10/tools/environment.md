---
title: "environment"
---

This developer agent is a good start, there is one piece missing though that would make it even better, it doesn't really know anything about the environment it is working in, l, it could find it out by running shell scripts, but that's just wasting tokens. cagent can automatically add information about the environemt the agent is working on by adding add_environemt_info: true to the agent definition:

```
version: "2"

agents:
  root:
    model: openai/gpt-4o
    instruction: You are an amazing developer
+    add_environment_info: true
    toolsets:
      - type: todo
      - type: shell
      - type: filesystem
```

Run this agent again, ask it what the current directory is or if the current directory is a git repository. The agent now knows this without having to make any tool calls. Neat!

The information that is added to its system prompt with this is:

- the current directory
- the current platform (windows, linux, etc.
- information if the current directory is a git repository or not

If you think that your agent needs to know what the current date you can add this to its system prompt too:

```
version: "2"

agents:
  root:
    model: openai/gpt-4o
    instruction: You are an amazing developer
    add_environment_info: true
+    add_date: true
    toolsets:
      - type: todo
      - type: shell
      - type: filesystem
```

This can be useful if you are plannig on asking your agent qauestions like "What were the commits made in this repository in the last day?"
