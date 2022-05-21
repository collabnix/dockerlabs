# Installing K3s on Jetson Nano


```
 sudo cat /etc/os-release
[sudo] password for jetson:
NAME="Ubuntu"
VERSION="18.04.2 LTS (Bionic Beaver)"
ID=ubuntu
ID_LIKE=debian
PRETTY_NAME="Ubuntu 18.04.2 LTS"
VERSION_ID="18.04"
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
VERSION_CODENAME=bionic
UBUNTU_CODENAME=bionic
```

```
jetson@master1:~$ sudo cat /boot/cmdline.txt
dwc_otg.lpm_enable=0 console=tty1 console=ttyAMA0,115200 root=/dev/mmcblk0p7 rootfstype=ext4 elevator=deadline rootwait fbcon=map:10 fbcon=font:ProFont6x11 logo.nologo
```

## Changing the hostname

```
sudo vi /etc/hostname
master1.dell.com
```

Reboot the system.

## Installing K3s


```
jetson@master1:~$ sudo curl -sfL https://get.k3s.io | sh -
[INFO]  Finding latest release
[INFO]  Using v0.9.1 as release
[INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v0.9.1/sha256sum-arm64.txt
[INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v0.9.1/k3s-arm64
[INFO]  Verifying binary download
[INFO]  Installing k3s to /usr/local/bin/k3s
[INFO]  Creating /usr/local/bin/kubectl symlink to k3s
[INFO]  Creating /usr/local/bin/crictl symlink to k3s
[INFO]  Skipping /usr/local/bin/ctr symlink to k3s, command exists in PATH at /usr/bin/ctr
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
[INFO]  systemd: Enabling k3s unit
Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
[INFO]  systemd: Starting k3s

```

```
jetson@master1:~$ sudo k3s kubectl get node -o wide
NAME             STATUS   ROLES    AGE     VERSION         INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
jetson-desktop   Ready    master   3m55s   v1.15.4-k3s.1   192.168.1.3   <none>        Ubuntu 18.04.2 LTS   4.9.140-tegra    containerd://1.2.8-k3s.1
jetson@master1:~$
```

```
jetson@master1:~$ sudo k3s kubectl get nodes
NAME             STATUS   ROLES    AGE   VERSION
jetson-desktop   Ready    master   71m   v1.15.4-k3s.1

```

```
jetson@master1:~$ sudo k3s kubectl run mynginx --image=nginx --replicas=3 --port=80
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
Error from server (InternalError): Internal error occurred: resource quota evaluates timeout
jetson@master1:~$sudo k3s kubectl get po,svc,deploy
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   76m
Error from server (InternalError): an error on the server ("unknown") has prevented the request from succeeding (get pods)
Error from server (Timeout): the server was unable to return a response in the time allotted, but may still be processing the request (get deployments.extensions)
```
```
 sudo k3s kubectl cluster-info
[sudo] password for jetson:
Kubernetes master is running at https://127.0.0.1:6443
CoreDNS is running at https://127.0.0.1:6443/api/v1/namespaces/kube-system/services/kube-dns:dns/proxy

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
```

```
jetson@master1:~$ sudo iptables -L
Chain INPUT (policy ACCEPT)
target     prot opt source               destination
KUBE-FIREWALL  all  --  anywhere             anywhere
KUBE-SERVICES  all  --  anywhere             anywhere             ctstate NEW /* kubernetes service portals */
KUBE-EXTERNAL-SERVICES  all  --  anywhere             anywhere             ctstate NEW /* kubernetes externally-visible service portals */

Chain FORWARD (policy DROP)
target     prot opt source               destination
KUBE-FORWARD  all  --  anywhere             anywhere             /* kubernetes forwarding rules */
KUBE-SERVICES  all  --  anywhere             anywhere             ctstate NEW /* kubernetes service portals */
DOCKER-USER  all  --  anywhere             anywhere
DOCKER-ISOLATION-STAGE-1  all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere             ctstate RELATED,ESTABLISHED
DOCKER     all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere
ACCEPT     all  --  anywhere             anywhere
ACCEPT     all  --  jetson-desktop/16    anywhere
ACCEPT     all  --  anywhere             jetson-desktop/16

Chain OUTPUT (policy ACCEPT)
target     prot opt source               destination
KUBE-FIREWALL  all  --  anywhere             anywhere
KUBE-SERVICES  all  --  anywhere             anywhere             ctstate NEW /* kubernetes service portals */

Chain DOCKER (1 references)
target     prot opt source               destination

Chain DOCKER-ISOLATION-STAGE-1 (1 references)
target     prot opt source               destination
DOCKER-ISOLATION-STAGE-2  all  --  anywhere             anywhere
RETURN     all  --  anywhere             anywhere

Chain DOCKER-ISOLATION-STAGE-2 (1 references)
target     prot opt source               destination
DROP       all  --  anywhere             anywhere
RETURN     all  --  anywhere             anywhere

Chain DOCKER-USER (1 references)
target     prot opt source               destination
RETURN     all  --  anywhere             anywhere

Chain KUBE-EXTERNAL-SERVICES (1 references)
target     prot opt source               destination

Chain KUBE-FIREWALL (2 references)
target     prot opt source               destination
DROP       all  --  anywhere             anywhere             /* kubernetes firewall for dropping marked packets */ mark match 0x8000/0x8000

Chain KUBE-FORWARD (1 references)
target     prot opt source               destination
DROP       all  --  anywhere             anywhere             ctstate INVALID
ACCEPT     all  --  anywhere             anywhere             /* kubernetes forwarding rules */ mark match 0x4000/0x4000
ACCEPT     all  --  jetson-desktop/16    anywhere             /* kubernetes forwarding conntrack pod source rule */ ctstate RELATED,ESTABLISHED
ACCEPT     all  --  anywhere             jetson-desktop/16    /* kubernetes forwarding conntrack pod destination rule */ ctstate RELATED,ESTABLISHED

Chain KUBE-SERVICES (3 references)
target     prot opt source               destination
jetson@jetson-desktop:~$
```

```
jetson@master1:~$sudo k3s kubectl get po,svc,deploy

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   57s

jetson@master1:~$
```

```
$ sudo k3s kubectl get all --all-namespaces
NAMESPACE     NAME                             READY   STATUS              RESTARTS   AGE
kube-system   pod/coredns-66f496764-bf7qn      1/1     Running             0          79s
kube-system   pod/traefik-d869575c8-wsq2b      0/1     ContainerCreating   0          12s
kube-system   pod/svclb-traefik-gtqpd          0/3     ContainerCreating   0          12s
kube-system   pod/helm-install-traefik-4tjpc   0/1     Completed           0          79s


NAMESPACE     NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                                     AGE
kube-system   service/kube-dns     ClusterIP      10.43.0.10      <none>        53/UDP,53/TCP,9153/TCP                      99s
default       service/kubernetes   ClusterIP      10.43.0.1       <none>        443/TCP                                     97s
kube-system   service/traefik      LoadBalancer   10.43.140.218   <pending>     80:31655/TCP,443:31667/TCP,8080:31486/TCP   13s

NAMESPACE     NAME                           DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE
kube-system   daemonset.apps/svclb-traefik   1         1         0       1            0           <none>          13s

NAMESPACE     NAME                      READY   UP-TO-DATE   AVAILABLE   AGE
kube-system   deployment.apps/coredns   1/1     1            1           99s
kube-system   deployment.apps/traefik   0/1     1            0           13s

NAMESPACE     NAME                                DESIRED   CURRENT   READY   AGE
kube-system   replicaset.apps/coredns-66f496764   1         1         1       80s
kube-system   replicaset.apps/traefik-d869575c8   1         1         0       13s



NAMESPACE     NAME                             COMPLETIONS   DURATION   AGE
kube-system   job.batch/helm-install-traefik   1/1           69s        98s

jetson@jetson-desktop:~$
```

```
$ sudo k3s kubectl run mynginx --image=nginx --replicas=3 --port=80
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/mynginx created
```

```
sudo k3s kubectl get po
NAME                       READY   STATUS              RESTARTS   AGE
mynginx-568f57494d-8jpwq   0/1     ContainerCreating   0          69s
mynginx-568f57494d-czl9x   0/1     ContainerCreating   0          69s
mynginx-568f57494d-pnphb   0/1     ContainerCreating   0          69s
```

```
sudo k3s kubectl describe po mynginx-568f57494d-8jpwq
Name:           mynginx-568f57494d-8jpwq
Namespace:      default
Priority:       0
Node:           jetson-desktop/192.168.1.3
Start Time:     Mon, 07 Oct 2019 20:57:14 +0530
Labels:         pod-template-hash=568f57494d
                run=mynginx
Annotations:    <none>
Status:         Pending
IP:
Controlled By:  ReplicaSet/mynginx-568f57494d
Containers:
  mynginx:
    Container ID:
    Image:          nginx
    Image ID:
    Port:           80/TCP
    Host Port:      0/TCP
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-zjsrt (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
  PodScheduled      True
Volumes:
  default-token-zjsrt:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-zjsrt
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason     Age   From                     Message
  ----    ------     ----  ----                     -------
  Normal  Scheduled  98s   default-scheduler        Successfully assigned default/mynginx-568f57494d-8jpwq to jetson-desktop
  Normal  Pulling    94s   kubelet, jetson-desktop  Pulling image "nginx"
```

```
jetson@jetson-desktop:~$ sudo k3s kubectl get po
NAME                       READY   STATUS    RESTARTS   AGE
mynginx-568f57494d-pnphb   1/1     Running   0          113s
mynginx-568f57494d-czl9x   1/1     Running   0          113s
mynginx-568f57494d-8jpwq   1/1     Running   0          113s
jetson@jetson-desktop:~$
```

```
$ sudo k3s kubectl expose deployment mynginx --port 80
service/mynginx exposed
```

```
:~$ sudo k3s kubectl get endpoints mynginx
NAME      ENDPOINTS                                AGE
mynginx   10.42.0.6:80,10.42.0.7:80,10.42.0.8:80   27s
```


```
$ sudo curl 10.42.0.6
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
jetson@jetson
```

## Joining Nodes

I assume that the worker node hostname is "worker1.dell.com"

```
 sudo cat /var/lib/rancher/k3s/server/node-token
[sudo] password for jetson:
K1062243e4f7c5bef777a082ae9919d3d2bf13d446bff423275XXXXd08::node:a761a49be1XXXXXXc7c9cc7ccd9baaf
```

```
jetson@worker1:~$ sudo curl -sfL https://get.k3s.io | K3S_URL=https://master1.dell.com:6443 K3S_TOKEN=K10a2fa03edec41872f9b4068ddcfb9afaf329e24bf25ca33a0dc879b3e02ea9805::node:f9613e3b73d8184277493911ddca4e6a  sh -
[INFO]  Finding latest release
[INFO]  Using v0.9.1 as release
[INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v0.9.1/sha256sum-arm64.txt
[INFO]  Skipping binary downloaded, installed k3s matches hash
[INFO]  Skipping /usr/local/bin/kubectl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/crictl symlink to k3s, already exists
[INFO]  Skipping /usr/local/bin/ctr symlink to k3s, command exists in PATH at /usr/bin/ctr
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-agent-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s-agent.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s-agent.service
[INFO]  systemd: Enabling k3s-agent unit
Created symlink /etc/systemd/system/multi-user.target.wants/k3s-agent.service → /etc/systemd/system/k3s-agent.service.
[INFO]  systemd: Starting k3s-agent

```

```
jetson@master1:~$ sudo k3s kubectl get nodes
NAME               STATUS   ROLES    AGE     VERSION
master1.dell.com   Ready    master   7m45s   v1.15.4-k3s.1
worker1.dell.com   Ready    worker   24s     v1.15.4-k3s.1
jetson@master1:~$
```


# Uninstalling k3s

```
/usr/local/bin/k3s-uninstall.sh 
```

# K3s Dashboard

```
jetson@master1:~$ cat k3s-dashboard.yaml
apiVersion: v1
kind: ServiceAccount
metadata:
  name: admin-user
  namespace: kube-system

---

apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: admin-user
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: cluster-admin
subjects:
- kind: ServiceAccount
  name: admin-user
  namespace: kube-system
```

```
jetson@master1:~$ sudo k3s kubectl apply -f k3s-dashboard.yaml
serviceaccount/admin-user created
clusterrolebinding.rbac.authorization.k8s.io/admin-user created
jetson@master1:~$ cat k3s-dashboard.yaml



```
```
jetson@master1:~$ sudo k3s kubectl get po,svc,deploy -n kube-system
NAME                             READY   STATUS      RESTARTS   AGE
pod/coredns-66f496764-dgftj      1/1     Running     0          12m
pod/helm-install-traefik-skl9c   0/1     Completed   0          12m
pod/svclb-traefik-bxxpf          3/3     Running     0          11m
pod/traefik-d869575c8-wfnfx      1/1     Running     0          11m
pod/svclb-traefik-nkfms          3/3     Running     0          5m39s

NAME               TYPE           CLUSTER-IP      EXTERNAL-IP               PORT(S)                                     AGE
service/kube-dns   ClusterIP      10.43.0.10      <none>                    53/UDP,53/TCP,9153/TCP                      13m
service/traefik    LoadBalancer   10.43.213.124   192.168.1.3,192.168.1.6   80:32651/TCP,443:32650/TCP,8080:30917/TCP   11m

NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/coredns   1/1     1            1           13m
deployment.extensions/traefik   1/1     1            1           11m
```

```
sudo k3s kubectl proxy
Starting to serve on 127.0.0.1:8001
```

```
 sudo kubectl get po,deploy,svc -n kube-system
NAME                             READY   STATUS      RESTARTS   AGE
pod/coredns-66f496764-dgftj      1/1     Running     0          17m
pod/helm-install-traefik-skl9c   0/1     Completed   0          17m
pod/svclb-traefik-bxxpf          3/3     Running     0          16m
pod/traefik-d869575c8-wfnfx      1/1     Running     0          16m
pod/svclb-traefik-nkfms          3/3     Running     0          10m

NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/coredns   1/1     1            1           17m
deployment.extensions/traefik   1/1     1            1           16m

NAME               TYPE           CLUSTER-IP      EXTERNAL-IP               PORT(S)                                     AGE
service/kube-dns   ClusterIP      10.43.0.10      <none>                    53/UDP,53/TCP,9153/TCP                      17m
service/traefik    LoadBalancer   10.43.213.124   192.168.1.3,192.168.1.6   80:32651/TCP,443:32650/TCP,8080:30917/TCP   16m
```

