# How to setup Docker Swarm Cluster on Raspberry Pi

Let us setup 2 node Swarm Mode Cluster.

System #1 - pi-node1 - 192.168.1.5
System #2 - pi-node2 - 192.168.1.6


Login to pi-node1 and run the below command:

```
root@raspberrypi:~# docker version
Client:
 Version:           18.09.0
 API version:       1.39
 Go version:        go1.10.4
 Git commit:        4d60db4
 Built:             Wed Nov  7 00:57:21 2018
 OS/Arch:           linux/arm
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.0
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       4d60db4
  Built:            Wed Nov  7 00:17:57 2018
  OS/Arch:          linux/arm
  Experimental:     false
root@raspberrypi:~# hostname pi_1
hostname: the specified hostname is invalid
root@raspberrypi:~# hostname pi-node1
root@raspberrypi:~# hostname
pi-node1
root@raspberrypi:~#
```

# Login to Node #2

```
root@raspberrypi:~# hostname pi-node2
root@raspberrypi:~# hostname
pi-node2
```






