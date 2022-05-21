# Boot up Raspberry Pi 3 with Hypriot

# Installing a Single Node K8s cluster on Pi box

```
root@black-pearl:~/play-with-docker# echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" > /etc/apt/sources.list.d/kubernetes.list
```

```
root@black-pearl:~/play-with-docker# apt-get update && apt-get install -y kubeadm
Ign:1 http://deb.debian.org/debian stretch InRelease
Hit:2 http://deb.debian.org/debian stretch-updates InRelease
Hit:3 http://deb.debian.org/debian stretch Release
Hit:5 http://security.debian.org stretch/updates InRelease
Hit:4 https://packages.cloud.google.com/apt kubernetes-xenial InRelease
Reading package lists... Done
Reading package lists... Done
Building dependency tree
Reading state information... Done
The following packages were automatically installed and are no longer required:
  python-boto python-cffi python-cffi-backend python-chardet python-cheetah python-configobj python-cryptography
  python-enum34 python-idna python-ipaddress python-json-pointer python-jsonpatch python-ndg-httpsclient python-oauth
  python-openssl python-pkg-resources python-ply python-prettytable python-pyasn1 python-pycparser python-requests
  python-serial python-setuptools python-six python-software-properties python-support python-urllib3 python-yaml
  python3-apt unattended-upgrades
Use 'sudo apt autoremove' to remove them.
The following additional packages will be installed:
  ebtables kubectl kubelet kubernetes-cni socat
The following NEW packages will be installed:
  ebtables kubeadm kubectl kubelet kubernetes-cni socat
0 upgraded, 6 newly installed, 0 to remove and 0 not upgraded.
Need to get 42.2 MB/47.7 MB of archives.
After this operation, 366 MB of additional disk space will be used.
Get:1 https://packages.cloud.google.com/apt kubernetes-xenial/main arm64 kubelet arm64 1.8.4-00 [17.7 MB]
Get:2 https://packages.cloud.google.com/apt kubernetes-xenial/main arm64 kubectl arm64 1.8.4-00 [7,805 kB]
Get:3 https://packages.cloud.google.com/apt kubernetes-xenial/main arm64 kubeadm arm64 1.8.4-00 [16.7 MB]
Fetched 42.2 MB in 1min 27s (484 kB/s)
Selecting previously unselected package ebtables.
(Reading database ... 21695 files and directories currently installed.)
Preparing to unpack .../0-ebtables_2.0.10.4-3.5+b1_arm64.deb ...
Unpacking ebtables (2.0.10.4-3.5+b1) ...
Selecting previously unselected package kubernetes-cni.
Preparing to unpack .../1-kubernetes-cni_0.5.1-00_arm64.deb ...
Unpacking kubernetes-cni (0.5.1-00) ...
Selecting previously unselected package socat.
Preparing to unpack .../2-socat_1.7.3.1-2+deb9u1_arm64.deb ...
Unpacking socat (1.7.3.1-2+deb9u1) ...
Selecting previously unselected package kubelet.
Preparing to unpack .../3-kubelet_1.8.4-00_arm64.deb ...
Unpacking kubelet (1.8.4-00) ...
Selecting previously unselected package kubectl.
Preparing to unpack .../4-kubectl_1.8.4-00_arm64.deb ...
Unpacking kubectl (1.8.4-00) ...
Selecting previously unselected package kubeadm.
Preparing to unpack .../5-kubeadm_1.8.4-00_arm64.deb ...
Unpacking kubeadm (1.8.4-00) ...
Setting up kubernetes-cni (0.5.1-00) ...
Setting up socat (1.7.3.1-2+deb9u1) ...
Processing triggers for systemd (232-25+deb9u1) ...
Setting up ebtables (2.0.10.4-3.5+b1) ...
Created symlink /etc/systemd/system/multi-user.target.wants/ebtables.service → /lib/systemd/system/ebtables.service.
update-rc.d: warning: start and stop actions are no longer supported; falling back to defaults
Setting up kubectl (1.8.4-00) ...
Processing triggers for man-db (2.7.6.1-2) ...
Setting up kubelet (1.8.4-00) ...
Created symlink /etc/systemd/system/multi-user.target.wants/kubelet.service → /lib/systemd/system/kubelet.service.
Setting up kubeadm (1.8.4-00) ...
Processing triggers for systemd (232-25+deb9u1) ...
```

# Initializing the Master Node

```
root@black-pearl:~/play-with-docker# kubeadm init --pod-network-cidr 10.244.0.0/16
[kubeadm] WARNING: kubeadm is in beta, please do not use it for production clusters.
[init] Using Kubernetes version: v1.8.4
[init] Using Authorization modes: [Node RBAC]
[preflight] Running pre-flight checks
[preflight] WARNING: docker version is greater than the most recently validated version. Docker version: 17.11.0-ce. Max validated version: 17.03
[kubeadm] WARNING: starting in 1.8, tokens expire after 24 hours by default (if you require a non-expiring token use --token-ttl 0)

[certificates] Generated ca certificate and key.
[certificates] Generated apiserver certificate and key.
[certificates] apiserver serving cert is signed for DNS names [black-pearl kubernetes kubernetes.default kubernetes.default.svc kubernetes.default.svc.cluster.local] and IPs [10.96.0.1 192.168.1.4]
[certificates] Generated apiserver-kubelet-client certificate and key.
[certificates] Generated sa key and public key.
[certificates] Generated front-proxy-ca certificate and key.
[certificates] Generated front-proxy-client certificate and key.
[certificates] Valid certificates and keys now exist in "/etc/kubernetes/pki"
[kubeconfig] Wrote KubeConfig file to disk: "admin.conf"
[kubeconfig] Wrote KubeConfig file to disk: "kubelet.conf"
[kubeconfig] Wrote KubeConfig file to disk: "controller-manager.conf"
[kubeconfig] Wrote KubeConfig file to disk: "scheduler.conf"
[controlplane] Wrote Static Pod manifest for component kube-apiserver to "/etc/kubernetes/manifests/kube-apiserver.yaml"
[controlplane] Wrote Static Pod manifest for component kube-controller-manager to "/etc/kubernetes/manifests/kube-controller-manager.yaml"
[controlplane] Wrote Static Pod manifest for component kube-scheduler to "/etc/kubernetes/manifests/kube-scheduler.yaml"
[etcd] Wrote Static Pod manifest for a local etcd instance to "/etc/kubernetes/manifests/etcd.yaml"
[init] Waiting for the kubelet to boot up the control plane as Static Pods from directory "/etc/kubernetes/manifests"
[init] This often takes around a minute; or longer if the control plane images have to be pulled.

Your Kubernetes master has initialized successfully!

To start using your cluster, you need to run (as a regular user):

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  http://kubernetes.io/docs/admin/addons/

You can now join any number of machines by running the following on each node
as root:

  kubeadm join --token c8fc2e.c7a6295eac446da3 192.168.1.4:6443 --discovery-token-ca-cert-hash sha256:f396aea5748424a6a2907c3c432383b6a53ce944b307a17915a662139b6def55

```

```
root@black-pearl:~/play-with-docker# curl -sSL https://rawgit.com/coreos/flannel/v0.7.1/Documentation/kube-flannel-rbac.yml | kubectl create -f -
clusterrole "flannel" created
clusterrolebinding "flannel" created

```

```
root@black-pearl:~/play-with-docker# curl -sSL https://rawgit.com/coreos/flannel/v0.7.1/Documentation/kube-flannel.yml | sed "s/amd64/arm/g" | kubectl create -f -
serviceaccount "flannel" created
configmap "kube-flannel-cfg" created
daemonset "kube-flannel-ds" created

```

```
root@black-pearl:~/play-with-docker# kubectl get po --all-namespaces
NAMESPACE     NAME                                  READY     STATUS    RESTARTS   AGE
kube-system   etcd-black-pearl                      1/1       Running   0          5m
kube-system   kube-apiserver-black-pearl            1/1       Running   0          5m
kube-system   kube-controller-manager-black-pearl   1/1       Running   0          5m
kube-system   kube-dns-596cf7c484-kflg4             0/3       Pending   0          5m
kube-system   kube-proxy-zhk67                      1/1       Running   0          5m
kube-system   kube-scheduler-black-pearl            1/1       Running   0          4m
root@black-pearl:~/play-with-docker#

```

```
root@black-pearl:~/play-with-docker# kubectl run hypriot --image=hypriot/rpi-busybox-httpd --replicas=3 --port=80
deployment "hypriot" created

```
```
root@black-pearl:~/play-with-docker# kubectl expose deployment hypriot --port 80
service "hypriot" exposed
root@black-pearl:~/play-with-docker#

```
