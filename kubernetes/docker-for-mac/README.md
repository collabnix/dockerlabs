# How to install Heapster using Helm on Docker Desktop for Mac


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


