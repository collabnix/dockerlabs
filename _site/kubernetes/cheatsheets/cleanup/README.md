# Cleaning Up K8s resources

Assume that you have the below pods, services and deployment running on your K8s cluster:

```
[node1 ~]$ kubectl get po,deploy,svc -n kube-system
NAME                                        READY   STATUS              RESTARTS   AGE
pod/coredns-fb8b8dccf-7r8lg                 0/1     Terminating         0          4m48s
pod/coredns-fb8b8dccf-sq2c4                 0/1     Terminating         0          4m48s
pod/etcd-node1                              1/1     Running             0          4m48s
pod/heapster-5d4bf58946-4bs9p               0/1     ContainerCreating   0          4m48s
pod/kube-apiserver-node1                    1/1     Running             0          4m46s
pod/kube-controller-manager-node1           1/1     Running             0          4m46s
pod/kube-proxy-6cnm8                        1/1     Running             0          4m40s
pod/kube-proxy-lpw4w                        1/1     Running             0          4m34s
pod/kube-proxy-zz5rc                        1/1     Running             0          4m45s
pod/kube-scheduler-node1                    1/1     Running             0          4m47s
pod/kubernetes-dashboard-5f7b999d65-hn6nj   0/1     ContainerCreating   0          4m48s
pod/monitoring-influxdb-866db5f944-cxv2p    0/1     ContainerCreating   0          4m48s
pod/weave-net-8x7wr                         1/2     CrashLoopBackOff    5          4m34s
pod/weave-net-lvn67                         1/2     CrashLoopBackOff    5          4m44s
pod/weave-net-mp6kn                         1/2     CrashLoopBackOff    5          4m42s

NAME                                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/heapster               0/1     1            0           30m
deployment.extensions/kubernetes-dashboard   0/1     1            0           32m
deployment.extensions/monitoring-influxdb    0/1     1            0           29m

NAME                           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/heapster               ClusterIP   10.101.199.51    <none>        80/TCP    30m
service/kube-dns               ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   40m
service/kubernetes-dashboard   ClusterIP   10.102.225.40    <none>        443/TCP    32m
service/monitoring-influxdb    ClusterIP   10.102.127.189   <none>        8086/TCP    29m
```

In order to delete all resources, its easy with the below single liner command:


```
kubectl delete --all pods --namespace=kube-system
```

If you have restart policy set under YAML file, it will try to recreate resources.  To get rid of these resources completely, you need to follow the below steps:


```
[node1 ~]$ kubectl delete -n kube-system deployment heapster
deployment.extensions "heapster" deleted
```

```
[node1 ~]$ kubectl get po,deploy,svc -n kube-system
NAME                                        READY   STATUS              RESTARTS   AGE
pod/etcd-node1                              1/1     Running             0          5m2s
pod/heapster-5d4bf58946-4bs9p               0/1     Terminating         0          5m2s
pod/kube-apiserver-node1                    1/1     Running             0          5m
pod/kube-controller-manager-node1           1/1     Running             0          5m
pod/kube-proxy-6cnm8                        1/1     Running             0          4m54s
pod/kube-proxy-lpw4w                        1/1     Running             0          4m48s
pod/kube-proxy-zz5rc                        1/1     Running             0          4m59s
pod/kube-scheduler-node1                    1/1     Running             0          5m1s
pod/kubernetes-dashboard-5f7b999d65-hn6nj   0/1     ContainerCreating   0          5m2s
pod/monitoring-influxdb-866db5f944-cxv2p    0/1     ContainerCreating   0          5m2s
pod/weave-net-8x7wr                         1/2     CrashLoopBackOff    5          4m48s
pod/weave-net-lvn67                         1/2     CrashLoopBackOff    5          4m58s
pod/weave-net-mp6kn                         1/2     CrashLoopBackOff    5          4m56s

NAME                                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/kubernetes-dashboard   0/1     1            0           32m
deployment.extensions/monitoring-influxdb    0/1     1            0           30m

NAME                           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/heapster               ClusterIP   10.101.199.51    <none>        80/TCP    30m
service/kube-dns               ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   41m
service/kubernetes-dashboard   ClusterIP   10.102.225.40    <none>        443/TCP    32m
service/monitoring-influxdb    ClusterIP   10.102.127.189   <none>        8086/TCP    30m
[node1 ~]$
[node1 ~]$
[node1 ~]$
```

```
[node1 ~]$ kubectl get po,deploy,svc -n kube-system
NAME                                        READY   STATUS              RESTARTS   AGE
pod/etcd-node1                              1/1     Running             0          7m2s
pod/kube-apiserver-node1                    1/1     Running             0          7m
pod/kube-controller-manager-node1           1/1     Running             0          7m
pod/kube-proxy-6cnm8                        1/1     Running             0          6m54s
pod/kube-proxy-lpw4w                        1/1     Running             0          6m48s
pod/kube-proxy-zz5rc                        1/1     Running             0          6m59s
pod/kube-scheduler-node1                    1/1     Running             0          7m1s
pod/kubernetes-dashboard-5f7b999d65-hn6nj   0/1     ContainerCreating   0          7m2s
pod/monitoring-influxdb-866db5f944-cxv2p    0/1     ContainerCreating   0          7m2s
pod/weave-net-8x7wr                         1/2     CrashLoopBackOff    6          6m48s
pod/weave-net-lvn67                         1/2     CrashLoopBackOff    6          6m58s
pod/weave-net-mp6kn                         1/2     CrashLoopBackOff    6          6m56s

NAME                                         READY   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/kubernetes-dashboard   0/1     1            0           34m
deployment.extensions/monitoring-influxdb    0/1     1            0           32m

NAME                           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/heapster               ClusterIP   10.101.199.51    <none>        80/TCP    32m
service/kube-dns               ClusterIP   10.96.0.10       <none>        53/UDP,53/TCP,9153/TCP   43m
service/kubernetes-dashboard   ClusterIP   10.102.225.40    <none>        443/TCP    34m
service/monitoring-influxdb    ClusterIP   10.102.127.189   <none>        8086/TCP
```

Delete all deployment and services individually
