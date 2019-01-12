# Swarm CLI to Deploy Application on Kubernetes Cluster on Docker Desktop Community Edition for MacOS

## Pre-requisite:

- Install Docker Desktop 2.0.1.0 for Mac


## Steps to follow

## Overriding Orchestration

Use the DOCKER_STACK_ORCHESTRATOR variable to override the default orchestrator for a given terminal session or a single Docker command. 
This variable can be unset (the default, in which case Kubernetes is the orchestrator) or set to swarm or kubernetes. 
The following command overrides the orchestrator for a single deployment, by setting the variable at the start of the command itself.

```
DOCKER_STACK_ORCHESTRATOR=swarm docker stack deploy -c docker-compose1.yml myapp2
```

