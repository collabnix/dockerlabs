# Swarm CLI to Deploy Application on Kubernetes Cluster on Docker Desktop Community Edition for MacOS

## Pre-requisite:

- Install Docker Desktop 2.0.1.0 for Mac
- Enable Kubernetes under Preference UI


## Steps to follow

## Verify Docker Version

```
[Captains-Bay]🚩 >  docker version
Client: Docker Engine - Community
 Version:           18.09.1
 API version:       1.39
 Go version:        go1.10.6
 Git commit:        4c52b90
 Built:             Wed Jan  9 19:33:12 2019
 OS/Arch:           darwin/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.1
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       4c52b90
  Built:            Wed Jan  9 19:41:49 2019
  OS/Arch:          linux/amd64
  Experimental:     true
 Kubernetes:
  Version:          v1.13.0
  StackAPI:         v1beta2
  ```

## Overriding Orchestration

Use the DOCKER_STACK_ORCHESTRATOR variable to override the default orchestrator for a given terminal session or a single Docker command. 
This variable can be unset (the default, in which case Kubernetes is the orchestrator) or set to swarm or kubernetes. 
The following command overrides the orchestrator for a single deployment, by setting the variable at the start of the command itself.

```
DOCKER_STACK_ORCHESTRATOR=swarm docker stack deploy -c docker-compose1.yml myapp2
```

```
[Captains-Bay]🚩 >  docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
ety51y7hfwfi        myapp2_db1          replicated          2/2                 nginx:alpine
9vkik71wtfox        myapp2_web1         replicated          3/3                 nginx:alpine        *:8083->80/tcp
```

## Scale the Web Services to 5 replicas

```
docker service scale myapp2_web1=5
myapp2_web1 scaled to 5
overall progress: 5 out of 5 tasks
1/5: running
2/5: running
3/5: running
4/5: running
5/5: running
verify: Service converged
```

## Verifying Final List of Replicas

```
docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
ety51y7hfwfi        myapp2_db1          replicated          2/2                 nginx:alpine
9vkik71wtfox        myapp2_web1         replicated          5/5                 nginx:alpine        *:8083->80/tcp
```

