# Docker for Mac is built with LinuxKit. 


## How to enter into LinuxKit VM?



```
$screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty
```


```
/ # cat /etc/issue

Welcome to LinuxKit

                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
          {                       /  ===-
           \______ O           __/
             \    \         __/
              \____\_______/
```
```
/ # cat /etc/os-release
PRETTY_NAME="Docker for Mac"
/ #
```

```
linuxkit-025000000001:~# cat /etc/os-release
PRETTY_NAME="Docker for Mac"
linuxkit-025000000001:~# runc list
ID                 PID         STATUS      BUNDLE                                CREATED                          OWNER
000-metadata       0           stopped     /containers/onboot/000-metadata       2018-05-05T06:27:44.345735031Z   root
001-sysfs          0           stopped     /containers/onboot/001-sysfs          2018-05-05T06:27:44.768313965Z   root
002-binfmt         0           stopped     /containers/onboot/002-binfmt         2018-05-05T06:27:45.630283593Z   root
003-format         0           stopped     /containers/onboot/003-format         2018-05-05T06:27:46.341011253Z   root
004-extend         0           stopped     /containers/onboot/004-extend         2018-05-05T06:27:47.08889973Z    root
005-mount          0           stopped     /containers/onboot/005-mount          2018-05-05T06:27:55.334088074Z   root
006-swap           0           stopped     /containers/onboot/006-swap           2018-05-05T06:27:56.486815308Z   root
007-ip             0           stopped     /containers/onboot/007-ip             2018-05-05T06:28:03.894591249Z   root
008-move-logs      0           stopped     /containers/onboot/008-move-logs      2018-05-05T06:28:05.980232896Z   root
009-sysctl         0           stopped     /containers/onboot/009-sysctl         2018-05-05T06:28:06.15775421Z    root
010-mount-vpnkit   0           stopped     /containers/onboot/010-mount-vpnkit   2018-05-05T06:28:06.356833391Z   root
011-bridge         0           stopped     /containers/onboot/011-bridge         2018-05-05T06:28:06.551619273Z   root
linuxkit-025000000001:~# ctr tasks ls
```

## Entering into VM using nsenter Container


nsenter allows you to enter a shell in a running container (technically into the namespaces that provide a container's isolation and limited access to system resources). The crazy thing is that this image allows you to run a privileged container that runs nsenter for the process space running as pid 1. How is this useful?


Well, this is useful when you are running a lightweight, container-optimized Linux distribution such as LinuxKit. Here is one simple example: say you want to teach a few people about Docker networking and you want to show them how to inspect the default bridge network after starting two containers using ip addr show; the problem is if you are demonstrating with Docker for Mac, for example, your containers are not running on your host directly, but are running instead inside of a minimal Linux OS virtual machine specially built for running containers, i.e., LinuxKit. But being a lightweight environment, LinuxKit isn't running sshd, so how do you get access to a shell so you can run nsenter to inspect the namespaces for the process running as pid 1?


```
docker run -it --rm --privileged --pid=host justincormack/nsenter1
```

```
/ # cat /etc/issue

Welcome to LinuxKit

                        ##         .
                  ## ## ##        ==
               ## ## ## ## ##    ===
           /"""""""""""""""""\___/ ===
          {                       /  ===-
           \______ O           __/
             \    \         __/
              \____\_______/
```
```
/ # cat /etc/os-release
PRETTY_NAME="Docker for Mac"
/ #
```

```
linuxkit-025000000001:~# cat /etc/os-release
PRETTY_NAME="Docker for Mac"
linuxkit-025000000001:~# runc list
ID                 PID         STATUS      BUNDLE                                CREATED                          OWNER
000-metadata       0           stopped     /containers/onboot/000-metadata       2018-05-05T06:27:44.345735031Z   root
001-sysfs          0           stopped     /containers/onboot/001-sysfs          2018-05-05T06:27:44.768313965Z   root
002-binfmt         0           stopped     /containers/onboot/002-binfmt         2018-05-05T06:27:45.630283593Z   root
003-format         0           stopped     /containers/onboot/003-format         2018-05-05T06:27:46.341011253Z   root
004-extend         0           stopped     /containers/onboot/004-extend         2018-05-05T06:27:47.08889973Z    root
005-mount          0           stopped     /containers/onboot/005-mount          2018-05-05T06:27:55.334088074Z   root
006-swap           0           stopped     /containers/onboot/006-swap           2018-05-05T06:27:56.486815308Z   root
007-ip             0           stopped     /containers/onboot/007-ip             2018-05-05T06:28:03.894591249Z   root
008-move-logs      0           stopped     /containers/onboot/008-move-logs      2018-05-05T06:28:05.980232896Z   root
009-sysctl         0           stopped     /containers/onboot/009-sysctl         2018-05-05T06:28:06.15775421Z    root
010-mount-vpnkit   0           stopped     /containers/onboot/010-mount-vpnkit   2018-05-05T06:28:06.356833391Z   root
011-bridge         0           stopped     /containers/onboot/011-bridge         2018-05-05T06:28:06.551619273Z   root
linuxkit-025000000001:~# ctr tasks ls
```

## How shall I connect to screen session?

Docker for Mac does expose a screen session to attach to, but it's a bit less than ideal if you're not familiar with screen. It's not a big deal, but it's not optimal and it's also very specific to Docker for Mac. Since we're already running Docker the general solution is ideal in this case:

```
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN qlen 1
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 brd 127.255.255.255 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP qlen 1000
    link/ether 02:50:00:00:00:01 brd ff:ff:ff:ff:ff:ff
    inet 192.168.65.3/24 brd 192.168.65.255 scope global eth0
       valid_lft forever preferred_lft forever
    inet6 fe80::50:ff:fe00:1/64 scope link
       valid_lft forever preferred_lft forever
3: tunl0@NONE: <NOARP> mtu 1480 qdisc noop state DOWN qlen 1
    link/ipip 0.0.0.0 brd 0.0.0.0
4: ip6tnl0@NONE: <NOARP> mtu 1452 qdisc noop state DOWN qlen 1
    link/tunnel6 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00 brd 00:00:00:00:00:00:00:00:00:00:00:00:00:00:00:00
5: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP
    link/ether 02:42:76:8b:2b:b1 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:76ff:fe8b:2bb1/64 scope link
       valid_lft forever preferred_lft forever
6: docker_gwbridge: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP
    link/ether 02:42:14:a5:0a:be brd ff:ff:ff:ff:ff:ff
    inet 172.22.0.1/16 brd 172.22.255.255 scope global docker_gwbridge
    6: docker_gwbridge: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP
    link/ether 02:42:14:a5:0a:be brd ff:ff:ff:ff:ff:ff
    inet 172.22.0.1/16 brd 172.22.255.255 scope global docker_gwbridge
       valid_lft forever preferred_lft forever
    inet6 fe80::42:14ff:fea5:abe/64 scope link
       valid_lft forever preferred_lft forever
7: br-2e87cfd50617: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN
    link/ether 02:42:ad:f2:21:3f brd ff:ff:ff:ff:ff:ff
    inet 172.18.0.1/16 brd 172.18.255.255 scope global br-2e87cfd50617
       valid_lft forever preferred_lft forever
13: veth62e1053@if12: <BROADCAST,MULTICAST,UP,LOWER_UP,M-DOWN> mtu 1500 qdisc noqueue master docker_gwbridge state UP
    link/ether 92:4e:15:2d:25:fb brd ff:ff:ff:ff:ff:ff
    inet6 fe80::904e:15ff:fe2d:25fb/64 scope link
       valid_lft forever preferred_lft forever
14: cni0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP qlen 1000
    link/ether 66:df:2e:bb:9c:4f brd ff:ff:ff:ff:ff:ff
    inet 10.1.0.1/16 scope global cni0
       valid_lft forever preferred_lft forever
    inet6 fe80::64df:2eff:febb:9c4f/64 scope link
       valid_lft forever preferred_lft forever
15: veth2990a39d@docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master cni0 state UP
    link/ether 32:d6:aa:ae:b3:e9 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::30d6:aaff:feae:b3e9/64 scope link
       valid_lft forever preferred_lft forever
16: veth543abcfc@docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master cni0 state UP
```

# How to verify that LinuxKit which Docker for Mac is built upon runs service containers

```
screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty
```

```
ctr -n services.linuxkit tasks ls
TASK                    PID     STATUS
acpid                   854     RUNNING
diagnose                898     RUNNING
docker-ce               936     RUNNING
host-timesync-daemon    984     RUNNING
ntpd                    1025    RUNNING
trim-after-delete       1106    RUNNING
vpnkit-forwarder        1157    RUNNING
vsudd                   1198    RUNNING
```

## How to display containerd version?

```
linuxkit-025000000001:~# ctr version
Client:
  Version:  v1.0.1
  Revision: 9b55aab90508bd389d7654c4baf173a981477d55

Server:
  Version:  v1.0.1
  Revision: 9b55aab90508bd389d7654c4baf173a981477d55
linuxkit-025000000001:~#
```

## How shall I enter into docker-ce service container using ctrl?

```
ctr -n services.linuxkit tasks exec -t --exec-id 936 docker-ce sh
```


```
/ # docker version
Client:
 Version:      18.05.0-ce-rc1
 API version:  1.37
 Go version:   go1.9.5
 Git commit:   33f00ce
 Built:        Thu Apr 26 00:58:14 2018
 OS/Arch:      linux/amd64
 Experimental: false
 Orchestrator: swarm

Server:
 Engine:
  Version:      18.05.0-ce-rc1
  API version:  1.37 (minimum version 1.12)
  Go version:   go1.10.1
  Git commit:   33f00ce
  Built:        Thu Apr 26 01:06:49 2018
  OS/Arch:      linux/amd64
  Experimental: true
/ #
```

## How to see Kubernetes Cluster Node?

```
/ # kubectl version
Client Version: version.Info{Major:"1", Minor:"9", GitVersion:"v1.9.6", GitCommit:"9f8ebd171479bec0ada837d7ee641dec2f8c6dd1", GitTreeState:"clean", BuildDate:"2018-03-23T09:38:59Z", GoVersion:"go1.9.4", Compiler:"gc", Platform:"linux/amd64"}
Server Version: version.Info{Major:"1", Minor:"9", GitVersion:"v1.9.6", GitCommit:"9f8ebd171479bec0ada837d7ee641dec2f8c6dd1", GitTreeState:"clean", BuildDate:"2018-03-21T15:13:31Z", GoVersion:"go1.9.3", Compiler:"gc", Platform:"linux/amd64"}
```

```
/ # kubectl get nodes
NAME                 STATUS    ROLES     AGE       VERSION
docker-for-desktop   Ready     master    26d       v1.9.6
/ #
```


