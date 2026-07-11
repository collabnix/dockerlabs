---
title: "GitHub MCP + Claude Desktop"
---



Let’s see how to use GitHub MCP Server using Claude Desktop in the following steps:

## Prerequisite

- Docker Desktop
- MCP Toolkit Enabled
- GitHub Account
- Claude Desktop installed on your system

## Step 1: Create a GitHub Personal Access Token (PAT)


- Go to GitHub.com and sign in to your account
- Click your profile picture in the top-right corner
- Select "Settings"
- Scroll down to "Developer settings" in the left sidebar
- Click on "Personal access tokens" → "Tokens (classic)"
- Click "Generate new token" → "Generate new token (classic)"
- Give your token a descriptive name like "Docker MCP GitHub Access"
- Select the following scopes (permissions):
 - repo (Full control of private repositories)
 - workflow (if you need workflow actions)
 - read:org (if you need organization access)
- Click "Generate token"

## Step 2: Configure the GitHub MCP Server in Docker

- Open Docker Desktop
- Navigate to the MCP Server
- Find the GitHub (official) card and click on it to expand details.

<img width="1164" height="594" alt="image" src="https://github.com/user-attachments/assets/116b32c8-ceae-40e4-a19a-448555e24142" />


Alternatively, you can even set it up using `docker mcp` CLI as shown below: 

In your terminal, set up the GitHub token as a secret:

```
docker mcp secret set GITHUB.PERSONAL_ACCESS_TOKEN=github_pat_YOUR_TOKEN_HERE
```

For example:

```
docker mcp secret set GITHUB.PERSONAL_ACCESS_TOKEN=github_pat_XXXXMRCAXXXXXXxEp_QRZW43Wo1k6KYWwDXXXXXXXXGPXLZ7EGEnse82YM
Info: No policy specified, using default policy
```

## Step 3. Configure Claude Desktop

Open MCP Client > Click "Connect"

<img width="1006" height="471" alt="image" src="https://github.com/user-attachments/assets/671e31df-f207-4fb8-99b1-491a0ada0410" />

## Step 4. Restart the Claude Desktop

<img width="1201" height="678" alt="image" src="https://github.com/user-attachments/assets/73e4fad6-5e37-46e2-b39b-ed589feb588a" />

```
{
  "mcpServers":{
       "MCP_DOCKER":
          {
            "command":
                "docker",
                     "args":["mcp","gateway","run"]
       }
   }
}
```


## Step 5. Verify if MCP_DOCKER gets added to the Claude Desktop

<img width="832" height="506" alt="image" src="https://github.com/user-attachments/assets/38a11cf0-e531-44fc-b0ae-c3d7156c7af0" />


## Step 6. Start chatting with your GitHub repository

<img width="767" height="550" alt="image" src="https://github.com/user-attachments/assets/ca63daf9-a0b5-4844-a082-128556cbdd39" />


