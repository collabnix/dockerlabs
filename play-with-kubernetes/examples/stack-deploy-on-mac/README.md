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


## Building the Web Application Stack

```
$docker stack deploy -c docker-stack2.yml myapp2

```

## Verifying the Stack

```
$docker stack ls
```


## Verifying using Kubectl

```
$kubectl get pods
```

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get stacks
NAME      AGE
myapp2    22m
```


```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get pods
NAME                    READY     STATUS    RESTARTS   AGE
db1-d977d5f48-l6v9d     1/1       Running   0          22m
db1-d977d5f48-mpd25     1/1       Running   0          22m
web1-6886bb478f-s7mvz   1/1       Running   0          22m
web1-6886bb478f-wh824   1/1       Running   0          22m
```

```
Ajeets-MacBook-Air:testenviron ajeetraina$ kubectl get stacks myapp2 -o yaml
apiVersion: compose.docker.com/v1beta2
kind: Stack
metadata:
  creationTimestamp: 2018-01-28T02:55:28Z
  name: myapp2
  namespace: default
  resourceVersion: "3186"
  selfLink: /apis/compose.docker.com/v1beta2/namespaces/default/stacks/myapp2
  uid: b25bf776-03d6-11e8-8d4c-025000000001
spec:
  stack:
    Configs: {}
    Networks: {}
    Secrets: {}
    Services:
    - Build:
        Args: null
        CacheFrom: null
        Context: ""
        Dockerfile: ""
        Labels: null
        Network: ""
        Target: ""
      CapAdd: null
      CapDrop: null
      CgroupParent: ""
      Command: null
      Configs: null
      ContainerName: ""
      CredentialSpec:
        File: ""
        Registry: ""
      DNS: null
      DNSSearch: null
      DependsOn: null
      Deploy:
        EndpointMode: ""
        Labels: null
        Mode: ""
        Placement:
          Constraints: null
          Preferences: null
        Replicas: 2
        Resources:
          Limits: null
          Reservations: null
        RestartPolicy: null
        UpdateConfig: null
      Devices: null
      DomainName: ""
      Entrypoint: null
      EnvFile: null
      Environment: {}
      Expose: null
      ExternalLinks: null
      ExtraHosts: null
      HealthCheck: null
      Hostname: ""
      Image: nginx:alpine
      Ipc: ""
      Isolation: ""
      Labels: null
      Links: null
      Logging: null
      MacAddress: ""
      Name: db1
      NetworkMode: ""
      Networks: null
      Pid: ""
      Ports: null
      Privileged: false
      ReadOnly: false
      Restart: ""
      Secrets: null
      SecurityOpt: null
      StdinOpen: false
      StopGracePeriod: null
      StopSignal: ""
      Tmpfs: null
      Tty: false
      Ulimits: null
      User: ""
      Volumes: null
      WorkingDir: ""
    - Build:
        Args: null
        CacheFrom: null
        Context: ""
        Dockerfile: ""
        Labels: null
        Network: ""
        Target: ""
      CapAdd: null
      CapDrop: null
      CgroupParent: ""
      Command: null
      Configs: null
      ContainerName: ""
      CredentialSpec:
        File: ""
        Registry: ""
      DNS: null
      DNSSearch: null
      DependsOn: null
      Deploy:
        EndpointMode: ""
        Labels: null
        Mode: ""
        Placement:
          Constraints: null
          Preferences: null
        Replicas: 2
        Resources:
          Limits: null
          Reservations: null
        RestartPolicy: null
        UpdateConfig: null
      Devices: null
      DomainName: ""
      Entrypoint: null
      EnvFile: null
      Environment: {}
      Expose: null
      ExternalLinks: null
      ExtraHosts: null
      HealthCheck: null
      Hostname: ""
      Image: nginx:alpine
      Ipc: ""
      Isolation: ""
      Labels: null
      Links: null
      Logging: null
      MacAddress: ""
      Name: web1
      NetworkMode: ""
      Networks: null
      Pid: ""
      Ports:
      - Mode: ingress
        Protocol: tcp
        Published: 8083
        Target: 80
      Privileged: false
      ReadOnly: false
      Restart: ""
      Secrets: null
      SecurityOpt: null
      StdinOpen: false
      StopGracePeriod: null
      StopSignal: ""
      Tmpfs: null
      Tty: false
      Ulimits: null
      User: ""
      Volumes: null
      WorkingDir: ""
    Volumes: {}
status:
  message: Stack is started
  phase: Available
  ```


## Verifying if the web application is accessible

```
$curl localhost:8083
```

## Cleaning up the Stack

```
$docker stack rm myapp2
```
