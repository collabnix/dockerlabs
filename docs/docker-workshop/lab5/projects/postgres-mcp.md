---
title: "Postgres Mcp"
---



![postgres-vscode](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/images/postgres-askgordon.png)

## Prerequisites

Before we start, make sure you have:

- Docker Desktop 4.41.0+ with the MCP Toolkit Extension installed
- Node.js (v18 or later) for running the frontend
- Claude Desktop installed
- Basic familiarity with Docker and JavaScript/TypeScript
- Basic SQL knowledge

## Setting Up the Sample Database

Instead of using an empty Postgres database, let's use a real example with actual data. 
We'll use a sample product catalog service:

## Step 1. Clone the sample catalog service

```
git clone https://github.com/ajeetraina/catalog-service-node
cd catalog-service-node
```

## Step 2. Start the backend services (includes Postgres with sample data)

```
docker compose up -d --build
```

This will spin up:


- A Postgres database on port 5432 with sample catalog data
- A Node.js backend service
- Sample data including products, categories, and inventory

Now let's bring up the frontend to see what data we're working with:


## Step 3. Install frontend dependencies

```
npm install
```

## Step 4. Start the development server

```
npm run dev
```

Open your browser to `http://localhost:5173 to see the catalog application. 
This gives you a visual understanding of the data structure we'll be querying with Claude.


Hit "Create Product" button and start adding the new items to your Product catalog system.

Perfect! Now we have a realistic database to work with instead of an empty one.


## Step 5. Setting up MCP Toolkit

Open Docker Desktop and navigate to the MCP Toolkit extension.
Under "MCP Server", search for "Postgres" and select the Postgres MCP Server

![postgresmcp](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/images/postgres-mcp.png)

## Step 6. Configure the Postgres MCP Server

Click "Configuration" and add the right URL for your Postgres database:

```
postgresql://postgres:postgres@host.docker.internal:5432/catalog
```

![postgresmcp](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/images/postgres-config.png)

## Step 7. Activate the Postgres MCP Server

Toggle the "Enable" switch to activate the Postgres MCP Server.

## Step 8. Configure the Claude Desktop

![claude-config](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/images/claude-config.png)

## Step 9. Configure MCP_DOCKER in Claude Desktop 

Open Claude Desktop and go to the "Settings" tab. You will see the following entry:

- Select Claude Settings
- Click on the Developer tab
- Click on the Edit Config button
- Add MCP_DOCKER to mcpServers section:

```
{
  "mcpServers": {
    "MCP_DOCKER": {
      "command": "docker",
      "args": [
        "run",
        "-i",
        "--rm",
        "alpine/socat",
        "STDIO",
        "TCP:host.docker.internal:8811"
      ]
    }
  }
}
```

## Step 10. Restart the Claude Desktop


## Step 11. Start chatting with the Postgres Database

Prompt: 

```
List out all the products in the catalog
```

![listotables](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/images/listoftables.png)






