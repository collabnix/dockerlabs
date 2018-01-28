# Demo Tutorial for Docker Stack Deploy & Kubernetes

# Pre-Requisite

## Clone the Repository

```
$git clone https://github.com/ajeetraina/docker101

```

## Change to the right location

```
$cd docker101/play-with-kubernetes/examples/stack-deploy-on-mac/

```

# Example-1 : Demonstrating a Simple Web Application


## Building the Web Application Stack

```
$docker stack deploy -c docker-stack1.yml myapp1

```

## Verifying the Stack

```
$docker stack ls
```

## Verifying using Kubectl

```
$kubectl get pods
```

## Verifying if the web application is accessible

```
$curl localhost:8083
```

## Cleaning up the Stack

```
$docker stack rm myapp`
```

# Example:2 - Demonstrating ReplicaSet

