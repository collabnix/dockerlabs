# Demonstrating Docker Bridge Networking



<a href="https://asciinema.org/a/obR9hnd1LuejH4Gtrq9Rpaegx" target="_blank"><img src="https://asciinema.org/a/D7Sy9ouLPWc3aWa5RVPKuMOaK.png" /></a>


## Verifying Docker version

```
$ docker version
Client:
 Version:      18.03.1-ce
 API version:  1.37
 Go version:   go1.9.2
 Git commit:   9ee9f40
 Built:        Thu Apr 26 07:12:25 2018
 OS/Arch:      linux/amd64
 Experimental: false
 Orchestrator: swarm

Server:
 Engine:
  Version:      18.03.1-ce  API version:  1.37 (minimum version 1.12)
  Go version:   go1.9.5
  Git commit:   9ee9f40
  Built:        Thu Apr 26 07:23:03 2018
  OS/Arch:      linux/amd64
  Experimental: true
  ```


## Listing the supported network driver

```
$ docker info --format '{{json .Plugins.Network}}'
["bridge","host","ipvlan","macvlan","null","overlay"]
```

## Running Ubuntu container on default bridge network

```
$docker run -dit --name demo-bridge ubuntu sleep infinity
```

```
$ docker inspect --format='{{json .NetworkSettings.Networks.net1.IPAddress}}' demo-bridge
"172.19.0.3"
```

## How to create a bridge network called "net1"

```
$docker network create -d bridge net1
```

## How to create a bridge network "net2"

```
$docker network create -d bridge net2
```

## How to inspect IP Address of net1 bridge?

```
$ docker network inspect --format='{{json .IPAM.Config}}'  net1
[{"Subnet":"172.19.0.0/16","Gateway":"172.19.0.1"}]
```

## How to inspect IP address of net2 bridge network?

```
$ docker network inspect --format='{{json .IPAM.Config}}'  net2
[{"Subnet":"172.20.0.0/16","Gateway":"172.20.0.1"}]
```

## How to attach container to bridge network net1

```
$ docker run -d --net=net1 --name nettools collabnixlabs/ubuntu-nettools:v1.0
```

## Verify that container shows up under net1

```
$ docker network inspect net1[
    {
        "Name": "net1",
        "Id": "f0ff5822b12f946252ac58a730e8bd3bfc5f60c02b4c82a40d9fd761c6fd26e1",
        "Created": "2018-06-21T16:11:36.551949763Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.19.0.0/16",
                    "Gateway": "172.19.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "98adad911ecc9eca67da9f7671d56b9983ebdda9c4e519d12111b7044d4240fa": {
                "Name": "nettool",
                "EndpointID": "0eb508a38149eea9b90cfab9ebbd0739657e4a796b3f3a9ce4c7c3af7f8af3db",
                "MacAddress": "02:42:ac:13:00:02",
                "IPv4Address": "172.19.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
```
    
## Run a container on net2 now
    
```
 $ docker run -d --net=net2 --name net2tool collabnixlabs/ubuntu-nettools:v1.0 sleepinfinity
e7310afe1c925af9c3333060a75d8fb6e40095497f443a3eac5225fdf94131d4
```

## Verifying

```
$ docker network inspect net2[
    {
        "Name": "net2",
        "Id": "7fc670b9e4d5c2ce776a68b6c2926f9ab7c250c684314ad0318a668019457a86",
        "Created": "2018-06-21T16:12:09.308894997Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "172.20.0.0/16",
                    "Gateway": "172.20.0.1"
                }
            ]
        },
        "Internal": false,
        "Attachable": false,
        "Ingress": false,
        "ConfigFrom": {
            "Network": ""
        },
        "ConfigOnly": false,
        "Containers": {
            "e7310afe1c925af9c3333060a75d8fb6e40095497f443a3eac5225fdf94131d4": {
                "Name": "net2tool",
                "EndpointID": "e72c0c8197696e472589b61cc275b46f54f975f19035585b2d28e895633c2522",
                "MacAddress": "02:42:ac:14:00:02",
                "IPv4Address": "172.20.0.2/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]
```

## Ping Test

```
[node1] (local) root@192.168.0.28 ~
$ ping 172.19.0.2
PING 172.19.0.2 (172.19.0.2): 56 data bytes
64 bytes from 172.19.0.2: seq=0 ttl=64 time=0.171 ms
64 bytes from 172.19.0.2: seq=1 ttl=64 time=0.192 ms
^C
--- 172.19.0.2 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.171/0.181/0.192 ms
[node1] (local) root@192.168.0.28 ~
```

## 

```
$ docker ps
CONTAINER ID        IMAGE                                COMMAND             CREATED
             STATUS              PORTS               NAMES
e7310afe1c92        collabnixlabs/ubuntu-nettools:v1.0   "sleep infinity"    2 minut
es ago       Up 2 minutes                            net2tool
98adad911ecc        collabnixlabs/ubuntu-nettools:v1.0   "sleep infinity"    4 minut
es ago       Up 4 minutes                            nettool
[node1] (local) root@192.168.0.28 ~
$ docker exec -it e73 ifconfig eth0
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.20.0.2  netmask 255.255.0.0  broadcast 172.20.255.255
        ether 02:42:ac:14:00:02  txqueuelen 0  (Ethernet)
        RX packets 3  bytes 182 (182.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 3  bytes 182 (182.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

[node1] (local) root@192.168.0.28 ~
$ docker exec -it 98 ifconfig eth0
eth0: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.19.0.2  netmask 255.255.0.0  broadcast 172.19.255.255
        ether 02:42:ac:13:00:02  txqueuelen 0  (Ethernet)
        RX packets 4  bytes 280 (280.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 4  bytes 280 (280.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

[node1] (local) root@192.168.0.28 ~
$
```

## Try pinging one bridge container to another bridge container

```
$ docker exec -it 98 ping 172.20.0.2
PING 172.20.0.2 (172.20.0.2) 56(84) bytes of data.
^C
--- 172.20.0.2 ping statistics ---
2 packets transmitted, 0 received, 100% packet loss, time 1009ms
```
