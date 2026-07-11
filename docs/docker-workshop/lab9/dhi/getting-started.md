---
title: "Getting Started"
---

## Prereq

- Docker Desktop installed (version 4.40 or later recommended)
- A Docker Hub account with access to a Docker organization that has DHI enabled
- Docker Scout CLI (included with Docker Desktop)

## Step 1. Mirror a DHI Node Image Repo

To use Docker Hardened Images, you first need to mirror them into your Docker Hub organization.

1. Navigate to the [Node DHI page](https://hub.docker.com) in your Docker Hub organization under **Hardened Images > Catalog > Node**.

2. Click on the **Mirror to repository** button.

3. In the pop-up dialog, set the name of the destination repository to `dhi-node`.

4. Click **Mirror**. In a few minutes, you'll see all available Node DHI tags in your `dhi-node` repository on Docker Hub.

> Mirrored repositories work like any other repository in your Docker Hub organization. You can pull, push, and manage tags as usual.

## Step 2. Login with Docker

In order to use Docker Scout to analyze the image during this lab, you will need to be logged in. Make sure that you are logged in with Docker:

```
docker login
```

You should see the following message:

```
Login Succeeded
```

If not, follow the instructions to complete the login.

## Step 3. Configure Docker Scout Organization

If your account is part of a paid organization, you may have additional output that reflects policy alignment.

```
docker scout config organization <YOUR_ORG_NAME>
```

> Throughout this workshop, replace `<YOUR_ORG_NAME>` with your actual Docker Hub organization name.

To learn more about Policy Evaluation in Docker Scout, please follow the [Docker Scout Policy guides](https://docs.docker.com/scout/policy/).

## Step 4. Clone the Demo Repository

Clone the labspace repository to follow along with the hands-on exercises:

```
git clone https://github.com/dockersamples/labspace-dhi-node.git
cd labspace-dhi-node
```

You're all set! Head over to [Image Scanning](/docker-workshop/lab9/dhi/image-scanning) to build and scan your first image.
