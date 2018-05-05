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

