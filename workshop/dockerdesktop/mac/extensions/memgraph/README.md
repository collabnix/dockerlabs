# Memgraph Docker Extension

Memgraph is a streaming graph application platform that helps you wrangle your streaming data, build sophisticated models you can query in real-time, and develop applications you never thought possible within a couple of days, not months. With Memgraph Docker Extension, now you can setup Memgraph platform in no seconds.


<img width="1492" alt="image" src="https://user-images.githubusercontent.com/313480/208896008-6d0d40ce-65e3-4074-86bc-7926ceb03da0.png">





## Getting Started

If you're in hurry, [click here](https://open.docker.com/extensions/marketplace?extensionId=ajeetraina/memgraph-docker-extension&tag=latest) to deploy it on Docker Desktop.

## Prerequisite

- Docker Desktop 4.8+

## Building the Extension locally

### Clone the repo

```
 git clone https://github.com/collabnix/memgraph-docker-extension
```

### Build the Extension

```
 cd memgraph-docker-extension
 make build-extension
```

### Install the Extension

```
 docker extension install ajeetraina/memgraph-docker-extension:latest
```

### Accessing the Extension

Open Docker Dashboard > Extension > Memgraph

Load the Pandora Papers data and see how to access it via Memgraph.

<img width="1501" alt="image" src="https://user-images.githubusercontent.com/313480/208895248-d8aee07e-8bb5-4a04-9378-327a03114fa8.png">
