# Deploy Application on Kubernetes Cluster using Compose on Kubernetes running on Docker Desktop 2.0.1.0 for Mac


Kubernetes is available in Docker for Mac 17.12 CE Edge and higher, and 18.06 Stable and higher , this includes a standalone Kubernetes server and client, as well as Docker CLI integration. The Kubernetes server runs locally within your Docker instance, is not configurable, and is a single-node cluster.

The Kubernetes server runs within a Docker container on your local system, and is only for local testing. When Kubernetes support is enabled, you can deploy your workloads, in parallel, on Kubernetes, Swarm, and as standalone containers. Enabling or disabling the Kubernetes server does not affect your other workloads.

Under this tutorial, we will see how Docker Stack Controller can be used to run Apps on Swarm as well as Kubernetes.


# Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Docker Desktop Community for Mac</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisites:

- Install Docker Desktop 2.0.1.0 for Mac
- Enable Kubernetes under Preference UI

![My Image](https://github.com/collabnix/dockerlabs/blob/master/kubernetes/Intermediate/dockerdesktop1.png)

## Scenario #1: Demonstrating Swarm as Orchestrator

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
DOCKER_STACK_ORCHESTRATOR=swarm docker stack deploy -c docker-compose.yml myapp2
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

## Cleaning Up

You can use ```docker service rm myapp2_db1 myapp2_web1``` to clean up services, though I was expecting it being done directly via `docker stack rm myapp1`.

## Scenarios:2 


## Verifying Kubectl

```
[Captains-Bay]🚩 >  kubectl version
Client Version: version.Info{Major:"1", Minor:"8", GitVersion:"v1.8.6", GitCommit:"6260bb08c46c31eea6cb538b34a9ceb3e406689c", GitTreeState:"clean", BuildDate:"2017-12-21T06:34:11Z", GoVersion:"go1.8.3", Compiler:"gc", Platform:"darwin/amd64"}
Server Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.0", GitCommit:"ddf47ac13c1a9483ea035a79cd7c10005ff21a6d", GitTreeState:"clean", BuildDate:"2018-12-03T20:56:12Z", GoVersion:"go1.11.2", Compiler:"gc", Platform:"linux/amd64"}
```

## Verifying Kubernetes Nodes

```
[Captains-Bay]🚩 >  kubectl get nodes
NAME             STATUS    ROLES     AGE       VERSION
docker-desktop   Ready     master    17h       v1.13.0
[Captains-Bay]🚩 >
```

## Deploying the Apps

```
[Captains-Bay]🚩 >  docker stack deploy -c docker-compose1.yml myapp1
Waiting for the stack to be stable and running...
db1: Ready		[pod status: 1/2 ready, 1/2 pending, 0/2 failed]
web1: Ready		[pod status: 1/3 ready, 2/3 pending, 0/3 failed]

Stack myapp1 is stable and running
```

## Verifying App Stack

```
[Captains-Bay]🚩 >  docker stack ls
NAME                SERVICES            ORCHESTRATOR        NAMESPACE
myapp1              2                   Kubernetes          default
```

```
[Captains-Bay]🚩 >  kubectl get all
NAME          AGE
deploy/db1    13s
deploy/web1   13s

NAME                 AGE
rs/db1-6cf565f7cc    13s
rs/web1-69c7f5d64b   13s

NAME                       READY     STATUS    RESTARTS   AGE
po/db1-6cf565f7cc-p49bp    1/1       Running   0          13s
po/db1-6cf565f7cc-z9lnw    1/1       Running   0          13s
po/web1-69c7f5d64b-jhwgh   1/1       Running   0          13s
po/web1-69c7f5d64b-pmx79   1/1       Running   0          13s
po/web1-69c7f5d64b-x7r7b   1/1       Running   0          13s

NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
svc/db1              ClusterIP      None            <none>        55555/TCP        13s
svc/kubernetes       ClusterIP      10.96.0.1       <none>        443/TCP          17h
svc/web1             ClusterIP      None            <none>        55555/TCP        13s
svc/web1-published   LoadBalancer   10.101.67.167   localhost     8083:32350/TCP   13s
[Captains-Bay]🚩 >
```
