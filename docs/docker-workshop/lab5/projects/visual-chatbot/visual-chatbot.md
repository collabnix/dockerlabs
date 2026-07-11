---
title: "Visual Chatbot"
---



## Prerequisites

- Install Docker Desktop 4.41.0 or later
- Enable Docker Model Runner in Docker Dashboard
- Enable the TCP host socket for DMR (use the default port of 12434)
- Download a model

```json
docker model pull ai/llama3.2:1B-Q8_0 
```

## Step 1. Start the visual chatbot container


```
docker run -dp 3002:3000 -v /var/run/docker.sock:/var/run/docker.sock mikesir87/visual-chatbot
```

Did you notice that we're running the chatbot on port 3002?

## Step 2. Access the chatbot

Open your web browser and go to [http://localhost:3002](http://localhost:3002).

## Step 3. Choose the right model and LLM Backend

For this demo, select the following options:

- Docker Model Runner
- Model: `ai/llama3.2:1B-Q8_0`



Click "Save" to apply the settings.

> The system prompt currently indicates the LLM should act as a whimsical guide. 
> This suggests it will be fun and probably use lots of emojis!

## Step 4. Ask what it can do

> Enter a prompt asking "Hello! What can you do for me today?"

![first-prompt](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/visual-chatbot/images/first-chat.png)

Note that the app does not stream the responses, so it may take a little while to get the response. 
So, try to stall for time a bit (without revealing it's all running locally).

> Hooray! We have a message!

## Step 5. Click the response to see the message

Clicking on a message will provide the details of that message, which came directly from the LLM and will go back in the next API request.

![second-prompt](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/visual-chatbot/images/second-chat.png)

## Step 6. Change the system prompt

![system-prompt](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/visual-chatbot/images/system-prompt.png)

Go to `Settings -> System prompt` and change the prompt to be the `"Grumpy old man"`.



![grumpy](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/visual-chatbot/images/grumpy.png)

Before submitting, enable the `"replay messages"`. Then, press `save`.

## Step 7. Notice the very different persona

![grumpy-prompt](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/visual-chatbot/images/grumpy-prompt.png)

Highlight the much shorter and direct response from the LLM now. At the end of the day, it's the same model, but with a very different set of instructions.

This starts to introduce prompt engineering and how it's important to set the rules and the persona for the LLM. Again, normally, this is done by the GenAI application and not something an end user can change.

## Interact with the LLM for the real-time information

Reset all the messages by clicking on the "Reset messages" button in the top right corner of the chat window.

Let's ask the LLM what time it is in New York.

> Enter a prompt asking "What time is it in New York now?"

![time-query](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/visual-chatbot/images/time-query.png)

## Step 8. Adding Time Tool

Click "Add Time tool" to add a tool that will provide the current time in New York.

![add-time-tool](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/visual-chatbot/images/add-time-tool.png)

## Step 9. Ask the LLM again

Now, ask the LLM again "What time is it in New York now?".

![time-response](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/visual-chatbot/images/time-response.png)




