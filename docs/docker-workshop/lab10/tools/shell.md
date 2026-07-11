---
title: "shell"
---

Let's start creating our own developer agent. We will take the developer above and give it access to our shell and filesystem.

```
version: "2"

agents:
  root:
    model: openai/gpt-4o
    instruction: You are an amazing developer
    toolsets:
      - type: todo
      - type: shell
      - type: filesystem
```

This is basically all it takes to have a basic developer agent. Try it out! Ask it to "write a snake game in an index.html file"
