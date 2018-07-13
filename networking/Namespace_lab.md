# Linux Network Namespace Introduction


In this tutorial, we will learn what is Linux network namespace and how to use it.

Docker uses many Linux namespace technologies for isolation, there are user namespace, process namespace, etc. For network isolation docker uses Linux network namespace technology, each docker container has its own network namespace, which means it has its own IP address, routing table, etc.

First, let’s see how to create and check a network namespace. The lab environment we used today is a docker host which is created by docker-machine tool on Amazon AWS.

## Create and List Network Namespace

Use ip netns add <network namespace name> to create a network namespace, and ip netns list to list all network namepaces on the host.
    
```
~$ sudo ip netns add test1
~$ ip netns list
test1
~$
    
```

## Delete Network Namespace
Use ip netns delete <network namespace name> to delete a network namespace.

```
~$ sudo ip netns delete test1
~$ ip netns list
~$

```
## Execute CMD within Network Namespace

How to check interfaces in a particular network namespace, we can use command ip netns exec <network namespace name> <command> like:

```
~$ sudo ip netns exec test1 ip a
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN group default
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
~$

```
ip a will list all ip interfaces within this test1 network namespaces. From the output we can see that the lo inteface is DOWN, we can run a command to let it up.

```
~$ sudo ip netns exec test1 ip link
1: lo: <LOOPBACK> mtu 65536 qdisc noop state DOWN mode DEFAULT group default
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
~$ sudo ip netns exec test1 ip link set dev lo up
~$ sudo ip netns exec test1 ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00

```
The status of lo became UNKNOWN, please ignore that and go on.

## Add Interface to a Network Namespace
We will create a virtual interface pair, it has two virtual interfaces which are connected by a virtual cable

```
~$ sudo ip link add veth-a type veth peer name veth-b
~$ ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 02:30:c1:3e:63:3a brd ff:ff:ff:ff:ff:ff
4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default
    link/ether 02:42:a7:88:bd:32 brd ff:ff:ff:ff:ff:ff
27: veth-b: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:58:31:ef:0b:98 brd ff:ff:ff:ff:ff:ff
28: veth-a: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 3e:89:92:ac:ef:10 brd ff:ff:ff:ff:ff:ff
~$

```
All these two interfaces are located on localhost default network namespace. what we will do is move one of them to test1 network namespace, we can do this through:

```
~$ sudo ip link set veth-b netns test1
~$ ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 02:30:c1:3e:63:3a brd ff:ff:ff:ff:ff:ff
4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default
    link/ether 02:42:a7:88:bd:32 brd ff:ff:ff:ff:ff:ff
28: veth-a: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 3e:89:92:ac:ef:10 brd ff:ff:ff:ff:ff:ff
    
~$ sudo ip netns exec test1 ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
27: veth-b: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000
    link/ether 52:58:31:ef:0b:98 brd ff:ff:ff:ff:ff:ff
~$

```
Now, the interface veth-b is in network namespace test1.

## Assign IP address to veth interface
In the localhost to set veth-a

```
~$ sudo ip addr add 192.168.1.1/24 dev veth-a
~$ sudo ip link set veth-a up
~$ ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 02:30:c1:3e:63:3a brd ff:ff:ff:ff:ff:ff
4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default
    link/ether 02:42:a7:88:bd:32 brd ff:ff:ff:ff:ff:ff
28: veth-a: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc pfifo_fast state DOWN mode DEFAULT group default qlen 1000
    link/ether 3e:89:92:ac:ef:10 brd ff:ff:ff:ff:ff:ff

```
veth-a has an IP address, but its status is DOWN. Now let’s set veth-b in test1.

```
~$ sudo ip netns exec test1 ip addr add 192.168.1.2/24 dev veth-b
~$ sudo ip netns exec test1 ip link set dev veth-b up
~$ ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 9001 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 02:30:c1:3e:63:3a brd ff:ff:ff:ff:ff:ff
4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN mode DEFAULT group default
    link/ether 02:42:a7:88:bd:32 brd ff:ff:ff:ff:ff:ff
28: veth-a: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 3e:89:92:ac:ef:10 brd ff:ff:ff:ff:ff:ff
    
~$ sudo ip netns exec test1 ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
27: veth-b: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc pfifo_fast state UP mode DEFAULT group default qlen 1000
    link/ether 52:58:31:ef:0b:98 brd ff:ff:ff:ff:ff:ff
    
```
After configured veth-b and up it, both veth-a and veth-b are UP. Now we can use ping to check their connectivity.

```
~$ ping 192.168.1.2
PING 192.168.1.2 (192.168.1.2) 56(84) bytes of data.
64 bytes from 192.168.1.2: icmp_seq=1 ttl=64 time=0.047 ms
64 bytes from 192.168.1.2: icmp_seq=2 ttl=64 time=0.046 ms
64 bytes from 192.168.1.2: icmp_seq=3 ttl=64 time=0.052 ms
^C
--- 192.168.1.2 ping statistics ---
3 packets transmitted, 3 received, 0% packet loss, time 1998ms
rtt min/avg/max/mdev = 0.046/0.048/0.052/0.006 ms
~$

```
