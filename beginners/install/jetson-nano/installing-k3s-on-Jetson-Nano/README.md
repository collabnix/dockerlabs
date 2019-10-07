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
jetson@jetson-desktop:~$ sudo cat /boot/cmdline.txt
dwc_otg.lpm_enable=0 console=tty1 console=ttyAMA0,115200 root=/dev/mmcblk0p7 rootfstype=ext4 elevator=deadline rootwait fbcon=map:10 fbcon=font:ProFont6x11 logo.nologo
```

```
jetson@jetson-desktop:~$ sudo curl -sfL https://get.k3s.io | sh -
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
jetson@jetson-desktop:~$
```

```
jetson@jetson-desktop:~$ sudo k3s kubectl get node -o wide
NAME             STATUS   ROLES    AGE     VERSION         INTERNAL-IP   EXTERNAL-IP   OS-IMAGE             KERNEL-VERSION   CONTAINER-RUNTIME
jetson-desktop   Ready    master   3m55s   v1.15.4-k3s.1   192.168.1.3   <none>        Ubuntu 18.04.2 LTS   4.9.140-tegra    containerd://1.2.8-k3s.1
jetson@jetson-desktop:~$
```

```
jetson@jetson-desktop:~$ sudo k3s kubectl get nodes
NAME             STATUS   ROLES    AGE   VERSION
jetson-desktop   Ready    master   71m   v1.15.4-k3s.1

```

```
jetson@jetson-desktop:~$ sudo k3s kubectl run mynginx --image=nginx --replicas=3 --port=80
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
Error from server (InternalError): Internal error occurred: resource quota evaluates timeout
jetson@jetson-desktop:~$ sudo k3s kubectl get po,svc,deploy
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
jetson@jetson-desktop:~$ sudo iptables -L
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
jetson@jetson-desktop:~$ sudo k3s kubectl get po,svc,deploy

NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   57s

jetson@jetson-desktop:~$
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


