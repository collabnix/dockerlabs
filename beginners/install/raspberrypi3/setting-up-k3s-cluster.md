# Building up K3s Cluster

# Pre-requisite:

## Enable container features in Kernel

Edit ```/boot/cmdline.txt``` and add the following to the end of the line:

```
cgroup_enable=cpuset cgroup_memory=1 cgroup_enable=memory
```

Reboot the device.

## Installing K3s 

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

## Boostrapping Your K3s Server

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

In case you face issue shown below:

```

INFO[2019-04-04T15:52:43.736199140+05:30] Wrote kubeconfig /etc/rancher/k3s/k3s.yaml
INFO[2019-04-04T15:52:43.736433150+05:30] Run: k3s kubectl
INFO[2019-04-04T15:52:43.736514243+05:30] k3s is up and running
INFO[2019-04-04T15:52:44.708941793+05:30] Logging containerd to /var/lib/rancher/k3s/agent/containerd/containerd.log
INFO[2019-04-04T15:52:44.709420021+05:30] Running containerd -c /var/lib/rancher/k3s/agent/etc/containerd/config.toml -a /run/k3s/containerd/containerd.sock --state /run/k3s/containerd --root /var/lib/rancher/k3s/agent/containerd
INFO[2019-04-04T15:52:44.710450122+05:30] Waiting for containerd startup: rpc error: code = Unavailable desc = all SubConns are in TransientFailure, latest connection error: connection error: desc = "transport: Error while dialing dial unix /run/k3s/containerd/containerd.sock: connect: connection refused"
containerd: exit status 1
```
You can fix it by editing /etc/hosts and adding :

```
127.0.0.1       raspberrypi-node3
```




```
root@raspberrypi:~# sudo k3s kubectl get node -o wide
NAME          STATUS   ROLES    AGE     VERSION         INTERNAL-IP      EXTERNAL-IP   OS-IMAGE                         KERNEL-VERSION   CONTAINER-RUNTIME
raspberrypi   Ready    <none>   2m13s   v1.13.4-k3s.1   192.168.43.134   <none>        Raspbian GNU/Linux 9 (stretch)   4.14.98-v7+      containerd://1.2.4+unknown
```

# Listing K3s Nodes

```
root@raspberrypi:~# k3s kubectl get nodes
NAME          STATUS   ROLES    AGE     VERSION
raspberrypi   Ready    <none>   2m26s   v1.13.4-k3s.1
```

## Listing K3s Pods

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

## Cleaning Up Kubernetes Resources

```
#k3s kubectl delete po,svc,deploy --all
service "hypriot" deleted
service "kubernetes" delete
```


```
root@raspberrypi:~# k3s kubectl run mynginx --image=nginx --replicas=3 --port=80
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/mynginx created
```

```
root@raspberrypi:~# k3s kubectl get po
NAME                       READY   STATUS    RESTARTS   AGE
mynginx-84b8d48d44-ggpcp   1/1     Running   0          119s
mynginx-84b8d48d44-hkdg8   1/1     Running   0          119s
mynginx-84b8d48d44-n4r6q   1/1     Running   0          119s
```

```

root@raspberrypi:~# k3s kubectl expose deployment mynginx --port 80
service/mynginx exposed
```

```
root@raspberrypi:~# k3s kubectl get endpoints mynginx
NAME      ENDPOINTS                                   AGE
mynginx   10.42.0.10:80,10.42.0.11:80,10.42.0.12:80   17s
```

```
root@raspberrypi:~# curl 10.42.0.10:80
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
```

Adding a new Node to K3s Cluster

```
root@raspberrypi:~# cat /var/lib/rancher/k3s/server/node-token
K108b8e370b380bea959e8017abea3e540d1113f55df2c3f303ae771dc73fc67aa3::node:42e3dfc68ee27cf7cbdae5e4c8ac91b2
root@raspberrypi:~#
```

```
root@pi-node1:~# NODETOKEN=K108b8e370b380bea959e8017abea3e540d1113f55df2c3f303ae771dc73fc67aa3::node:42e3dfc68ee27cf7cbdae5e4c8ac91b2
root@pi-node1:~# k3s agent --server https://192.168.1.5:6443 --token ${NODETOKEN}
INFO[2019-04-04T23:09:16.804457435+05:30] Starting k3s agent v0.3.0 (9a1a1ec)
INFO[2019-04-04T23:09:19.563259194+05:30] Logging containerd to /var/lib/rancher/k3s/agent/containerd/containerd.log
INFO[2019-04-04T23:09:19.563629400+05:30] Running containerd -c /var/lib/rancher/k3s/agent/etc/containerd/config.toml -a /run/k3s/containerd/containerd.sock --state /run/k3s/containerd --root /var/lib/rancher/k3s/agent/containerd
INFO[2019-04-04T23:09:19.613809334+05:30] Connecting to wss://192.168.1.5:6443/v1-k3s/connect
INFO[2019-04-04T23:09:19.614108395+05:30] Connecting to proxy                           url="wss://192.168.1.5:6443/v1-k3s/connect"
FATA[2019-04-04T23:09:19.907450499+05:30] Failed to start tls listener: listen tcp 127.0.0.1:6445: bind: address already in use
root@pi-node1:~# pkill -9 k3s
root@pi-node1:~# k3s agent --server https://192.168.1.5:6443 --token ${NODETOKEN}
INFO[2019-04-04T23:09:45.843235117+05:30] Starting k3s agent v0.3.0 (9a1a1ec)
INFO[2019-04-04T23:09:48.272160155+05:30] Logging containerd to /var/lib/rancher/k3s/agent/containerd/containerd.log
INFO[2019-04-04T23:09:48.272542392+05:30] Running containerd -c /var/lib/rancher/k3s/agent/etc/containerd/config.toml -a /run/k3s/containerd/containerd.sock --state /run/k3s/containerd --root /var/lib/rancher/k3s/agent/containerd
INFO[2019-04-04T23:09:48.277538349+05:30] Waiting for containerd startup: rpc error: code = Unavailable desc = all SubConns are in TransientFailure, latest connection error: connection error: desc = "transport: Error while dialing dial unix /run/k3s/containerd/containerd.sock: connect: connection refused"
INFO[2019-04-04T23:09:49.321863688+05:30] Waiting for containerd startup: rpc error: code = Unknown desc = server is not initialized yet
INFO[2019-04-04T23:09:50.347628159+05:30] Connecting to wss://192.168.1.5:6443/v1-k3s/connect
INFO[2019-04-04T23:09:50.347925865+05:30] Connecting to proxy                           url="wss://192.168.1.5:6443/v1-k3s/connect"
WARN[2019-04-04T23:09:50.578318024+05:30] Disabling CPU quotas due to missing cpu.cfs_period_us
INFO[2019-04-04T23:09:50.578816562+05:30] Running kubelet --healthz-bind-address 127.0.0.1 --read-only-port 0 --allow-privileged=true --cluster-domain cluster.local --kubeconfig /var/lib/rancher/k3s/agent/kubeconfig.yaml --eviction-hard imagefs.available<5%,nodefs.available<5% --eviction-minimum-reclaim imagefs.available=10%,nodefs.available=10% --fail-swap-on=false --cgroup-driver cgroupfs --root-dir /var/lib/rancher/k3s/agent/kubelet --cert-dir /var/lib/rancher/k3s/agent/kubelet/pki --seccomp-profile-root /var/lib/rancher/k3s/agent/kubelet/seccomp --cni-conf-dir /var/lib/rancher/k3s/agent/etc/cni/net.d --cni-bin-dir /var/lib/rancher/k3s/data/e737b8b70ac9d19bd61626eed5131ce159e2e04bb75af26df5235fafa4bed87e/bin --cluster-dns 10.43.0.10 --resolv-conf /etc/resolv.conf --container-runtime remote --container-runtime-endpoint unix:///run/k3s/containerd/containerd.sock --address 127.0.0.1 --anonymous-auth=false --client-ca-file /var/lib/rancher/k3s/agent/client-ca.pem --hostname-override pi-node1 --cpu-cfs-quota=false --runtime-cgroups /systemd/user.slice/user-1000.slice --kubelet-cgroups /systemd/user.slice/user-1000.slice
Flag --allow-privileged has been deprecated, will be removed in a future version
W0404 23:09:50.580424    3318 server.go:198] WARNING: all flags other than --config, --write-config-to, and --cleanup are deprecated. Please begin using a config file ASAP.
I0404 23:09:50.657994    3318 server.go:393] Version: v1.13.5-k3s.1
E0404 23:09:50.795799    3318 machine.go:194] failed to get cache information for node 0: open /sys/devices/system/cpu/cpu0/cache: no such file or directory
I0404 23:09:50.800226    3318 server.go:630] --cgroups-per-qos enabled, but --cgroup-root was not specified.  defaulting to /
I0404 23:09:50.801424    3318 container_manager_linux.go:248] container manager verified user specified cgroup-root exists: []
I0404 23:09:50.801679    3318 container_manager_linux.go:253] Creating Container Manager object based on Node Config: {RuntimeCgroupsName:/systemd/user.slice/user-1000.slice SystemCgroupsName: KubeletCgroupsName:/systemd/user.slice/user-1000.slice ContainerRuntime:remote CgroupsPerQOS:true CgroupRoot:/ CgroupDriver:cgroupfs KubeletRootDir:/var/lib/rancher/k3s/agent/kubelet ProtectKernelDefaults:false NodeAllocatableConfig:{KubeReservedCgroupName: SystemReservedCgroupName: EnforceNodeAllocatable:map[pods:{}] KubeReserved:map[] SystemReserved:map[] HardEvictionThresholds:[{Signal:imagefs.available Operator:LessThan Value:{Quantity:<nil> Percentage:0.05} GracePeriod:0s MinReclaim:<nil>} {Signal:nodefs.available Operator:LessThan Value:{Quantity:<nil> Percentage:0.05} GracePeriod:0s MinReclaim:<nil>}]} QOSReserved:map[] ExperimentalCPUManagerPolicy:none ExperimentalCPUManagerReconcilePeriod:10s ExperimentalPodPidsLimit:-1 EnforceCPULimits:false CPUCFSQuotaPeriod:100ms}
I0404 23:09:50.802281    3318 container_manager_linux.go:272] Creating device plugin manager: true
I0404 23:09:50.802485    3318 state_mem.go:36] [cpumanager] initializing new in-memory state store
I0404 23:09:50.802953    3318 state_mem.go:84] [cpumanager] updated default cpuset: ""
I0404 23:09:50.803076    3318 state_mem.go:92] [cpumanager] updated cpuset assignments: "map[]"
I0404 23:09:50.803503    3318 kubelet.go:298] Watching apiserver
I0404 23:09:50.862224    3318 kuberuntime_manager.go:192] Container runtime containerd initialized, version: 1.2.4+unknown, apiVersion: v1alpha2
I0404 23:09:50.863717    3318 server.go:946] Started kubelet
I0404 23:09:50.890846    3318 fs_resource_analyzer.go:66] Starting FS ResourceAnalyzer
I0404 23:09:50.891054    3318 status_manager.go:152] Starting to sync pod status with apiserver
I0404 23:09:50.891153    3318 kubelet.go:1741] Starting kubelet main sync loop.
I0404 23:09:50.891254    3318 kubelet.go:1758] skipping pod synchronization - [container runtime status check may not have completed yet PLEG is not healthy: pleg has yet to be successful]
I0404 23:09:50.891668    3318 server.go:133] Starting to listen on 127.0.0.1:10250
I0404 23:09:50.896044    3318 server.go:318] Adding debug handlers to kubelet server.
E0404 23:09:50.910619    3318 cri_stats_provider.go:320] Failed to get the info of the filesystem with mountpoint "/var/lib/rancher/k3s/agent/containerd/io.containerd.snapshotter.v1.overlayfs": unable to find data in memory cache.
E0404 23:09:50.910752    3318 kubelet.go:1230] Image garbage collection failed once. Stats initialization may not have completed yet: invalid capacity 0 on image filesystem
I0404 23:09:50.970900    3318 volume_manager.go:248] Starting Kubelet Volume Manager
I0404 23:09:50.976227    3318 desired_state_of_world_populator.go:130] Desired state populator starts to run
I0404 23:09:50.991780    3318 kubelet.go:1758] skipping pod synchronization - [container runtime status check may not have completed yet]
W0404 23:09:51.042763    3318 util_unix.go:77] Using "/run/containerd/containerd.sock" as endpoint is deprecated, please consider using full url format "unix:///run/containerd/containerd.sock".
INFO[2019-04-04T23:09:51.049240713+05:30] waiting for node pi-node1: nodes "pi-node1" not found
W0404 23:09:51.054451    3318 nvidia.go:66] Error reading "/sys/bus/pci/devices/": open /sys/bus/pci/devices/: no such file or directory
E0404 23:09:51.071645    3318 kubelet.go:2173] node "pi-node1" not found
I0404 23:09:51.073017    3318 kubelet_node_status.go:268] Setting node annotation to enable volume controller attach/detach
I0404 23:09:51.083634    3318 kubelet_node_status.go:70] Attempting to register node pi-node1
E0404 23:09:51.180775    3318 kubelet.go:2173] node "pi-node1" not found
I0404 23:09:51.196245    3318 kubelet.go:1758] skipping pod synchronization - [container runtime status check may not have completed yet]
E0404 23:09:51.292768    3318 kubelet.go:2173] node "pi-node1" not found
W0404 23:09:51.314290    3318 node.go:103] Failed to retrieve node info: nodes "pi-node1" not found
I0404 23:09:51.314393    3318 server_others.go:149] Using iptables Proxier.
W0404 23:09:51.314715    3318 proxier.go:314] invalid nodeIP, initializing kube-proxy with 127.0.0.1 as nodeIP
I0404 23:09:51.343280    3318 server_others.go:179] Tearing down inactive rules.
E0404 23:09:51.350426    3318 proxier.go:236] Error removing userspace rule: error checking rule: exit status 2: iptables v1.6.2: Couldn't find target `KUBE-PORTALS-HOST'

Try `iptables -h' or 'iptables --help' for more information.
E0404 23:09:51.360962    3318 proxier.go:242] Error removing userspace rule: error checking rule: exit status 2: iptables v1.6.2: Couldn't find target `KUBE-PORTALS-CONTAINER'

Try `iptables -h' or 'iptables --help' for more information.
E0404 23:09:51.368285    3318 proxier.go:250] Error removing userspace rule: error checking rule: exit status 2: iptables v1.6.2: Couldn't find target `KUBE-NODEPORT-HOST'

Try `iptables -h' or 'iptables --help' for more information.
E0404 23:09:51.375915    3318 proxier.go:256] Error removing userspace rule: error checking rule: exit status 2: iptables v1.6.2: Couldn't find target `KUBE-NODEPORT-CONTAINER'

Try `iptables -h' or 'iptables --help' for more information.
E0404 23:09:51.394671    3318 proxier.go:263] Error removing userspace rule: error checking rule: exit status 2: iptables v1.6.2: Couldn't find target `KUBE-NODEPORT-NON-LOCAL'

Try `iptables -h' or 'iptables --help' for more information.
I0404 23:09:51.401336    3318 log.go:172] http: TLS handshake error from 10.42.0.5:37454: remote error: tls: bad certificate
E0404 23:09:51.404602    3318 kubelet.go:2173] node "pi-node1" not found
I0404 23:09:51.405125    3318 kubelet_node_status.go:73] Successfully registered node pi-node1
I0404 23:09:51.420337    3318 log.go:172] http: TLS handshake error from 10.42.0.5:37458: remote error: tls: bad certificate
I0404 23:09:51.439736    3318 log.go:172] http: TLS handshake error from 10.42.0.5:37456: remote error: tls: bad certificate
E0404 23:09:51.505643    3318 kubelet.go:2173] node "pi-node1" not found
I0404 23:09:51.598895    3318 kubelet.go:1758] skipping pod synchronization - [container runtime status check may not have completed yet]
E0404 23:09:51.603725    3318 proxier.go:583] Error removing iptables rules in ipvs proxier: error deleting chain "KUBE-MARK-MASQ": exit status 1: iptables: Too many links.
I0404 23:09:51.662653    3318 cpu_manager.go:155] [cpumanager] starting with none policy
I0404 23:09:51.662749    3318 cpu_manager.go:156] [cpumanager] reconciling every 10s
I0404 23:09:51.662795    3318 policy_none.go:42] [cpumanager] none policy: Start
W0404 23:09:51.667856    3318 container_manager_linux.go:815] CPUAccounting not enabled for pid: 3318
W0404 23:09:51.667925    3318 container_manager_linux.go:818] MemoryAccounting not enabled for pid: 3318
I0404 23:09:51.706568    3318 kuberuntime_manager.go:930] updating runtime config through cri with podcidr 10.42.1.0/24
I0404 23:09:51.709577    3318 kubelet_network.go:69] Setting Pod CIDR:  -> 10.42.1.0/24
W0404 23:09:52.399663    3318 pod_container_deletor.go:75] Container "7fde96a549c5a2a5736c67b8979c33e4080a3dd761a8f82ef5506d348fe0e7ff" not found in pod's containers
I0404 23:09:52.461248    3318 server.go:483] Version: v1.13.5-k3s.1
I0404 23:09:52.492765    3318 conntrack.go:52] Setting nf_conntrack_max to 131072
I0404 23:09:52.493792    3318 config.go:202] Starting service config controller
I0404 23:09:52.493896    3318 controller_utils.go:1027] Waiting for caches to sync for service config controller
I0404 23:09:52.494008    3318 config.go:102] Starting endpoints config controller
I0404 23:09:52.494067    3318 controller_utils.go:1027] Waiting for caches to sync for endpoints config controller
I0404 23:09:52.511743    3318 reconciler.go:154] Reconciler: start to sync state
I0404 23:09:52.598461    3318 controller_utils.go:1034] Caches are synced for endpoints config controller
I0404 23:09:52.674583    3318 reconciler.go:181] operationExecutor.UnmountVolume started for volume "default-token-hvh8w" (UniqueName: "kubernetes.io/secret/157d1460-5700-11e9-a800-b827eb014f4f-default-token-hvh8w") pod "157d1460-5700-11e9-a800-b827eb014f4f" (UID: "157d1460-5700-11e9-a800-b827eb014f4f")
I0404 23:09:52.675270    3318 reconciler.go:181] operationExecutor.UnmountVolume started for volume "config" (UniqueName: "kubernetes.io/configmap/160b8270-5700-11e9-a800-b827eb014f4f-config") pod "160b8270-5700-11e9-a800-b827eb014f4f" (UID: "160b8270-5700-11e9-a800-b827eb014f4f")
I0404 23:09:52.675727    3318 reconciler.go:181] operationExecutor.UnmountVolume started for volume "ssl" (UniqueName: "kubernetes.io/secret/160b8270-5700-11e9-a800-b827eb014f4f-ssl") pod "160b8270-5700-11e9-a800-b827eb014f4f" (UID: "160b8270-5700-11e9-a800-b827eb014f4f")
I0404 23:09:52.676132    3318 reconciler.go:181] operationExecutor.UnmountVolume started for volume "traefik-token-ls7z4" (UniqueName: "kubernetes.io/secret/160b8270-5700-11e9-a800-b827eb014f4f-traefik-token-ls7z4") pod "160b8270-5700-11e9-a800-b827eb014f4f" (UID: "160b8270-5700-11e9-a800-b827eb014f4f")
I0404 23:09:52.676392    3318 reconciler.go:181] operationExecutor.UnmountVolume started for volume "config-volume" (UniqueName: "kubernetes.io/configmap/555d0882-56ff-11e9-a800-b827eb014f4f-config-volume") pod "555d0882-56ff-11e9-a800-b827eb014f4f" (UID: "555d0882-56ff-11e9-a800-b827eb014f4f")
I0404 23:09:52.676633    3318 reconciler.go:181] operationExecutor.UnmountVolume started for volume "coredns-token-p9llh" (UniqueName: "kubernetes.io/secret/555d0882-56ff-11e9-a800-b827eb014f4f-coredns-token-p9llh") pod "555d0882-56ff-11e9-a800-b827eb014f4f" (UID: "555d0882-56ff-11e9-a800-b827eb014f4f")
I0404 23:09:52.684730    3318 operation_generator.go:687] UnmountVolume.TearDown succeeded for volume "kubernetes.io/configmap/160b8270-5700-11e9-a800-b827eb014f4f-config" (OuterVolumeSpecName: "config") pod "160b8270-5700-11e9-a800-b827eb014f4f" (UID: "160b8270-5700-11e9-a800-b827eb014f4f"). InnerVolumeSpecName "config". PluginName "kubernetes.io/configmap", VolumeGidValue ""
I0404 23:09:52.702397    3318 controller_utils.go:1034] Caches are synced for service config controller
I0404 23:09:52.720750    3318 operation_generator.go:687] UnmountVolume.TearDown succeeded for volume "kubernetes.io/configmap/555d0882-56ff-11e9-a800-b827eb014f4f-config-volume" (OuterVolumeSpecName: "config-volume") pod "555d0882-56ff-11e9-a800-b827eb014f4f" (UID: "555d0882-56ff-11e9-a800-b827eb014f4f"). InnerVolumeSpecName "config-volume". PluginName "kubernetes.io/configmap", VolumeGidValue ""
I0404 23:09:52.731482    3318 operation_generator.go:687] UnmountVolume.TearDown succeeded for volume "kubernetes.io/secret/160b8270-5700-11e9-a800-b827eb014f4f-ssl" (OuterVolumeSpecName: "ssl") pod "160b8270-5700-11e9-a800-b827eb014f4f" (UID: "160b8270-5700-11e9-a800-b827eb014f4f"). InnerVolumeSpecName "ssl". PluginName "kubernetes.io/secret", VolumeGidValue ""
I0404 23:09:52.733636    3318 operation_generator.go:687] UnmountVolume.TearDown succeeded for volume "kubernetes.io/secret/157d1460-5700-11e9-a800-b827eb014f4f-default-token-hvh8w" (OuterVolumeSpecName: "default-token-hvh8w") pod "157d1460-5700-11e9-a800-b827eb014f4f" (UID: "157d1460-5700-11e9-a800-b827eb014f4f"). InnerVolumeSpecName "default-token-hvh8w". PluginName "kubernetes.io/secret", VolumeGidValue ""
I0404 23:09:52.734790    3318 operation_generator.go:687] UnmountVolume.TearDown succeeded for volume "kubernetes.io/secret/555d0882-56ff-11e9-a800-b827eb014f4f-coredns-token-p9llh" (OuterVolumeSpecName: "coredns-token-p9llh") pod "555d0882-56ff-11e9-a800-b827eb014f4f" (UID: "555d0882-56ff-11e9-a800-b827eb014f4f"). InnerVolumeSpecName "coredns-token-p9llh". PluginName "kubernetes.io/secret", VolumeGidValue ""
I0404 23:09:52.752070    3318 operation_generator.go:687] UnmountVolume.TearDown succeeded for volume "kubernetes.io/secret/160b8270-5700-11e9-a800-b827eb014f4f-traefik-token-ls7z4" (OuterVolumeSpecName: "traefik-token-ls7z4") pod "160b8270-5700-11e9-a800-b827eb014f4f" (UID: "160b8270-5700-11e9-a800-b827eb014f4f"). InnerVolumeSpecName "traefik-token-ls7z4". PluginName "kubernetes.io/secret", VolumeGidValue ""
I0404 23:09:52.777153    3318 reconciler.go:285] Volume detached for volume "coredns-token-p9llh" (UniqueName: "kubernetes.io/secret/555d0882-56ff-11e9-a800-b827eb014f4f-coredns-token-p9llh") on node "pi-node1" DevicePath ""
I0404 23:09:52.777793    3318 reconciler.go:285] Volume detached for volume "default-token-hvh8w" (UniqueName: "kubernetes.io/secret/157d1460-5700-11e9-a800-b827eb014f4f-default-token-hvh8w") on node "pi-node1" DevicePath ""
I0404 23:09:52.778216    3318 reconciler.go:285] Volume detached for volume "config" (UniqueName: "kubernetes.io/configmap/160b8270-5700-11e9-a800-b827eb014f4f-config") on node "pi-node1" DevicePath ""
I0404 23:09:52.778563    3318 reconciler.go:285] Volume detached for volume "ssl" (UniqueName: "kubernetes.io/secret/160b8270-5700-11e9-a800-b827eb014f4f-ssl") on node "pi-node1" DevicePath ""
I0404 23:09:52.778781    3318 reconciler.go:285] Volume detached for volume "traefik-token-ls7z4" (UniqueName: "kubernetes.io/secret/160b8270-5700-11e9-a800-b827eb014f4f-traefik-token-ls7z4") on node "pi-node1" DevicePath ""
I0404 23:09:52.781602    3318 reconciler.go:285] Volume detached for volume "config-volume" (UniqueName: "kubernetes.io/configmap/555d0882-56ff-11e9-a800-b827eb014f4f-config-volume") on node "pi-node1" DevicePath ""
I0404 23:09:53.137727    3318 flannel.go:89] Determining IP address of default interface
I0404 23:09:53.139415    3318 flannel.go:99] Using interface with name wlan0 and address 192.168.1.6
I0404 23:09:53.147803    3318 kube.go:306] Starting kube subnet manager
I0404 23:09:53.151856    3318 kube.go:127] Waiting 10m0s for node controller to sync
E0404 23:09:53.980007    3318 kuberuntime_container.go:71] Can't make a ref to pod "svclb-traefik-8b58f74c5-7pwnt_kube-system(157d1460-5700-11e9-a800-b827eb014f4f)", container lb-port-80: selfLink was empty, can't make reference
I0404 23:09:54.152257    3318 kube.go:134] Node controller sync successful
I0404 23:09:54.152576    3318 vxlan.go:120] VXLAN config: VNI=1 Port=0 GBP=false DirectRouting=false
I0404 23:09:54.315194    3318 flannel.go:75] Wrote subnet file to /run/flannel/subnet.env
I0404 23:09:54.317508    3318 flannel.go:79] Running backend.
I0404 23:09:54.318331    3318 vxlan_network.go:60] watching for new subnet leases
E0404 23:09:54.322798    3318 vxlan_network.go:158] failed to add vxlanRoute (10.42.0.0/24 -> 10.42.0.0): invalid argument
E0404 23:09:54.356850    3318 kuberuntime_container.go:71] Can't make a ref to pod "coredns-7748f7f6df-js5q7_kube-system(555d0882-56ff-11e9-a800-b827eb014f4f)", container coredns: selfLink was empty, can't make reference
I0404 23:09:54.362407    3318 iptables.go:145] Some iptables rules are missing; deleting and recreating rules
I0404 23:09:54.362533    3318 iptables.go:167] Deleting iptables rule: -s 10.42.0.0/16 -d 10.42.0.0/16 -j RETURN
I0404 23:09:54.371953    3318 iptables.go:167] Deleting iptables rule: -s 10.42.0.0/16 ! -d 224.0.0.0/4 -j MASQUERADE --random-fully
I0404 23:09:54.380616    3318 iptables.go:167] Deleting iptables rule: ! -s 10.42.0.0/16 -d 10.42.1.0/24 -j RETURN
I0404 23:09:54.389774    3318 iptables.go:167] Deleting iptables rule: ! -s 10.42.0.0/16 -d 10.42.0.0/16 -j MASQUERADE --random-fully
I0404 23:09:54.400828    3318 iptables.go:155] Adding iptables rule: -s 10.42.0.0/16 -d 10.42.0.0/16 -j RETURN
I0404 23:09:54.420245    3318 iptables.go:155] Adding iptables rule: -s 10.42.0.0/16 ! -d 224.0.0.0/4 -j MASQUERADE --random-fully
I0404 23:09:54.436049    3318 iptables.go:155] Adding iptables rule: ! -s 10.42.0.0/16 -d 10.42.1.0/24 -j RETURN
I0404 23:09:54.455119    3318 iptables.go:155] Adding iptables rule: ! -s 10.42.0.0/16 -d 10.42.0.0/16 -j MASQUERADE --random-fully

```

## Listing the k3s Nodes

```
root@raspberrypi:~# k3s kubectl get nodes
NAME       STATUS   ROLES    AGE    VERSION
pi-node1   Ready    <none>   118s   v1.13.5-k3s.1
pi-node2   Ready    <none>   108m   v1.13.5-k3s.1
```

## Setting up Nginx

```
root@raspberrypi:~# k3s kubectl run mynginx --image=nginx --replicas=3 --port=80
kubectl run --generator=deployment/apps.v1 is DEPRECATED and will be removed in a future version. Use kubectl run --generator=run-pod/v1 or kubectl create instead.
deployment.apps/mynginx created
```
```
root@raspberrypi:~# k3s kubectl expose deployment mynginx --port 80
service/mynginx exposed
```

```
kubectl delete --all pods
pod "mynginx-84b8d48d44-9ghrl" deleted
pod "mynginx-84b8d48d44-bczsv" deleted
pod "mynginx-84b8d48d44-qqk9p" deleted
```


