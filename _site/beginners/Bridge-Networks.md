# Bridge network

Most common network type. It is limited to containers within a single host running the Docker engine. Bridge networks are easy to create, manage and troubleshoot.

## Two types of Bridge Networks

- _Default bridge network_: Docker sets it up for you automatically. Best choice for production system.

- _User-defined bridge network_: Create and use your own custom bridge networks, to connect containers running on the same Docker host. This is recommended for standalone containers running in production.

## Default bridge network

When you start Docker, a default bridge network (also called bridge) is created automatically, and newly-started containers connect to it unless otherwise specified.

We'll start two different alpine containers on the same Docker host.

1. List current networks

```docker
$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
17e324f45964        bridge              bridge              local
6ed54d316334        host                host                local
7092879f2cc8        none                null                local
```

2. Start two `alpine` containers running `ash`(Alpine’s default shell)

```docker
$ docker run -dit --name alpine1 alpine ash
$ docker run -dit --name alpine2 alpine ash
```

3. Check that both containers are actually started

```docker
$ docker container ls
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
602dbf1edc81        alpine              "ash"               4 seconds ago       Up 3 seconds                            alpine2
da33b7aa74b0        alpine              "ash"               17 seconds ago      Up 16 seconds                           alpine1
```

4. See Network manage commands

```docker
$ docker network --help
Manage Network Options:
Commands:
connect      Connect a container to a network
create       Create a Network
disconnect   Disconnect a container from a network
inspect      Display detailed information on one or more networks
ls           List networks
prune        Remove all unused networks
rm           Remove one or more networks
```

5. Inspect the bridge network to see what containers are connected to it

```docker
$ docker network inspect bridge
```

Also use it to find the IP address of the running container.

```docker
$ docker inspect "container ID"
```

> To retrieve just the IP address of the running container

```docker
$ docker inspect -f '{{ .NetworkSettings.IPAddress }}' "container ID"
```

or

```docker
$ docker inspect <container id> | grep "IPAddress"
```

6. The containers are running in the background. Use the **docker attach** command to connect to alpine2

```docker
$ docker attach alpine2
/#
```

Now root user within alpine2 container

7. From within alpine2, ping bing.com and then ping first container(alpine1)

```docker
# ping -c 2 bing.com
```

```docker
# ping -c 172.17.0.2
```

8. Detach from alpine1, Stop and remove both containers

```docker
$ docker container stop alpine1 alpine2
$ docker container rm alpine1 alpine2
```

## User-defined bridge network

1. Create the `my-alpine-net` network

```docker
$ docker network create my-alpine-net
```

2. List Docker’s networks

```docker
$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
17e324f45964        bridge              bridge              local
6ed54d316334        host                host                local
e9261a8c9a19       my-alpine-net        bridge              local
7092879f2cc8        none                null                local
```

3. Create three containers, first alpine container attached to user-defined network(my-alpine-net), second connected to bridge network only and third connected to both

```docker
$ docker run -dit --name alpine1 --network my-alpine-net alpine ash
$ docker run -dit --name alpine2 alpine ash
$ docker run -dit --name alpine3 --network my-alpine-net alpine ash
$ docker network connect bridge alpine3
```

4. After the containers are created and runnning, inspect the bridge network and the my-alpine-net network

```docker
$ docker network inspect bridge
[
    {

        "Name": "bridge",
        "Id": "5b712f666694cbaefc55335e332b5250dfb96c97d920bf8bf83c9cfee9a85c8a",
        "Created": "2018-06-07T08:41:10.017839579Z",
        "Scope": "local",
        "Driver": "bridge",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": null,
            "Config": [
                {
                    "Subnet": "172.17.0.0/16"
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
            "875ad3a4ad18b37bcdd9a483f7ee04d53482876f604bc002f4bb80993a224285": {
                "Name": "alpine2",
                "EndpointID": "42c94353e1133c6a1f177cbb8550dddb33a80eb18432ca35203a2384d1ab442e",
                "MacAddress": "02:42:ac:11:00:02",
                "IPv4Address": "172.17.0.2/16",
                "IPv6Address": ""
            },
            "e9d5c70b22843266ec4215f64a27878110aa4abcdce9f23f59945d2c56cf0d62": {
                "Name": "alpine3",
                "EndpointID": "df75f77ee9cdf83d7412a8985e3dbc6f8446f5de74196bb458f0a5a11a6831ac",
                "MacAddress": "02:42:ac:11:00:03",
                "IPv4Address": "172.17.0.3/16",
                "IPv6Address": ""
            }
        },
        "Options": {
            "com.docker.network.bridge.default_bridge": "true",
            "com.docker.network.bridge.enable_icc": "true",
            "com.docker.network.bridge.enable_ip_masquerade": "true",
            "com.docker.network.bridge.host_binding_ipv4": "0.0.0.0",
            "com.docker.network.bridge.name": "docker0",
            "com.docker.network.driver.mtu": "1500"
        },
        "Labels": {}
    }
]
```

Inspect `my-network-net`network

```docker
$ docker network inspect my-alpine-net
[
    {
        "Name": "my-alpine-net",
        "Id": "4bdbb2bc8ff1a9d7bba53dcffb604593d593c3ab218b999101627333eb4c756b",
        "Created": "2018-06-07T08:48:40.405847087Z",
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
            "0005af800c2cfbe43fb09e0515767d5c6cf04240c7cbb1a00fac045979fefe42": {
                "Name": "alpine1",
                "EndpointID": "8dd17e2c1536c4c9a081aee0b8a315ea152eef09222e4d73e5e66ba786d0ab85",
                "MacAddress": "02:42:ac:14:00:02",
                "IPv4Address": "172.20.0.2/16",
                "IPv6Address": ""
            },
            "e9d5c70b22843266ec4215f64a27878110aa4abcdce9f23f59945d2c56cf0d62": {
                "Name": "alpine3",
                "EndpointID": "6e00792f2cc3affcb15c21ec12289ab6698f972abe43a61a608cbe9041f5f1b2",
                "MacAddress": "02:42:ac:14:00:03",
                "IPv4Address": "172.20.0.3/16",
                "IPv6Address": ""
            }
        },
        "Options": {},
        "Labels": {}
    }
]
```

5. Create the `my-alpine-net` network

```docker
$ docker container attach alpine1
```

Now ping other Containers

```docker
/ # ping -c 2 alpine2
ping: bad address 'alpine2'
/ # ping -c 2 alpine 2
PING alpine3 (172.20.0.3): 56 data bytes
64 bytes from 172.20.0.3: seq=0 ttl=64 time=0.188 ms
64 bytes from 172.20.0.3: seq=1 ttl=64 time=0.092 ms
--- alpine3 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.092/0.140/0.188 ms
```

6. Dettach from alpine1 and attach to alpine3(connected to both networks)

```docker
$ docker container attach alpine3
/ # ping -c 2 alpine1
PING alpine1 (172.20.0.2): 56 data bytes
64 bytes from 172.20.0.2: seq=0 ttl=64 time=0.115 ms
64 bytes from 172.20.0.2: seq=1 ttl=64 time=0.094 ms
--- alpine1 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.094/0.104/0.115 ms
/ # ping -c 2 alpine2
ping: bad address 'alpine2'
```

Can't ping alpine2(default bridge) using name. We need to address alpine2 by its IP address.

```docker
$ docker container attach alpine3
/ # ping -c 2 172.17.0.2
PING 172.17.0.2 (172.17.0.2): 56 data bytes
64 bytes from 172.17.0.2: seq=0 ttl=64 time=0.141 ms
64 bytes from 172.17.0.2: seq=1 ttl=64 time=0.075 ms
--- alpine1 ping statistics ---
2 packets transmitted, 2 packets received, 0% packet loss
round-trip min/avg/max = 0.075/0.108/0.141 ms
```

7. Stop and remove all containers and the my-alpine-net network

```docker
$ docker container stop alpine1 alpine2 alpine3
$ docker container rm alpine1 alpine2 alpine3
$ docker network rm my-alpine-net
```
