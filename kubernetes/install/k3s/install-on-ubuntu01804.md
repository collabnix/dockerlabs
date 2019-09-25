# How to install K3s on Ubuntu 18.04

```
:~$ sudo curl -sfL https://get.k3s.io | sh -
[sudo] password for dell:
[INFO]  Finding latest release
[INFO]  Using v0.9.0 as release
[INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v0.9.0/sha256sum-amd64.txt
[INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v0.9.0/k3s
[INFO]  Verifying binary download
[INFO]  Installing k3s to /usr/local/bin/k3s
[INFO]  Creating /usr/local/bin/kubectl symlink to k3s
[INFO]  Creating /usr/local/bin/crictl symlink to k3s
[INFO]  Creating /usr/local/bin/ctr symlink to k3s
[INFO]  Creating killall script /usr/local/bin/k3s-killall.sh
[INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
[INFO]  env: Creating environment file /etc/systemd/system/k3s.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
[INFO]  systemd: Enabling k3s unit
Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
[INFO]  systemd: Starting k3s
```

```
dell@dell-virtual-machine:~$ sudo k3s kubectl get nodes
NAME                   STATUS   ROLES    AGE     VERSION
dell-virtual-machine   Ready    master   4m22s   v1.15.4-k3s.1
~$
```

