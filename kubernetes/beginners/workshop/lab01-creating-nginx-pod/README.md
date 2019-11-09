# Creating Nginx Pod using Pod Manifest File

In our last workshop, we created a Pod directly using kubectl. Under this section, we will use Pod manifest file instead. We will see how to expose nginx pod to port 8080.

```
kubectl create -f nginx-pod.yaml
```

```
[node1 lab01-creating-nginx-pod]$ kubectl apply -f nginx-pod.yaml
pod/nginx-pod created
```

```
[node1 lab01-creating-nginx-pod]$ kubectl get po,svc,deploy
NAME            READY   STATUS              RESTARTS   AGEpod/nginx-pod   0/1     ContainerCreating   0          8s
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   76m
[node1 lab01-creating-nginx-pod]$
```

```
[node1 lab01-creating-nginx-pod]$ kubectl describe po nginx-pod
Name:               nginx-pod
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               node2/192.168.0.7
Start Time:         Sun, 30 Jun 2019 01:14:49 +0000
Labels:             name=nginx-pod
Annotations:        kubectl.kubernetes.io/last-applied-configuration:
                      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"labels":{"name":"nginx-pod"},"name":"nginx-pod","namespace":"default"},"spec...
Status:             Running
IP:                 10.44.0.1
Containers:
  nginx:
    Container ID:   docker://ba2f8aafc79fcdbdcb2c77a7f6f268a05be75a9f8430d3f05d1b536306de3663
    Image:          nginx:latest
    Image ID:       docker-pullable://nginx@sha256:bdbf36b7f1f77ffe7bd2a32e59235dff6ecf131e3b6b5b96061c652f30685f3a
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Sun, 30 Jun 2019 01:14:58 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-jrm8k (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  default-token-jrm8k:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-jrm8k
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  13m   default-scheduler  Successfully assigned default/nginx-pod to node2
  Normal  Pulling    13m   kubelet, node2     Pulling image "nginx:latest"
  Normal  Pulled     13m   kubelet, node2     Successfully pulled image "nginx:latest"
  Normal  Created    13m   kubelet, node2     Created container nginx
  Normal  Started    13m   kubelet, node2     Started container nginx
  ```


## Get the list of pod:

```
$ kubectl get pods
	NAME        READY     STATUS    RESTARTS   AGE
	nginx-pod   1/1       Running   0          22s
```

##  Create a Deployment

Say, we need to create 3 instances of NGINX image.

Run the following command to create Deployment:

	
```
$ kubectl create -f nginx-deployment.yaml 
```

```
[node1 ~]$ kubectl get po,svc,deploy
NAME                                   READY     STATUS    RESTARTS   AGE
pod/nginx-deployment-84bfcbdd5-2256x   1/1       Running   0          3m
pod/nginx-deployment-84bfcbdd5-2dcn6   1/1       Running   0          3m
pod/nginx-deployment-84bfcbdd5-sqrjz   1/1       Running   0          3m
pod/nginx-pod                          1/1       Running   0          9m

NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE
service/kubernetes         ClusterIP   10.96.0.1        <none>        443/TCP   19m
service/my-nginx           ClusterIP   10.104.151.230   <none>        80/TCP    13m
service/nginx-deployment   ClusterIP   10.99.154.211    <none>        80/TCP    2m

NAME                                     DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/nginx-deployment   3         3         3            3           3m
[node1 ~]$
```


## Verify that the pod came up fine:

```
kubectl -n default port-forward $(kubectl -n default get pod -l name=nginx-pod -o jsonpath='{.items[0].metadata.name}') 8080:80 & open http://localhost:8080/
```

This opens up a browser window and shows the NGINX main page:

If the containers in the pod generate logs, then they can be seen using the command shown:

```
$ kubectl logs nginx-pod
	127.0.0.1 - - [03/Nov/2017:17:33:30 +0000] "GET / HTTP/1.1" 200 612 "-" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36" "-"
	127.0.0.1 - - [03/Nov/2017:17:33:32 +0000] "GET /favicon.ico HTTP/1.1" 404 571 "http://localhost:8080/" "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_12_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36" "-"
	2017/11/03 17:33:32 [error] 5#5: *2 open() "/usr/share/nginx/html/favicon.ico" failed (2: No such file or directory), client: 127.0.0.1, server: localhost, request: "GET /favicon.ico HTTP/1.1", host: "localhost:8080", referrer: "http://localhost:8080/"
```

## Delete a Pod

Delete the pod as shown below:

```
$ kubectl delete -f templates/pod.yaml
```
