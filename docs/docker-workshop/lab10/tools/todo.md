---
title: "todo"
---

The todo toolset instructs the model to use its todo-tracking tools when it needs to do a complex task. This tool can help the model keep in line while it's working on a complex task.

Adding the todo toolset works the same way as the think one.

The todo toolset can be useful for a developer agent. Breaking down a task into smaller, more manageable pieces is how most of developers work. Let's start creating our developer agent right now. Create a developer.yaml file and give it the todo toolset.

```
version: "2"

agents:
  root:
    model: openai/gpt-4o
    instruction: You are an amazing developer
    toolsets:
      - type: todo
```

Note: Here we changed the model used from gpt-4o-mini to gpt-4o, larger models are usually better at tool calling and following instructions, feel free to test out as many models as you wish with different setups.

Try this agent, see how it magically creates todo lists for its tasks and loops until the todos are done.


