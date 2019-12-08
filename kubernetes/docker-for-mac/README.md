# How to install Metrics Server using Helm on Docker Desktop for Mac

Metrics Server is a cluster-wide aggregator of resource usage data. Metrics server collect metrics from Summary API, exposed by Kubelet on each node.

## Pre-requisite:

- Ensure that Helm is properly installed
- Ensure that ```helm version``` displays error-free output 


## Note: In case you encounter the below error message:

```
[Captains-Bay]🚩 >  helm version
Client: &version.Version{SemVer:"v2.12.1", GitCommit:"02a47c7249b1fc6d8fd3b94e6b4babf9d818144e", GitTreeState:"clean"}
Error: could not find tiller
```

Follow the below steps to fix the issue:

```
[Captains-Bay]🚩 >  helm init --service-account tiller
$HELM_HOME has been configured at /Users/ajeetraina/.helm.

Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.

Please note: by default, Tiller is deployed with an insecure 'allow unauthenticated users' policy.
To prevent this, run `helm init` with the --tiller-tls-verify flag.
For more information on securing your installation see: https://docs.helm.sh/using_helm/#securing-your-helm-installation
Happy Helming!
```

```
[Captains-Bay]🚩 >  kubectl -n kube-system get pods
NAME                                     READY     STATUS    RESTARTS   AGE
coredns-5c98db65d4-pdzb7                 1/1       Running   1          10d
coredns-5c98db65d4-v6trh                 1/1       Running   1          10d
etcd-docker-desktop                      1/1       Running   0          10d
kube-apiserver-docker-desktop            1/1       Running   0          10d
kube-controller-manager-docker-desktop   1/1       Running   0          10d
kube-proxy-fcmq9                         1/1       Running   0          10d
kube-scheduler-docker-desktop            1/1       Running   0          10d
```

```
[Captains-Bay]🚩 >  kubectl -n kube-system delete deployment tiller-deploy
deployment "tiller-deploy" deleted
```

```
[Captains-Bay]🚩 >  kubectl -n kube-system delete service/tiller-deploy
service "tiller-deploy" deleted
```

```
[Captains-Bay]🚩 >  helm init
$HELM_HOME has been configured at /Users/ajeetraina/.helm.

Tiller (the Helm server-side component) has been installed into your Kubernetes Cluster.

Please note: by default, Tiller is deployed with an insecure 'allow unauthenticated users' policy.
To prevent this, run `helm init` with the --tiller-tls-verify flag.
For more information on securing your installation see: https://docs.helm.sh/using_helm/#securing-your-helm-installation
Happy Helming!
```

Please wait for 1 min to get the below output working:

```
[Captains-Bay]🚩 >  helm version
Client: &version.Version{SemVer:"v2.12.1", GitCommit:"02a47c7249b1fc6d8fd3b94e6b4babf9d818144e", GitTreeState:"clean"}
Server: &version.Version{SemVer:"v2.12.1", GitCommit:"02a47c7249b1fc6d8fd3b94e6b4babf9d818144e", GitTreeState:"clean"}
[Captains-Bay]🚩 >
```

## Installing Metrics Server using Helm


```
helm repo add bitnami https://charts.bitnami.com/bitnami
```

```
[Captains-Bay]🚩 >  helm install --name collabmetric bitnami/metrics-server
NAME:   collabmetric
LAST DEPLOYED: Sun Dec  8 20:34:08 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/ClusterRole
NAME                                AGE
system:collabmetric-metrics-server  0s

==> v1/ClusterRoleBinding
NAME                                               AGE
collabmetric-metrics-server:system:auth-delegator  0s
system:collabmetric-metrics-server                 0s

==> v1beta1/RoleBinding
NAME                                     AGE
collabmetric-metrics-server-auth-reader  0s

==> v1/Service
NAME                         TYPE       CLUSTER-IP      EXTERNAL-IP  PORT(S)  AGE
collabmetric-metrics-server  ClusterIP  10.102.200.195  <none>       443/TCP  0s

==> v1/Deployment
NAME                         DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
collabmetric-metrics-server  1        1        1           0          0s

==> v1/Pod(related)
NAME                                          READY  STATUS             RESTARTS  AGE
collabmetric-metrics-server-77f467bdb9-cx8fx  0/1    ContainerCreating  0         0s

==> v1/ServiceAccount
NAME                         SECRETS  AGE
collabmetric-metrics-server  1        0s


NOTES:
** Please be patient while the chart is being deployed **

The metric server has been deployed.

########################################################################################
### ERROR: The metrics.k8s.io/v1beta1 API service is not enabled in the cluster      ###
########################################################################################
You have disabled the API service creation for this release. As the Kubernetes version in the cluster 
does not have metrics.k8s.io/v1beta1, the metrics API will not work with this release unless:

Option A: 

  You complete your metrics-server release by running:

  helm upgrade collabmetric bitnami/metrics-server \
    --set apiService.create=true

Option B:
  
   You configure the metrics API service outside of this Helm chart
```


```
helm upgrade collabmetric bitnami/metrics-server \
>     --set apiService.create=true


Release "collabmetric" has been upgraded. Happy Helming!
LAST DEPLOYED: Sun Dec  8 20:35:37 2019
NAMESPACE: default
STATUS: DEPLOYED

RESOURCES:
==> v1/ClusterRoleBinding
NAME                                               AGE
collabmetric-metrics-server:system:auth-delegator  88s
system:collabmetric-metrics-server                 88s

==> v1beta1/RoleBinding
NAME                                     AGE
collabmetric-metrics-server-auth-reader  88s

==> v1/Service
NAME                         TYPE       CLUSTER-IP      EXTERNAL-IP  PORT(S)  AGE
collabmetric-metrics-server  ClusterIP  10.102.200.195  <none>       443/TCP  88s

==> v1/Deployment
NAME                         DESIRED  CURRENT  UP-TO-DATE  AVAILABLE  AGE
collabmetric-metrics-server  1        1        1           1          88s

==> v1beta1/APIService
NAME                    AGE
v1beta1.metrics.k8s.io  0s

==> v1/Pod(related)
NAME                                          READY  STATUS   RESTARTS  AGE
collabmetric-metrics-server-77f467bdb9-cx8fx  1/1    Running  0         88s

==> v1/ServiceAccount
NAME                         SECRETS  AGE
collabmetric-metrics-server  1        88s

==> v1/ClusterRole
NAME                                AGE
system:collabmetric-metrics-server  88s


NOTES:
** Please be patient while the chart is being deployed **

The metric server has been deployed.

In a few minutes you should be able to list metrics using the following
command:

  kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"
  
```

```
[Captains-Bay]🚩 >  kubectl get --raw "/apis/metrics.k8s.io/v1beta1/nodes"
{"kind":"NodeMetricsList","apiVersion":"metrics.k8s.io/v1beta1","metadata":{"selfLink":"/apis/metrics.k8s.io/v1beta1/nodes"},"items":[]}
```

```
[Captains-Bay]🚩 >  kubectl get po
NAME                                           READY     STATUS    RESTARTS   AGE
collabmetric-metrics-server-77f467bdb9-cx8fx   1/1       Running   0          2m
[Captains-Bay]🚩 >  
```


```
[Captains-Bay]🚩 >  kubectl get po,svc,deploy
NAME                                              READY     STATUS    RESTARTS   AGE
po/collabmetric-metrics-server-77f467bdb9-cx8fx   1/1       Running   0          2m

NAME                              TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE
svc/collabmetric-metrics-server   ClusterIP   10.102.200.195   <none>        443/TCP   2m
svc/kubernetes                    ClusterIP   10.96.0.1        <none>        443/TCP   10d

NAME                                 DESIRED   CURRENT   UP-TO-DATE   AVAILABLE   AGE
deploy/collabmetric-metrics-server   1         1         1            1           2m
[Captains-Bay]🚩 >  
```

```
[Captains-Bay]🚩 >  kubectl describe po
Name:           collabmetric-metrics-server-77f467bdb9-cx8fx
Namespace:      default
Node:           docker-desktop/192.168.65.3
Start Time:     Sun, 08 Dec 2019 20:34:09 +0530
Labels:         app.kubernetes.io/instance=collabmetric
                app.kubernetes.io/managed-by=Tiller
                app.kubernetes.io/name=metrics-server
                helm.sh/chart=metrics-server-4.1.0
                pod-template-hash=77f467bdb9
Annotations:    <none>
Status:         Running
IP:             10.1.0.12
Controlled By:  ReplicaSet/collabmetric-metrics-server-77f467bdb9
Containers:
  metrics-server:
    Container ID:  docker://70547ffc97ab8affeeb1d7c8a9d8763f1a2c7043979fd18014df1ec63ee81ca7
    Image:         docker.io/bitnami/metrics-server:0.3.6-debian-9-r27
    Image ID:      docker-pullable://bitnami/metrics-server@sha256:8640d60f8f6ec7b447c503fec78dd1bdad37952831e9c4524ca1746f5682ce4d
    Port:          8443/TCP
    Command:
      metrics-server
      --secure-port=8443
    State:          Running
      Started:      Sun, 08 Dec 2019 20:34:33 +0530
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from collabmetric-metrics-server-token-zvhmt (ro)
Conditions:
  Type              Status
  Initialized       True 
  Ready             True 
  ContainersReady   True 
  PodScheduled      True 
Volumes:
  collabmetric-metrics-server-token-zvhmt:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  collabmetric-metrics-server-token-zvhmt
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age   From                     Message
  ----    ------     ----  ----                     -------
  Normal  Scheduled  5m    default-scheduler        Successfully assigned default/collabmetric-metrics-server-77f467bdb9-cx8fx to docker-desktop
  Normal  Pulling    5m    kubelet, docker-desktop  Pulling image "docker.io/bitnami/metrics-server:0.3.6-debian-9-r27"
  Normal  Pulled     5m    kubelet, docker-desktop  Successfully pulled image "docker.io/bitnami/metrics-server:0.3.6-debian-9-r27"
  Normal  Created    5m    kubelet, docker-desktop  Created container metrics-server
  Normal  Started    5m    kubelet, docker-desktop  Started container metrics-server
  ```
