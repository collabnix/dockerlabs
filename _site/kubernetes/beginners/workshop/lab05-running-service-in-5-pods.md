# Creating a service for an application running in five pods

Run a Hello World application in your cluster:

```
kubectl run hello-world --replicas=5 --labels="run=load-balancer-example" --image=gcr.io/google-samples/node-hello:1.0  --port=8080
```

The preceding command creates a Deployment object and an associated ReplicaSet object. 
The ReplicaSet has five Pods, each of which runs the Hello World application.

## Display information about the Deployment:

```
kubectl get deployments hello-world
kubectl describe deployments hello-world
```

## Display information about your ReplicaSet objects:

```
kubectl get replicasets
kubectl describe replicasets
```

## Create a Service object that exposes the deployment:

```
kubectl expose deployment hello-world --type=LoadBalancer --name=my-service
```

## Display information about the Service:

```
kubectl get services my-service
```

The output is similar to this:

```
NAME         CLUSTER-IP     EXTERNAL-IP      PORT(S)    AGE
my-service   10.3.245.137   104.198.205.71   8080/TCP   54s
```

Note: If the external IP address is shown as \<pending>, wait for a minute and enter the same command again.

## Display detailed information about the Service:

```
kubectl describe services my-service
```

The output is similar to this:

```
Name:           my-service
Namespace:      default
Labels:         run=load-balancer-example
Selector:       run=load-balancer-example
Type:           LoadBalancer
IP:             10.3.245.137
LoadBalancer Ingress:   104.198.205.71
Port:           <unset> 8080/TCP
NodePort:       <unset> 32377/TCP
Endpoints:      10.0.0.6:8080,10.0.1.6:8080,10.0.1.7:8080 + 2 more...
Session Affinity:   None
Events:
```

Make a note of the external IP address exposed by your service. In this example, the external IP address is 104.198.205.71. Also note the value of Port. In this example, the port is 8080.

In the preceding output, you can see that the service has several endpoints: 10.0.0.6:8080,10.0.1.6:8080,10.0.1.7:8080 + 2 more. These are internal addresses of the pods that are running the Hello World application. To verify these are pod addresses, enter this command:

```
kubectl get pods --output=wide
```

The output is similar to this:

```
NAME                         ...  IP         NODE
hello-world-2895499144-1jaz9 ...  10.0.1.6   gke-cluster-1-default-pool-e0b8d269-1afc
hello-world-2895499144-2e5uh ...  0.0.1.8    gke-cluster-1-default-pool-e0b8d269-1afc
hello-world-2895499144-9m4h1 ...  10.0.0.6   gke-cluster-1-default-pool-e0b8d269-5v7a
hello-world-2895499144-o4z13 ...  10.0.1.7   gke-cluster-1-default-pool-e0b8d269-1afc
hello-world-2895499144-segjf ...  10.0.2.5   gke-cluster-1-default-pool-e0b8d269-cpuc
```

Use the external IP address to access the Hello World application:

```
curl http://<external-ip>:<port>
```

where <external-ip> is the external IP address of your Service, and <port> is the value of Port in your Service description.

The response to a successful request is a hello message:

Hello Kubernetes!
