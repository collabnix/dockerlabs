# Demo #1: How to Build Your First Kubernetes Cluster using Swarm CLI

## Pre-requisite

- Docker 18.04 CE running on your MacOS
- Kubernetes up and running

## Clone this Repository

```
git clone https://github.com/ajeetraina/docker101/
```

## Change to the right directory

```
cd docker101/for-mac/kubernetes/demo1/
```

## Use Stack Deploy to bring up K8s Cluster

```
docker stack deploy -c docker-compose.yml collabme
```

## Verifying through Kubectl

```kubectl get stack
NAME       AGE
collabme   10h
```

## Verifying using Swarm CLI

```
docker stack ls
NAME                SERVICES
collabme            2
```

## Detailed Stack Info

```
kubectl describe  stacks collabme
Name:         collabme
Namespace:    default
Labels:       <none>
Annotations:  <none>
API Version:  compose.docker.com/v1beta2
Kind:         Stack
Metadata:
  Creation Timestamp:  2018-04-15T16:27:58Z
  Resource Version:    66697
  Self Link:           /apis/compose.docker.com/v1beta2/namespaces/default/stacks/collabme
  UID:                 f5b72aa8-40c9-11e8-942e-025000000001
Spec:
  Services:
    Deploy:
      Placement:
      Resources:
    Image:  nginx:alpine
    Name:   db1
    Deploy:
      Placement:
      Resources:
    Image:  nginx:alpine
    Name:   web1
    Ports:
      Mode:       ingress
      Protocol:   tcp
      Published:  8082
      Target:     80
Status:
  Message:  Stack is started
  Phase:    Available
Events:     <none>
```

## Verifying if Nginx is Up and running
```
 curl localhost:8082
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
```
