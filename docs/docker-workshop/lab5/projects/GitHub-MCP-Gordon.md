---
title: "GitHub MCP + Gordon"
---


![gordon-github](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/images/gordon-github.png)

Let’s see how to use GitHub MCP Server using Gordon as well as Claude Desktop in the following steps:

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
- Find the GitHub tool (official) card and click on it to expand details.

![githubrefernece](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/images/github-reference.png)

In your terminal, set up the GitHub token as a secret:

```
docker mcp secret set GITHUB.PERSONAL_ACCESS_TOKEN=github_pat_YOUR_TOKEN_HERE
```

For example:

```
docker mcp secret set GITHUB.PERSONAL_ACCESS_TOKEN=github_pat_11AACMRCAXXXXXXxEp_QRZW43Wo1k6KYWwDXXXXXXXXGPXLZ7EGEnse82YM
Info: No policy specified, using default policy
```


If you have enabled Ask Gordon and enabled MCP Catalog (as shown in the following screenshot), then you can use docker ai command to play around with your GitHub repository.

![askgordon](https://github.com/ajeetraina/docker-workshop/tree/main/docs/lab5/projects/images/askgordon.png)



Run the following docker ai command to create a new repository on your GitHub repo directly.


```
docker ai "create a repo called modelorbital on my github repo"

    • Calling create_repository...

The repository "modelorbital" has been created on your GitHub account. You can access it here: https://github.com/username/modelorbital

Let me know if you need help with anything else!
```

This looks great! We've successfully used Docker AI to create a new GitHub repository called "modelorbital" on your GitHub account.
