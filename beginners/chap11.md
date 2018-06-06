# Docker Networking on Bare Metal

```
root@ubuntu18:/home/dell# ip addr
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN g                                   roup default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
       
2: ens160: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel                                    state UP group default qlen 1000
    link/ether 00:0c:29:05:db:6f brd ff:ff:ff:ff:ff:ff
    inet 100.98.26.129/24 brd 100.98.26.255 scope global noprefixrout                                   e ens160
       valid_lft forever preferred_lft forever
    inet6 fe80::20c:29ff:fe05:db6f/64 scope link
       valid_lft forever preferred_lft forever

4: docker0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueu                                   e state DOWN group default
    link/ether 02:42:f1:3c:a4:b5 brd ff:ff:ff:ff:ff:ff
    inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
       valid_lft forever preferred_lft forever
    inet6 fe80::42:f1ff:fe3c:a4b5/64 scope link
       valid_lft forever preferred_lft forever

5: docker_gwbridge: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc                                    noqueue state UP group default
    link/ether 02:42:32:f5:b8:79 brd ff:ff:ff:ff:ff:ff
    inet 172.18.0.1/16 brd 172.18.255.255 scope global docker_gwbridg                                   e
       valid_lft forever preferred_lft forever
    inet6 fe80::42:32ff:fef5:b879/64 scope link
       valid_lft forever preferred_lft forever

87: veth31c21a5@if86: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdis                                   c noqueue master docker_gwbridge state UP group default
    link/ether 6a:c9:c8:08:72:bb brd ff:ff:ff:ff:ff:ff link-netnsid 1
    inet6 fe80::68c9:c8ff:fe08:72bb/64 scope link
       valid_lft forever preferred_lft forever

  ```
