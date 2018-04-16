# Demo #1: How to Build Kubernetes Cluster using Swarm CLI

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
