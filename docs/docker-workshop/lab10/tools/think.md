---
title: "think"
---

The think tool gives the model the ability to stop and think. It's a kind of a whiteboard that the model can use to jot down its thoughts.

Read more about the thinking tool [here](https://www.anthropic.com/engineering/claude-think-tool).

To use this tool, add the type: think tool to the toolset of your agent

```
version: "2"

agents:
  root:
    model: openai/gpt-4o
    instruction: You talk like a pirate
    toolsets:
      - type: think
```

You can try by asking your pirate agent Think before you answer, where is the treasure map?

The keen-eyed might have noticed the version: "2" on the top of the YAML file above. While cagent is in active development and breaking things, we try not to break user's existing agents. If there is no version defined in the YAML file, the default version is 0, the current latest version is 2, always use the latest verison.
