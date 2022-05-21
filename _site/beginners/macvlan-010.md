# Implementing MacVLAN 



## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Linux VM/Bare Metal</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- A Virtual Machine running on ESXi or Virtualbox 
- Linux System(or Bare Metal OS)

** Please remember MacVLAN is not supported on Cloud Platform


Assume you have a clean Docker Host system(VM or Bare Metal System) with just 3 networks available – bridge, host and null

```docker
root@ubuntu:~# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
871f1f745cc4        bridge              bridge              local
113bf063604d        host                host                local
2c510f91a22d        none                null                local
root@ubuntu:~#
```

The Network Configuration is quite simple. It has eth0 and eth1 interface. I will just use eth0.

```docker
root@ubuntu:~# ifconfig
docker0   Link encap:Ethernet  HWaddr 02:42:7d:83:13:8e
          inet addr:172.17.0.1  Bcast:172.17.255.255  Mask:255.255.0.0
          UP BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

eth0      Link encap:Ethernet  HWaddr fe:05:ce:a1:2d:5d
          inet addr:100.98.26.43  Bcast:100.98.26.255  Mask:255.255.255.0
          inet6 addr: fe80::fc05:ceff:fea1:2d5d/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:923700 errors:0 dropped:367 overruns:0 frame:0
          TX packets:56656 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:150640769 (150.6 MB)  TX bytes:5125449 (5.1 MB)
          Interrupt:31 Memory:ac000000-ac7fffff

lo        Link encap:Local Loopback
          inet addr:127.0.0.1  Mask:255.0.0.0
          inet6 addr: ::1/128 Scope:Host
          UP LOOPBACK RUNNING  MTU:65536  Metric:1
          RX packets:45 errors:0 dropped:0 overruns:0 frame:0
          TX packets:45 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0
          RX bytes:3816 (3.8 KB)  TX bytes:3816 (3.8 KB)
```

- Creating MacVLAN network on top of eth0.

```docker
docker network create -d macvlan --subnet=100.98.26.43/24 --gateway=100.98.26.1  -o parent=eth0 pub_net
```

- Verifying MacVLAN network

```docker
root@ubuntu:~# docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
871f1f745cc4        bridge              bridge              local
113bf063604d        host                host                local
2c510f91a22d        none                null                local
bed75b16aab8        pub_net             macvlan             local
root@ubuntu:~#
```

- Let us create a sample Docker Image and assign statics IP(ensure that it is from free pool)

```docker
root@ubuntu:~# docker  run --net=pub_net --ip=100.98.26.47 -itd alpine /bin/sh
Unable to find image 'alpine:latest' locally
latest: Pulling from library/alpine
ff3a5c916c92: Pull complete
Digest: sha256:e1871801d30885a610511c867de0d6baca7ed4e6a2573d506bbec7fd3b03873f
Status: Downloaded newer image for alpine:latest
493a9566c31c15b1a19855f44ef914e7979b46defde55ac6ee9d7db6c9b620e0
```

** Important Point: When using macvlan, you cannot ping or communicate with the default namespace IP address. For example, if you create a container and try to ping the Docker host’s eth0, it will not work. That traffic is explicitly filtered by the kernel modules themselves to offer additional provider isolation and security

### How to enable this communication

It’s simple. Just run the below command:

Example: `ip link add mac0 link $PARENTDEV type macvlan mode bridge`

So, in our case, it will be:

```docker
ip link add mac0 link eth0 type macvlan mode bridge

ip addr add 100.98.26.38/24 dev mac0

ifconfig mac0 up
```

Let us try creating container and pinging:

```docker
root@ubuntu:~# docker run --net=pub_net -d --ip=100.98.26.53 -p 81:80 nginx
10146a39d7d8839b670fc5666950c0e265037105e61b0382575466cc62d34824
root@ubuntu:~# ping 100.98.26.53
PING 100.98.26.53 (100.98.26.53) 56(84) bytes of data.
64 bytes from 100.98.26.53: icmp_seq=1 ttl=64 time=1.00 ms
64 bytes from 100.98.26.53: icmp_seq=2 ttl=64 time=0.501 ms
```

## Contributor

- [Ajeet Singh Raina](ajeetraina@gmail.com)
