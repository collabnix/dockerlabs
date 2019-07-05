# Installing Kubernetes Dashboard

```
[node1 install]$ kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
secret/kubernetes-dashboard-certs createdserviceaccount/kubernetes-dashboard created
role.rbac.authorization.k8s.io/kubernetes-dashboard-minimal created
rolebinding.rbac.authorization.k8s.io/kubernetes-dashboard-minimal created
deployment.apps/kubernetes-dashboard createdservice/kubernetes-dashboard created
[node1 install]$
```

## Displaying all the Pods under all namespaces

```
[node1 install]$ kubectl get po --all-namespacesNAMESPACE     NAME                                    READY   STATUS    RESTARTS   AGE
kube-system   coredns-fb8b8dccf-lwjz6                 1/1     Running   0          8m20s
kube-system   coredns-fb8b8dccf-zpz2r                 1/1     Running   0          8m20skube-system   etcd-node1                              1/1     Running   0          7m29s
kube-system   kube-apiserver-node1                    1/1     Running   0          7m34s
kube-system   kube-controller-manager-node1           1/1     Running   0          7m18s
kube-system   kube-proxy-ffbcw                        1/1     Running   0          8m19s
kube-system   kube-proxy-mfnrx                        1/1     Running   0          8m1s
kube-system   kube-scheduler-node1                    1/1     Running   0          7m16s
kube-system   kubernetes-dashboard-5f7b999d65-29tv6   1/1     Running   0          2m2s
kube-system   weave-net-b9svm                         2/2     Running   1          8m1s
kube-system   weave-net-xjfxc                         2/2     Running   0          8m19s
[node1 install]$
```

```
[node1 install]$ kubectl create clusterrolebinding dashboard-admin -n default \
> --clusterrole=cluster-admin \
> --serviceaccount=default:dashboard
clusterrolebinding.rbac.authorization.k8s.io/dashboard-admin created

 ```
 
 
