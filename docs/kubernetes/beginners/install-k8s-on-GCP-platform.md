# Installing Kubernetes on GCP Platform from Scratch

## Pre-requisite:

- GCP Free Tier Account
- Create 2 Ubuntu 18.04 Instance (1 Master and 1 Worker Node)

## Executing the script to install Kubernetes Cluster

### Master Node:

```
cd install
sh install-docker.sh
sh prepare-kube.sh
sh install-kube.sh
sh install-k8s-master.sh
sh bootstrap.sh

```



### Worker Node

```
sh install-docker.sh
sh prepare-kube.sh
sh install-kube.sh
```

```
rainaajeet1981@kubeworker1:~/dockerlabs/kubernetes/beginners/install$ sudo kubeadm join 10.140.0.7:6443 --token gzukm0.oqt9hsvagvi5ygxb \
>     --discovery-token-ca-cert-hash sha256:6cd6b2e51cee2ba5d6235bb3d6b1bb07cc4daefa2c941a1e1c8c2e3310d63c1c
[preflight] Running pre-flight checks
[preflight] Reading configuration from the cluster...
[preflight] FYI: You can look at this config file with 'kubectl -n kube-system get cm kubeadm-config -oyaml'
[kubelet-start] Downloading configuration for the kubelet from the "kubelet-config-1.15" ConfigMap in the kube-system namespace
[kubelet-start] Writing kubelet configuration to file "/var/lib/kubelet/config.yaml"
[kubelet-start] Writing kubelet environment file with flags to file "/var/lib/kubelet/kubeadm-flags.env"
[kubelet-start] Activating the kubelet service
[kubelet-start] Waiting for the kubelet to perform the TLS Bootstrap...
This node has joined the cluster:
* Certificate signing request was sent to apiserver and a response was received.
* The Kubelet was informed of the new secure connection details.
Run 'kubectl get nodes' on the control-plane to see this node join the cluster.
```


## Verifying Kubectl version on master node

```
rainaajeet1981@kubemaster:~$ sudo kubectl version
Client Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.0", GitCommit:"e8462b5b5dc2584fdcd18e6bcfe9f1e4d970a529", GitTreeState:"clean",
 BuildDate:"2019-06-19T16:40:16Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"15", GitVersion:"v1.15.0", GitCommit:"e8462b5b5dc2584fdcd18e6bcfe9f1e4d970a529", GitTreeState:"clean",
 BuildDate:"2019-06-19T16:32:14Z", GoVersion:"go1.12.5", Compiler:"gc", Platform:"linux/amd64"}
rainaajeet1981@kubemaster:~$ 
```

## Deploy a Simple Web Page

```
rainaajeet1981@kubemaster:~$ sudo kubectl create deployment hellowhale --image ajeetraina/hellowhale
deployment.apps/hellowhale created
rainaajeet1981@kubemaster:~$ sudo kubectl get deploy
NAME         READY   UP-TO-DATE   AVAILABLE   AGE
hellowhale   1/1     1            1           13s
rainaajeet1981@kubemaster:~$ 
```

## Getting the Pods

```
rainaajeet1981@kubemaster:~$ kubectl get po
NAME                          READY   STATUS    RESTARTS   AGE
hellowhale-798955b69f-bmfnd   1/1     Running   0          44s
rainaajeet1981@kubemaster:~$ 
```

## 

```
rainaajeet1981@kubemaster:~$ sudo kubectl expose deployment/hellowhale --port=80 --name=hellowhalesvc --type LoadBalancer
service/hellowhalesvc exposed
rainaajeet1981@kubemaster:~$ 
```

## 

```
rainaajeet1981@kubemaster:~$ sudo kubectl get po,svc,deploy
NAME                              READY   STATUS    RESTARTS   AGE
pod/hellowhale-798955b69f-nww69   1/1     Running   0          98s
NAME                    TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)        AGE
service/hellowhalesvc   LoadBalancer   10.97.34.197   <pending>     80:30813/TCP   82s
service/kubernetes      ClusterIP      10.96.0.1      <none>        443/TCP        40m
NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/hellowhale   1/1     1            1           98s 
```

## 

Wait till External-IP under the firt row appear.

## Verifying if firewall is not allowing

RUn the below command to open commandline UI to verify if it is working fine

```
<head>
  <!-- Basic Page Needs
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <meta charset="utf-8">
  <title>Hello Whale</title>
  <meta name="description" content="">
  <meta name="author" content="">
  <!-- Mobile Specific Metas
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <!-- FONT
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <link href="//fonts.googleapis.com/css?family=Raleway:400,300,600" rel="stylesheet" type="text/css">
  <!-- CSS
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <link rel="stylesheet" href="css/normalize.css">
  <link rel="stylesheet" href="css/skeleton.css">
  <!-- Favicon
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <link rel="icon" type="image/png" href="images/favicon.png">
</head>
<body>
  <!-- Primary Page Layout
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
  <div class="container">
    <div class="row">
      <div class="one-half column" style="margin-top: 25%">
        <h1 style="color:red"><b>Hello Docker FanClub!</b></h1>
        <img src="images/docker.png"
        <p>This page is served from a <strong>docker</strong> container running Nginx.</p>
      </div>
    </div>
  </div>
<!-- End Document
  –––––––––––––––––––––––––––––––––––––––––––––––––– -->
</body>
</html>
rainaajeet1981@kubemaster:~$ 
```

## Listing the containers in master node

```
rainaajeet1981@kubemaster:~$ sudo docker ps
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS               NAMES
208c047c49ba        weaveworks/weave-npc    "/usr/bin/weave-npc"     15 minutes ago      Up 15 minutes                           k8s_weave-npc_weave-
net-v8l4x_kube-system_fd884fae-709d-4fbc-a19c-6a5e394afdc4_0
082e1b8a7931        weaveworks/weave-kube   "/home/weave/launch.…"   15 minutes ago      Up 15 minutes                           k8s_weave_weave-net-
v8l4x_kube-system_fd884fae-709d-4fbc-a19c-6a5e394afdc4_0
da373e15e2c9        k8s.gcr.io/pause:3.1    "/pause"                 15 minutes ago      Up 15 minutes                           k8s_POD_weave-net-v8
l4x_kube-system_fd884fae-709d-4fbc-a19c-6a5e394afdc4_0
76617d14ccb1        eb516548c180            "/coredns -conf /etc…"   28 minutes ago      Up 28 minutes                           k8s_coredns_coredns-
5c98db65d4-8lt6b_kube-system_2ddcf54e-3be4-4a9c-bb53-1e5a5712e768_0
eed32ad39a81        eb516548c180            "/coredns -conf /etc…"   28 minutes ago      Up 28 minutes                           k8s_coredns_coredns-
5c98db65d4-wk96h_kube-system_d40504cb-6363-48fa-aaee-7fe9cfc43c57_0
72f2b6ce0312        k8s.gcr.io/pause:3.1    "/pause"                 28 minutes ago      Up 28 minutes                           k8s_POD_coredns-5c98
db65d4-8lt6b_kube-system_2ddcf54e-3be4-4a9c-bb53-1e5a5712e768_0
4ab707ad73d4        k8s.gcr.io/pause:3.1    "/pause"                 28 minutes ago      Up 28 minutes                           k8s_POD_coredns-5c98
db65d4-wk96h_kube-system_d40504cb-6363-48fa-aaee-7fe9cfc43c57_0
0c8429ebe4e5        f0fad859c909            "/opt/bin/flanneld -…"   28 minutes ago      Up 28 minutes                           k8s_kube-flannel_kub
e-flannel-ds-amd64-9wq4l_kube-system_4c7a7224-ff02-447c-9fc9-961c8f790e64_0
84b08bf1f4a5        d235b23c3570            "/usr/local/bin/kube…"   28 minutes ago      Up 28 minutes                           k8s_kube-proxy_kube-
proxy-sc5l4_kube-system_2baa7973-dc77-4617-963b-b1d2653b64dd_0
7d6d4b1a6068        k8s.gcr.io/pause:3.1    "/pause"                 28 minutes ago      Up 28 minutes                           k8s_POD_kube-flannel
-ds-amd64-9wq4l_kube-system_4c7a7224-ff02-447c-9fc9-961c8f790e64_0
f4cf21df5b6a        k8s.gcr.io/pause:3.1    "/pause"                 28 minutes ago      Up 28 minutes                           k8s_POD_kube-proxy-s
c5l4_kube-system_2baa7973-dc77-4617-963b-b1d2653b64dd_0
21056e4bfce3        2c4adeb21b4f            "etcd --advertise-cl…"   29 minutes ago      Up 29 minutes                           k8s_etcd_etcd-kubema
ster_kube-system_7af76fec5794c446dbdd79fce93b93a2_0
d81083f12cd9        2d3813851e87            "kube-scheduler --bi…"   29 minutes ago      Up 29 minutes                           k8s_kube-scheduler_k
ube-scheduler-kubemaster_kube-system_31d9ee8b7fb12e797dc981a8686f6b2b_0
4852c60ba2fe        201c7a840312            "kube-apiserver --ad…"   29 minutes ago      Up 29 minutes                           k8s_kube-apiserver_k
ube-apiserver-kubemaster_kube-system_d23d3be758e89d4192996f6e5f2489c1_0
1615dd8544b1        8328bb49b652            "kube-controller-man…"   29 minutes ago      Up 29 minutes                           k8s_kube-controller-
manager_kube-controller-manager-kubemaster_kube-system_5c8d15384444348773e9de77de0cf941_0
307af522d3d7        k8s.gcr.io/pause:3.1    "/pause"                 29 minutes ago      Up 29 minutes                           k8s_POD_kube-control
ler-manager-kubemaster_kube-system_5c8d15384444348773e9de77de0cf941_0
298bda6c3b87        k8s.gcr.io/pause:3.1    "/pause"                 29 minutes ago      Up 29 minutes                           k8s_POD_kube-apiserv
er-kubemaster_kube-system_d23d3be758e89d4192996f6e5f2489c1_0
05f3e304d5ca        k8s.gcr.io/pause:3.1    "/pause"                 29 minutes ago      Up 29 minutes                           k8s_POD_etcd-kubemas
ter_kube-system_7af76fec5794c446dbdd79fce93b93a2_0
e4c21e9dd7e7        k8s.gcr.io/pause:3.1    "/pause"                 29 minutes ago      Up 29 minutes                           k8s_POD_kube-schedul
er-kubemaster_kube-system_31d9ee8b7fb12e797dc981a8686f6b2b_0

```


## Listing out the container in worker node

```
rainaajeet1981@kubeworker1:~/dockerlabs/kubernetes/beginners/install$ sudo docker ps
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS               NAMES
20c69cf479ef        ajeetraina/hellowhale   "./wrapper.sh"           8 minutes ago       Up 8 minutes                            k8s_hellowhale_hello
whale-798955b69f-bmfnd_default_debbaf69-796e-44ac-8a03-e9d1a5857051_0
f926f8b44d45        k8s.gcr.io/pause:3.1    "/pause"                 8 minutes ago       Up 8 minutes                            k8s_POD_hellowhale-7
98955b69f-bmfnd_default_debbaf69-796e-44ac-8a03-e9d1a5857051_0
d46234b0083b        weaveworks/weave-npc    "/usr/bin/weave-npc"     13 minutes ago      Up 13 minutes                           k8s_weave-npc_weave-
net-x22qt_kube-system_0ff78287-124b-465f-bc75-a2cbec96d6da_0
c978f4e8263c        f0fad859c909            "/opt/bin/flanneld -…"   13 minutes ago      Up 13 minutes                           k8s_kube-flannel_kub
e-flannel-ds-amd64-bd76j_kube-system_6f69e6b9-8b3e-41c0-844b-5d06c054db2b_0
a4b74ef7c237        weaveworks/weave-kube   "/home/weave/launch.…"   13 minutes ago      Up 13 minutes                           k8s_weave_weave-net-
x22qt_kube-system_0ff78287-124b-465f-bc75-a2cbec96d6da_0
58b246880805        k8s.gcr.io/kube-proxy   "/usr/local/bin/kube…"   13 minutes ago      Up 13 minutes                           k8s_kube-proxy_kube-
proxy-5swf5_kube-system_e70954f7-dc5e-4572-9c1a-2ab50b7ebaa1_0
7c9de82eabba        k8s.gcr.io/pause:3.1    "/pause"                 13 minutes ago      Up 13 minutes                           k8s_POD_kube-flannel
-ds-amd64-bd76j_kube-system_6f69e6b9-8b3e-41c0-844b-5d06c054db2b_0
ce8b6b03fdd1        k8s.gcr.io/pause:3.1    "/pause"                 13 minutes ago      Up 13 minutes                           k8s_POD_kube-proxy-5
swf5_kube-system_e70954f7-dc5e-4572-9c1a-2ab50b7ebaa1_0
a965ed6fd6b9        k8s.gcr.io/pause:3.1    "/pause"                 13 minutes ago      Up 13 minutes                           k8s_POD_weave-net-x2
2qt_kube-system_0ff78287-124b-465f-bc75-a2cbec96d6da_0
```

## Logs

     
 ```
 [control-plane] Creating static Pod manifest for "kube-controller-manager"
[control-plane] Creating static Pod manifest for "kube-scheduler"
[etcd] Creating static Pod manifest for local etcd in "/etc/kubernetes/manifests"
[wait-control-plane] Waiting for the kubelet to boot up the control plane as static Pods from directory "/etc/kubernetes/manifests". This can take up
 to 4m0s
[apiclient] All control plane components are healthy after 24.503004 seconds
[upload-config] Storing the configuration used in ConfigMap "kubeadm-config" in the "kube-system" Namespace
[kubelet] Creating a ConfigMap "kubelet-config-1.15" in namespace kube-system with the configuration for the kubelets in the cluster
[upload-certs] Skipping phase. Please see --upload-certs
[mark-control-plane] Marking the node kubemaster as control-plane by adding the label "node-role.kubernetes.io/master=''"
[mark-control-plane] Marking the node kubemaster as control-plane by adding the taints [node-role.kubernetes.io/master:NoSchedule]
[bootstrap-token] Using token: gzukm0.oqt9hsvagvi5ygxb
[bootstrap-token] Configuring bootstrap tokens, cluster-info ConfigMap, RBAC Roles
[bootstrap-token] configured RBAC rules to allow Node Bootstrap tokens to post CSRs in order for nodes to get long term certificate credentials
[bootstrap-token] configured RBAC rules to allow the csrapprover controller automatically approve CSRs from a Node Bootstrap Token
[bootstrap-token] configured RBAC rules to allow certificate rotation for all node client certificates in the cluster
[bootstrap-token] Creating the "cluster-info" ConfigMap in the "kube-public" namespace
[addons] Applied essential addon: CoreDNS
[addons] Applied essential addon: kube-proxy
Your Kubernetes control-plane has initialized successfully!
To start using your cluster, you need to run the following as a regular user:
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/
Then you can join any number of worker nodes by running the following on each as root:
kubeadm join 10.140.0.7:6443 --token gzukm0.oqt9hsvagvi5ygxb \
    --discovery-token-ca-cert-hash sha256:6cd6b2e51cee2ba5d6235bb3d6b1bb07cc4daefa2c941a1e1c8c2e3310d63c1c 
clusterrole.rbac.authorization.k8s.io/flannel created
clusterrolebinding.rbac.authorization.k8s.io/flannel created
serviceaccount/flannel created
configmap/kube-flannel-cfg created
daemonset.extensions/kube-flannel-ds-amd64 created
daemonset.extensions/kube-flannel-ds-arm64 created
daemonset.extensions/kube-flannel-ds-arm created
daemonset.extensions/kube-flannel-ds-ppc64le created
daemonset.extensions/kube-flannel-ds-s390x created
rainaajeet1981@kubemaster:~$ 
 
 ```
 
 ## Deep Diving into Pods
 
 ```
 Node:           kubeworker1/10.140.0.8
Start Time:     Sun, 23 Jun 2019 07:46:30 +0000
Labels:         app=hellowhale
                pod-template-hash=798955b69f
Annotations:    <none>
Status:         Running
IP:             10.244.1.3
Controlled By:  ReplicaSet/hellowhale-798955b69f
Containers:
  hellowhale:
    Container ID:   docker://a5d33a6056a73e62dc2dfa5f42285882de3aaaa3106ef28b1bdde30f20d120c5
    Image:          ajeetraina/hellowhale
    Image ID:       docker-pullable://ajeetraina/hellowhale@sha256:50e5d8b034ff3a0d537224e332da0ee74e393df36acefa6859daba58712ad1f4
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 23 Jun 2019 07:46:34 +0000
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-h9dbb (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  default-token-h9dbb:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-h9dbb
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age    From                  Message
  ----    ------     ----   ----                  -------
  Normal  Scheduled  2m38s  default-scheduler     Successfully assigned default/hellowhale-798955b69f-nww69 to kubeworker1
  Normal  Pulling    2m36s  kubelet, kubeworker1  Pulling image "ajeetraina/hellowhale"
  Normal  Pulled     2m34s  kubelet, kubeworker1  Successfully pulled image "ajeetraina/hellowhale"
  Normal  Created    2m34s  kubelet, kubeworker1  Created container hellowhale
  Normal  Started    2m34s  kubelet, kubeworker1  Started container hellowhale
rainaajeet1981@kubemaster:~$ 
```









