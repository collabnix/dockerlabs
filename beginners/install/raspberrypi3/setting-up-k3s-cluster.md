# Building up K3s Cluster

## Pre-requisite:

## Enable container features in Kernel

Edit ```/boot/cmdline.txt``` and add the following to the end of the line:

```
cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory
```

Reboot the device.


```
root@raspberrypi:~# curl -sfL https://get.k3s.io | sh -
[INFO]  Finding latest release
[INFO]  Using v0.2.0 as release
[INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v0.2.0/sha256sum-arm.txt
[INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v0.2.0/k3s-armhf
^Croot@raspberrypi:~# wget https://github.com/rancher/k3s/releases/download/v0.2.0/k3s-mhf && \
>   chmod +x k3s-armhf && \
>   sudo mv k3s-armhf /usr/local/bin/k3s
--2019-03-28 22:47:22--  https://github.com/rancher/k3s/releases/download/v0.2.0/k3s-armhf
Resolving github.com (github.com)... 192.30.253.112, 192.30.253.113
Connecting to github.com (github.com)|192.30.253.112|:443... connected.
HTTP request sent, awaiting response... 302 Found
Location: https://github-production-release-asset-2e65be.s3.amazonaws.com/135516270/4010d900-41db-11e9-9992-cc2248364eac?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20190328%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20190328T171725Z&X-Amz-Expires=300&X-Amz-Signature=75c5a361f0219d443dfa0754250c852257f1b8512e54094da0bcc6fbb92327cc&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dk3s-armhf&response-content-type=application%2Foctet-stream [following]
--2019-03-28 22:47:25--  https://github-production-release-asset-2e65be.s3.amazonaws.com/135516270/4010d900-41db-11e9-9992-cc2248364eac?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20190328%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20190328T171725Z&X-Amz-Expires=300&X-Amz-Signature=75c5a361f0219d443dfa0754250c852257f1b8512e54094da0bcc6fbb92327cc&X-Amz-SignedHeaders=host&actor_id=0&response-content-disposition=attachment%3B%20filename%3Dk3s-armhf&response-content-type=application%2Foctet-stream
Resolving github-production-release-asset-2e65be.s3.amazonaws.com (github-production-release-asset-2e65be.s3.amazonaws.com)... 52.216.0.56
Connecting to github-production-release-asset-2e65be.s3.amazonaws.com (github-production-release-asset-2e65be.s3.amazonaws.com)|52.216.0.56|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 34684224 (33M) [application/octet-stream]
Saving to: ‘k3s-armhf’

k3s-armhf             100%[========================>]  33.08M  93.1KB/s    in 8m 1s

2019-03-28 22:55:28 (70.4 KB/s) - ‘k3s-armhf’ saved [34684224/34684224]


```


```
root@raspberrypi:~# sudo k3s server
INFO[2019-03-29T10:52:06.995054811+05:30] Starting k3s v0.2.0 (2771ae1)
INFO[2019-03-29T10:52:07.082595332+05:30] Running kube-apiserver --watch-cache=false --cert-dir /var/lib/rancher/k3s/server/tls/temporary-certs --allow-privileged=true --authorization-mode Node,RBAC --service-account-signing-key-file /var/lib/rancher/k3s/server/tls/service.key --service-cluster-ip-range 10.43.0.0/16 --advertise-port 6445 --advertise-address 127.0.0.1 --insecure-port 0 --secure-port 6444 --bind-address 127.0.0.1 --tls-cert-file /var/lib/rancher/k3s/server/tls/localhost.crt --tls-private-key-file /var/lib/rancher/k3s/server/tls/localhost.key --service-account-key-file /var/lib/rancher/k3s/server/tls/service.key --service-account-issuer k3s --api-audiences unknown --basic-auth-file /var/lib/rancher/k3s/server/cred/passwd --kubelet-client-certificate /var/lib/rancher/k3s/server/tls/token-node.crt --kubelet-client-key /var/lib/rancher/k3s/server/tls/token-node.key
INFO[2019-03-29T10:52:08.094785384+05:30] Running kube-scheduler --kubeconfig /var/lib/rancher/k3s/server/cred/kubeconfig-system.yaml --port 10251 --address 127.0.0.1 --secure-port 0 --leader-elect=false
INFO[2019-03-29T10:52:08.105366477+05:30] Running kube-controller-manager --kubeconfig /var/lib/rancher/k3s/server/cred/kubeconfig-system.yaml --service-account-private-key-file /var/lib/rancher/k3s/server/tls/service.key --allocate-node-cidrs --cluster-cidr 10.42.0.0/16 --root-ca-file /var/lib/rancher/k3s/server/tls/token-ca.crt --port 10252 --address 127.0.0.1 --secure-port 0 --leader-elect=false
Flag --address has been deprecated, see --bind-address instead.
INFO[2019-03-29T10:52:10.410557414+05:30] Listening on :6443
INFO[2019-03-29T10:52:10.519075956+05:30] Node token is available at /var/lib/rancher/k3s/server/node-token
INFO[2019-03-29T10:52:10.519226216+05:30] To join node to cluster: k3s agent -s https://192.168.43.134:6443 -t ${NODE_TOKEN}
INFO[2019-03-29T10:52:10.543022102+05:30] Writing manifest: /var/lib/rancher/k3s/server/manifests/coredns.yaml
INFO[2019-03-29T10:52:10.548766216+05:30] Writing manifest: /var/lib/rancher/k3s/server/manifests/traefik.yaml
```

```
root@raspberrypi:~# sudo k3s kubectl get node -o wide
NAME          STATUS   ROLES    AGE     VERSION         INTERNAL-IP      EXTERNAL-IP   OS-IMAGE                         KERNEL-VERSION   CONTAINER-RUNTIME
raspberrypi   Ready    <none>   2m13s   v1.13.4-k3s.1   192.168.43.134   <none>        Raspbian GNU/Linux 9 (stretch)   4.14.98-v7+      containerd://1.2.4+unknown
```

```
root@raspberrypi:~# k3s kubectl get nodes
NAME          STATUS   ROLES    AGE     VERSION
raspberrypi   Ready    <none>   2m26s   v1.13.4-k3s.1
```

```
root@raspberrypi:~# k3s kubectl get po
No resources found.
```

```
root@raspberrypi:~# k3s kubectl get po,svc,deploy
NAME                 TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
service/kubernetes   ClusterIP   10.43.0.1    <none>        443/TCP   11h
root@raspberrypi:~#
```


