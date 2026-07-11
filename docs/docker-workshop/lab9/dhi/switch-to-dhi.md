---
title: "Switch to DHI"
---

## Making the Switch

Switching to a Docker Hardened Image is straightforward. All we need to do is replace the base image `node:24-trixie-slim` with a DHI equivalent.

Docker Hardened Images come in two variants:

- **Dev variant** (`<YOUR_ORG_NAME>/dhi-node:24-debian13-dev`) - includes a shell and package managers, making it suitable for building and testing.
- **Runtime variant** (`<YOUR_ORG_NAME>/dhi-node:24-debian13`) - stripped down to only the essentials, providing a minimal and secure footprint for production.

This makes them perfect for use in multi-stage Dockerfiles. We can build the app in the dev image, then copy the built application into the runtime image, which will serve as the base for production.

## Step 1. Update the Dockerfile

Update the `Dockerfile` to use the DHI images:

Change the dev stage:

```dockerfile
FROM <YOUR_ORG_NAME>/dhi-node:24-debian13-dev AS dev
```

Change the production stage:

```dockerfile
FROM <YOUR_ORG_NAME>/dhi-node:24-debian13 AS prod
```

## Step 2. Non-root User (Already Built-in!)

Looking back at the output for the `scout quickview`, the `No default non-root user found` policy was not met. To resolve this we typically need to add a non-root user to the Dockerfile description. The good news is that the DHI comes with a **nonroot user built-in**, so no changes should be made.

## Step 3. Rebuild and Scan the New Image

Now let's rebuild and scan the new image:

```
docker buildx build --provenance=true --sbom=true -t <YOUR_ORG_NAME>/demo-node-dhi:v1 .
```

```
docker scout quickview <YOUR_ORG_NAME>/demo-node-dhi:v1
```

You will see similar output:

```
  Target     │  orgname/demo-node-dhi:v1          │    0C     0H     0M     0L   
    digest   │  cec31e6f0a36                      │                              
  Base image │  orgname/dhi-node:24-debian13      │                              

Policy status  SUCCESS  (9/9 policies met)

  Status │                   Policy                    │           Results            
─────────┼─────────────────────────────────────────────┼──────────────────────────────
  ✓      │ AGPL v3 licenses found                      │    0 packages                
  ✓      │ Default non-root user                       │                              
  ✓      │ No AGPL v3 licenses                         │    0 packages                
  ✓      │ No embedded secrets                         │    0 deviations              
  ✓      │ No embedded secrets (Rego)                  │    0 deviations              
  ✓      │ No fixable critical or high vulnerabilities │    0C     0H     0M     0L   
  ✓      │ No high-profile vulnerabilities             │    0C     0H     0M     0L   
  ✓      │ No unapproved base images                   │    0 deviations              
  ✓      │ Supply chain attestations                   │    0 deviations    
```

Hooray! There are zero CVEs and policy violations now!

## Step 4. Compare Image Size and Packages

Docker Scout offers a helpful command `docker scout compare` that allows you to analyze and compare two images. We'll use it to evaluate the difference in size and package footprint between `node:24-trixie-slim` and `dhi-node:24-debian13` based images.

```
docker scout compare local://<YOUR_ORG_NAME>/demo-node-dhi:v1 --to local://<YOUR_ORG_NAME>/demo-node-doi:v1
```

Scroll up the output and you will see a similar summary:

```
## Overview
  
                      │               Analyzed Image                │              Comparison Image                
  ────────────────────┼─────────────────────────────────────────────┼──────────────────────────────────────────────
    Target            │  local://orgname/demo-node-dhi:v1           │  local://orgname/demo-node-doi:v1   
      digest          │  e5b9ec7a980c                               │  66cb8da420d8                                
      tag             │  v1                                         │  v1                                          
      platform        │ linux/arm64                                 │ linux/arm64                                  
      vulnerabilities │    0C     0H     0M     8L                  │    0C     2H     2M    20L                   
                      │           -2     -2    -20                  │                                              
      size            │ 59 MB (-40 MB)                              │ 97 MB                                       
      packages        │ 648 (-214)                                  │ 858                                          
                      │                                             │                                              
    Base image        │  orgname/dhi-node:24                        │  node:24-trixie-slim                         
      vulnerabilities │    0C     0H     0M     0L                  │    0C     1H     2M    20L                   
```

As you can see, the `dhi-node:24-debian13`–based image is **40 MB (around 40%) smaller**, contains **214 fewer packages**, and has nearly **zero CVEs** compared to the original `node:24-trixie-slim`–based image.

## Step 5. Validate the Application

Last but not least, after migrating to a DHI base image, we should verify that the application still functions as expected.

Start the app:

```
docker run --rm -d --name demo-node -p 3005:3000 <YOUR_ORG_NAME>/demo-node-dhi:v1
```

Open your browser and navigate to [http://localhost:3005](http://localhost:3005) to validate that the app is up and running.

Then stop the container:

```
docker stop demo-node
```
