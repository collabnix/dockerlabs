# Demonstrating K8s powered Docker for Mac 

## Demo-1: Using Docker Stack to build Kubernetes Cluster

### Verifying the current Orchestrator

```
docker version
```

```
docker stack deploy -c docker-compose.yml stack1
```

## Verifying

```
docker stack ls
```

## To confirm that it is K8s cluster and NOT Swarm

```
kubectl get po,svc,deploy
```

```
DOCKER_ORCHESTRATOR=swarm docker swarm init
DOCKER_OCHESTRATOR=swarm docker service ls
```
No Swarm services has been running.

# Accessing the WebPage

```
open http://localhost:8082
```




