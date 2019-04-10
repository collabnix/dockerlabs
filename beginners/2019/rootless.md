# Testing rootless Docker

## Installing Rootless Docker

### Pre-requisite:

- Create Ubuntu 18.10 instance
- Run apt update

```
cat <<EOF | sudo sh -x
apt-get install -y uidmap
EOF
```

```
$ curl -sSL https://get.docker.com/rootless | sh


$ curl -sSL https://get.docker.com/rootless | sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 59.8M  100 59.8M    0     0  28.9M      0  0:00:02  0:00:02 --:--:-- 28.9M
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 14.0M  100 14.0M    0     0  8982k      0  0:00:01  0:00:01 --:--:-- 8976k
# starting systemd service
● docker.service - Docker Application Container Engine (Rootless)
   Loaded: loaded (/home/tanvirkour1985/.config/systemd/user/docker.service; disabled; vendor preset: enabled)
   Active: active (running) since Wed 2019-04-10 16:59:34 UTC; 20ms ago
     Docs: https://docs.docker.com
 Main PID: 3173 (dockerd-rootles)
   CGroup: /user.slice/user-1001.slice/user@1001.service/docker.service
           ├─3173 /bin/sh /home/tanvirkour1985/bin/dockerd-rootless.sh --experimental --storage-driver=overlay
           └─3180 rootlesskit --net=vpnkit --mtu=1500 --disable-host-loopback --port-driver=builtin --copy-up=/etc --copy-up=/run /home/tanvirkour19
85/bin/dockerd-rootless.sh --experimental --storage-driver=overlay
Apr 10 16:59:34 node3 dockerd-rootless.sh[3173]: + which slirp4netns
Apr 10 16:59:34 node3 dockerd-rootless.sh[3173]: + [ -z ]
Apr 10 16:59:34 node3 dockerd-rootless.sh[3173]: + which vpnkit
Apr 10 16:59:34 node3 dockerd-rootless.sh[3173]: + net=vpnkit
Apr 10 16:59:34 node3 dockerd-rootless.sh[3173]: + mtu=1500
Apr 10 16:59:34 node3 dockerd-rootless.sh[3173]: + [ -z ]
Apr 10 16:59:34 node3 dockerd-rootless.sh[3173]: + _DOCKERD_ROOTLESS_CHILD=1
Apr 10 16:59:34 node3 dockerd-rootless.sh[3173]: + export _DOCKERD_ROOTLESS_CHILD
Apr 10 16:59:34 node3 dockerd-rootless.sh[3173]: + rootlesskit --net=vpnkit --mtu=1500 --disable-host-loopback --port-driver=builtin --copy-up=/etc 
--copy-up=/run /home/tanvirkour1985/bin/dockerd-rootless.sh --experimental --storage-driver=overlay
Apr 10 16:59:34 node3 dockerd-rootless.sh[3173]: time="2019-04-10T16:59:34Z" level=warning msg="\"builtin\" port driver is experimental"
Client:
 Version:           master-dockerproject-2019-04-09
 API version:       1.40
 Go version:        go1.12.2
 Git commit:        d6af3e14
 Built:             Tue Apr  9 23:39:29 2019
 OS/Arch:           linux/amd64
 Experimental:      false
Server:
 Engine:
  Version:          master-dockerproject-2019-04-09
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.12.2
  Git commit:       ed68d3a
  Built:            Tue Apr  9 23:46:51 2019
  OS/Arch:          linux/amd64
  Experimental:     true
 containerd:
  Version:          v1.2.6
  GitCommit:        894b81a4b802e4eb2a91d1ce216b8817763c29fb
 runc:
  Version:          1.0.0-rc7+dev
  GitCommit:        029124da7af7360afa781a0234d1b083550f797c
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
# Docker binaries are installed in /home/tanvirkour1985/bin
# WARN: dockerd is not in your current PATH or pointing to /home/tanvirkour1985/bin/dockerd
# Make sure the following environment variables are set (or add them to ~/.bashrc):
export PATH=/home/tanvirkour1985/bin:$PATH
export DOCKER_HOST=unix:///run/user/1001/docker.sock
#
# To control docker service run:
# systemctl --user (start|stop|restart) docker
#
```


