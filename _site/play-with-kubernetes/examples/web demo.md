# Demonstrating Web Demo Test on Kubernetes Powered Docker for Mac 17.12 Platform

# Starting up with Clean System

```
Ajeets-MacBook-Air:example1 ajeetraina$ kubectl get pods
No resources found.
Ajeets-MacBook-Air:example1 ajeetraina$ kubectl get deployment
No resources found.
Ajeets-MacBook-Air:example1 ajeetraina$ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   2d
Ajeets-MacBook-Air:example1 ajeetraina$ 
Ajeets-MacBook-Air:example1 ajeetraina$
```

# Creating webdemo.yml as shown below:

```
apiVersion: v1
kind: Pod
metadata:
  name: collabweb
spec:
  containers:
  - name: webnix
    image: ajeetraina/webdemo
    ports:
      - containerPort: 8080
 ```
 
 # Launching a pod using the container image ajeetraina/webdemo and exposing a HTTP API on port 8080
 
 ```
 $kubectl create -f webdemo.yml
 ```
 
 # Getting Pods Information
 
 ```
 
 Ajeets-MacBook-Air:example1 ajeetraina$ kubectl get pods
NAME        READY     STATUS    RESTARTS   AGE
collabweb   1/1       Running   0          48s
```

# Getting More Details

```
Ajeets-MacBook-Air:example1 ajeetraina$ kubectl describe pod collabweb 
Name:         collabweb
Namespace:    default
Node:         docker-for-desktop/192.168.65.3
Start Time:   Mon, 15 Jan 2018 12:09:02 +0530
Labels:       <none>
Annotations:  <none>
Status:       Running
IP:           10.1.0.42
Containers:
  webnix:
    Container ID:   docker://5e429a30c4648f2564ccc145c8a0fc5d7160f24a9358d4ee979ac3f4254b711f
    Image:          ajeetraina/webdemo
    Image ID:       docker-pullable://ajeetraina/webdemo@sha256:5fddb01a372b02ec2d49465a920eda0f864b9b71ac75032fcbeeba028764bcd8
    Port:           8080/TCP
    State:          Running
      Started:      Mon, 15 Jan 2018 12:09:12 +0530
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-4v6r8 (ro)
Conditions:
  Type           Status
  Initialized    True 
  Ready          True 
  PodScheduled   True 
Volumes:
  default-token-4v6r8:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-4v6r8
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.alpha.kubernetes.io/notReady:NoExecute for 300s
                 node.alpha.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason                 Age   From                         Message
  ----    ------                 ----  ----                         -------
  Normal  Scheduled              1m    default-scheduler            Successfully assigned collabweb to docker-for-desktop
  Normal  SuccessfulMountVolume  1m    kubelet, docker-for-desktop  MountVolume.SetUp succeeded for volume "default-token-4v6r8"
  Normal  Pulling                1m    kubelet, docker-for-desktop  pulling image "ajeetraina/webdemo"
  Normal  Pulled                 1m    kubelet, docker-for-desktop  Successfully pulled image "ajeetraina/webdemo"
  Normal  Created                1m    kubelet, docker-for-desktop  Created container
  Normal  Started                1m    kubelet, docker-for-desktop  Started container
```

# Fetching the Pod IP

```
Ajeets-MacBook-Air:example1 ajeetraina$ kubectl describe pod collabweb | grep IP:
IP:           10.1.0.42
Ajeets-MacBook-Air:example1 ajeetraina$
```

# Creating a Deployment
 
```
$kubectl run webdemo --image=ajeetraina/webdemo --port=8080 
```

# Verifying the Deployment

```
kubectl get deployment webdemo -o wide

```
 # Fetching the deployment details
 ```

Ajeets-MacBook-Air:example1 ajeetraina$ kubectl get deployment -o wide
NAME      DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE       CONTAINERS   IMAGES               SELECTOR
webdemo   1         1         1            1           7h        webdemo      ajeetraina/webdemo   run=webdemo

 ```
 
 # Exposing the pods for accessing it through Browser
 
 Exposing your pods to the internet.


 ```
 kubectl expose deployment webdemo --port=8080 --type=NodePort
 ```
 
 This should print the service that has been created, and 
 map an external IP address to the service. Where to find this external IP address will depend on the environment you run in. 
 
 For instance, for Google Compute Engine the external IP address is listed as part of the newly created service and 
 can be retrieved by running the below command:
 
 ```
kubectl get services
```

In our case, Let's run the below command:

```
Ajeets-MacBook-Air:example1 ajeetraina$ kubectl get services
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)          AGE
kubernetes   ClusterIP   10.96.0.1      <none>        443/TCP          2d
webdemo      NodePort    10.99.125.85   <none>        8080:30990/TCP   5m

```

Now we should be able to access the Webdemo Test Page using the below command:
```

Ajeets-MacBook-Air:example1 ajeetraina$ curl localhost:30990
<h1>Web Test engine</h1>
<ul>
  <li>
    <code>Content-Type</code>
    <ul>
      <li>
        <a href='/type/text'>text</a>
        &mdash;
        <code>Welcome to Collabnix</code>
      </li>
      <li>
        <a href='/type/html'>html</a>
        &mdash;
        <code>&lt;h1&gt;Docker, Kubernetes &amp; Cloud!&lt;/h1&gt;</code>
      </li>
      <li>
        <a href='/type/json'>json</a>
        &mdash;
        <code>{&quot;message&quot;:&quot;Hello JSON World!&quot;}</code>
      </li>
    </ul>
  </li>
  <li>
    HTTP Status Codes
    <ul>
      <li>
        <a href='/code/400'>400 &mdash; Bad Request</a>
      </li>
      <li>
        <a href='/code/401'>401 &mdash; Unauthorized</a>
      </li>
      <li>
        <a href='/code/403'>403 &mdash; Forbidden</a>
      </li>
      <li>
        <a href='/code/404'>404 &mdash; Not Found</a>
      </li>
      <li>
        <a href='/code/405'>405 &mdash; Method Not Allowed</a>
      </li>
      <li>
        <a href='/code/406'>406 &mdash; Not Acceptable</a>
      </li>
      <li>
        <a href='/code/418'>418 &mdash; I'm a teapot (RFC 2324)</a>
      </li>
    </ul>
  </li>
</ul>
<h1>README</h1>
<h2>Web Demo Docker Container</h2>

<p>A container with a simple web server for testing web connections with.</p>

<p>To run it use:</p>

<pre><code>docker run --rm -p 8080:8080 ajeetraina/webdemo
</code></pre>

<h3>Source</h3>

```

In order to access your nginx landing page, you also have to make sure that traffic from external IPs is allowed. Do this by opening a firewall to allow traffic on port 80.
 
 ```
 Ajeets-MacBook-Air:~ ajeetraina$ docker ps | head -n 2
CONTAINER ID        IMAGE                                                    COMMAND                  CREATED             STATUS              PORTS                    NAMES
eb6312309518        ajeetraina/webdemo                                       "ruby webtest.rb -p …"   9 hours ago         Up 9 hours                                   k8s_webdemo_webdemo-85f56bc5d5-np9qh_default_eae29f0d-f9bf-11e7-994c-025000000001_0
Ajeets-MacBook-Air:~ ajeetraina$ docker exec -it eb631 ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
2: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN group default qlen 1
    link/ipip 0.0.0.0 brd 0.0.0.0
3: ip6tnl0@NONE: <NOARP> mtu 1452 qdisc noop state DOWN group default qlen 1
    link/tunnel6 :: brd ::
5: eth0@if36: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
    link/ether 0a:58:0a:01:00:2b brd ff:ff:ff:ff:ff:ff
    inet 10.1.0.43/16 scope global eth0
       valid_lft forever preferred_lft forever
Ajeets-MacBook-Air:~ ajeetraina$ 
 ```
 =============================
 
# Building By Type: Deployment if we want replicas of the same container     

It creates a ReplicaSet to bring up three nginx Pods:
```
apiVersion: apps/v1 # for versions before 1.9.0 use apps/v1beta2
kind: Deployment
metadata:
  name: nginx-deployment
  labels:
    app: nginx
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.7.9
        ports:
        - containerPort: 80
  ```      
        
 # What does the above deployment.yaml mean?
    
A Deployment named nginx-deployment is created, indicated by the metadata: name field.
The Deployment creates three replicated Pods, indicated by the replicas field.
The selector field defines how the Deployment finds which Pods to manage. 
In this case, we simply select on one label defined in the Pod template (app: nginx). 
However, more sophisticated selection rules are possible, as long as the Pod template itself satisfies the rule.
The Pod template’s specification, or template: spec field, indicates that the Pods run one container, nginx, 
which runs the nginx Docker Hub image at version 1.7.9.

The Deployment opens port 80 for use by the Pods.
Note: matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is “key”, the operator is “In”, and the values array contains only “value”. The requirements are ANDed.
The template field contains the following instructions:
The Pods are labeled app: nginx
Create one container and name it nginx.
Run the nginx image at version 1.7.9.
Open port 80 so that the container can send and accept traffic.

# Creating Deployment

```
$kubectl create -f webdemo.yml

To see the ReplicaSet (rs) created by the deployment, run kubectl get rs:
NAME                          DESIRED   CURRENT   READY   AGE
nginx-deployment-2035384211   3         3         3       18s

```
