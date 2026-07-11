---
title: "memory"
---

The memory tool gives the agent the ability to remember things about the user.

Give this agent a try:

```
version: "2"

agents:
  root:
    model: openai/gpt-4o
    instruction: You are a personal asisstant
    toolsets:
      - type: memory
        path: ./memory.db
```

Run this agent once, tell it your name and some random fact about you. Something like I'm XXX and I'm a software engineer. You should see it calling the memory tools to remember facts about you.

If you then quit cagent and start a new session with this agent. You can ask it what it knows about you, it should correctly look up its internal memory and tell you what it knows. For example: Who am I? or What do I do for a living?
