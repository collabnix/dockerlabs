


# Multipass + MicroK8 + Grafana On MacOS

Multipass is a system that orchestrates the creation, management and maintenance of Virtual Machines and associated Ubuntu images to simplify development. MicroK8s is a local deployment of Kubernetes. Let’s skip all the technical details and just accept that
Kubernetes does not run natively on MacOS or Windows. You may be thinking “I have seen Kubernetes running on a MacOS laptop, 
what kind of sorcery was that?” It’s simple, Kubernetes is running inside a VM. You might not see the VM or it 
might not even be a full blown virtual system but some level of virtualisation is there. This is exactly what we will show here. 

Under this tutorial, we will setup a VM using Multipass and will showcase how to install MicroK8s. After the installation we will discuss how to build appalication stack using K8s. Let's get started:

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> macOS </b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- [Download Multipass VM](https://github.com/CanonicalLtd/multipass/releases)

# A Multipass VM on MacOS

```
Biradars-MacBook-Air:~ sangam$ multipass launch --name microk8s-vm --mem 4G --disk 40G
Launched: microk8s-vm                                                           
Biradars-MacBook-Air:~ sangam$ multipass exec microk8s-vm -- sudo snap install microk8s --classic
multipass exec microk8s-vm -- sudo iptables -P FORWARD ACCEPT
2019-02-19T18:13:52+05:30 INFO Waiting for restart...
microk8s v1.13.2 from Canonical✓ installed

```

Make sure you reserve enough resources to host your deployments; above, we got 4GB of RAM and 40GB of hard disk. 
We need to ensure that the packets to/from the pod network interface can be forwarded to/from the default interface.


# Verifying VM IP Address

```
Biradars-MacBook-Air:~ sangam$ multipass list
Name                    State             IPv4             Release
microk8s-vm             RUNNING           192.168.64.3     Ubuntu 18.04 LTS

```
Take a note of this IP since our services will become available there.
Other multipass commands you may find handy:


# Getting a shell inside the VM:

```
Biradars-MacBook-Air:~ sangam$ multipass shell microk8s-vm
Welcome to Ubuntu 18.04.2 LTS (GNU/Linux 4.15.0-45-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

 System information disabled due to load higher than 1.0


  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

7 packages can be updated.
7 updates are security updates.

Last login: Tue Feb 19 18:11:11 2019 from 192.168.64.1
```

# Installing Kubectl
```
sudo snap install kubectl --classic
```
```
multipass@microk8s-vm:~$ kubectl version
Client Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.3", GitCommit:"721bfa751924da8d1680787490c54b9179b1fed0", GitTreeState:"clean", BuildDate:"2019-02-01T20:08:12Z", GoVersion:"go1.11.5", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"13", GitVersion:"v1.13.2", GitCommit:"cff46ab41ff0bb44d8584413b598ad8360ec1def", GitTreeState:"clean", BuildDate:"2019-01-10T23:28:14Z", GoVersion:"go1.11.4", Compiler:"gc", Platform:"linux/amd64"}
```

# Verifying Kubernetes microk8

```
multipass@microk8s-vm:~$ microk8s.kubectl get nodes
NAME          STATUS   ROLES    AGE   VERSION
microk8s-vm   Ready    <none>   13m   v1.13.2
```

# Checking the cluster Status

```
multipass@microk8s-vm:~$ microk8s.kubectl get services
NAME         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.152.183.1   <none>        443/TCP   15m
```
# Enable microk8 dashboard 

```
multipass@microk8s-vm:~$ microk8s.enable dns dashboard
Enabling DNS
Applying manifest
service/kube-dns created
serviceaccount/kube-dns created
configmap/kube-dns created
deployment.extensions/kube-dns created
Restarting kubelet
DNS is enabled
Enabling dashboard
secret/kubernetes-dashboard-certs created
serviceaccount/kubernetes-dashboard created
deployment.apps/kubernetes-dashboard created
service/kubernetes-dashboard created
service/monitoring-grafana created
service/monitoring-influxdb created
service/heapster created
deployment.extensions/monitoring-influxdb-grafana-v4 created
serviceaccount/heapster created
configmap/heapster-config created
configmap/eventer-config created
deployment.extensions/heapster-v1.5.2 created
dashboard enabled
multipass@microk8s-vm:~$ 
```
# Deploying NGINX service

Deploying a nginx service is what you would expect, with the addition of the Microk8s prefix


```
multipass@microk8s-vm:~$ microk8s.kubectl run nginx --image nginx --replicas 3
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/nginx created
 --selector=run=nginx --name nginxkubectl expose deployment nginx --port 80 --target-port 80 --type ClusterIP\ 
The Service "nginx" is invalid: spec.type: Unsupported value: "ClusterIP --selector=run=nginx": supported values: "ClusterIP", "ExternalName", "LoadBalancer", "NodePort"
multipass@microk8s-vm:~$ 
```

# Listing all pod and services details 

```
multipass@microk8s-vm:~$ microk8s.kubectl get all
NAME                         READY   STATUS    RESTARTS   AGE
pod/nginx-7cdbd8cdc9-cgksg   1/1     Running   0          2m41s
pod/nginx-7cdbd8cdc9-msq5w   1/1     Running   0          2m41s
pod/nginx-7cdbd8cdc9-sbqll   1/1     Running   0          2m41s

NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.152.183.1   <none>        443/TCP   22m

NAME                    READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/nginx   3/3     3            3           2m41s

NAME                               DESIRED   CURRENT   READY   AGE
replicaset.apps/nginx-7cdbd8cdc9   3         3         3       2m41s
multipass@microk8s-vm:~$ 
```


```
multipass@microk8s-vm:~$ kubectl --kubeconfig=kubeconfig get all --all-namespaces
NAMESPACE   NAME                 TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
default     service/kubernetes   ClusterIP   10.152.183.1   <none>        443/TCP   11m
```

# Verifying if all services are Up and Running

```
multipass@microk8s-vm:~$ microk8s.kubectl get all --all-namespaces
NAMESPACE     NAME                                                  READY   STATUS    RESTARTS   AGE
default       pod/nginx-7cdbd8cdc9-cgksg                            1/1     Running   0          7m19s
default       pod/nginx-7cdbd8cdc9-msq5w                            1/1     Running   0          7m19s
default       pod/nginx-7cdbd8cdc9-sbqll                            1/1     Running   0          7m19s
kube-system   pod/heapster-v1.5.2-64874f6bc6-tgx96                  4/4     Running   0          7m32s
kube-system   pod/kube-dns-6ccd496668-n64pw                         3/3     Running   0          10m
kube-system   pod/kubernetes-dashboard-654cfb4879-98h29             1/1     Running   0          10m
kube-system   pod/monitoring-influxdb-grafana-v4-6679c46745-tbrbg   2/2     Running   0          10m

NAMESPACE     NAME                           TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
default       service/kubernetes             ClusterIP   10.152.183.1     <none>        443/TCP             27m
kube-system   service/heapster               ClusterIP   10.152.183.77    <none>        80/TCP              10m
kube-system   service/kube-dns               ClusterIP   10.152.183.10    <none>        53/UDP,53/TCP       10m
kube-system   service/kubernetes-dashboard   ClusterIP   10.152.183.171   <none>        443/TCP             10m
kube-system   service/monitoring-grafana     ClusterIP   10.152.183.127   <none>        80/TCP              10m
kube-system   service/monitoring-influxdb    ClusterIP   10.152.183.216   <none>        8083/TCP,8086/TCP   10m

NAMESPACE     NAME                                             READY   UP-TO-DATE   AVAILABLE   AGE
default       deployment.apps/nginx                            3/3     3            3           7m19s
kube-system   deployment.apps/heapster-v1.5.2                  1/1     1            1           10m
kube-system   deployment.apps/kube-dns                         1/1     1            1           10m
kube-system   deployment.apps/kubernetes-dashboard             1/1     1            1           10m
kube-system   deployment.apps/monitoring-influxdb-grafana-v4   1/1     1            1           10m

NAMESPACE     NAME                                                        DESIRED   CURRENT   READY   AGE
default       replicaset.apps/nginx-7cdbd8cdc9                            3         3         3       7m19s
kube-system   replicaset.apps/heapster-v1.5.2-56c546dbb8                  0         0         0       7m47s
kube-system   replicaset.apps/heapster-v1.5.2-64874f6bc6                  1         1         1       7m32s
kube-system   replicaset.apps/heapster-v1.5.2-6bc7c4965d                  0         0         0       10m
kube-system   replicaset.apps/kube-dns-6ccd496668                         1         1         1       10m
kube-system   replicaset.apps/kubernetes-dashboard-654cfb4879             1         1         1       10m
kube-system   replicaset.apps/monitoring-influxdb-grafana-v4-6679c46745   1         1         1       10m
```


# Checking the Cluster Information

```

multipass@microk8s-vm:~$ microk8s.kubectl cluster-info
Kubernetes master is running at http://127.0.0.1:8080
Heapster is running at http://127.0.0.1:8080/api/v1/namespaces/kube-system/services/heapster/proxy
KubeDNS is running at http://127.0.0.1:8080/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Grafana is running at http://127.0.0.1:8080/api/v1/namespaces/kube-system/services/monitoring-grafana/proxy
InfluxDB is running at http://127.0.0.1:8080/api/v1/namespaces/kube-system/services/monitoring-influxdb:http/proxy

```

# Verifying IP Address of VM instance & Replacing with your Monitoring servives

```

Kubernetes master is running at http://192.168.64.3:8080
Heapster is running at http://192.168.64.3:8080/api/v1/namespaces/kube-system/services/heapster/proxy
KubeDNS is running at http://192.168.64.3:8080/v1/namespaces/kube-system/services/kube-dns:dns/proxy
Grafana is running at http://192.168.64.3:8080/api/v1/namespaces/kube-system/services/monitoring-grafana/proxy
InfluxDB is running at http://192.168.64.3:8080/api/v1/namespaces/kube-system/services/monitoring-influxdb:http/proxy
```


## Reference: https://engineitops.icu/setup_microk8_on_MAC

# Contributor 

-[Sangam Biradar](https://www.linkedin.com/in/sangambiradar14)
