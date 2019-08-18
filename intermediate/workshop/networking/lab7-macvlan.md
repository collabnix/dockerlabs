# Getting Started with MacVLAN network 

Say, you have built Docker applications(legacy in nature like network traffic monitoring, system management etc.) which is expected to be directly connected to the underlying physical network. In this type of situation, you can use the macvlan network driver to assign a MAC address to each container’s virtual network interface, 
making it appear to be a physical network interface directly connected to the physical network.

## Why do we need it

- Explicit control over container IP assignment

- We need container IP directly in underlay network managed by enterprise.

- Connect container to legacy applications

- Connect container to external network without overlay overhead.

- Have a need to preserve source IP of container.

Traffic flows through eth0 and Docker routes traffic to your container using its MAC address. To network devices on your network, your container appears to be physically attached to the network.

## Create a macvlan network called macvlan-mynet

```docker
$ docker network create -d macvlan \
  --subnet=192.10.86.0/24 \
  --gateway=192.10.86.1 \
  -o parent=eth1 \
  macvlan-mynet
```

## List macvlan networks

```docker
$ docker network ls
NETWORK ID          NAME                DRIVER              SCOPE
bef0002ef343        bridge              bridge              local
0ce752a109ad        host                host                local
a4a33de2232b        macvlan-mynet       macvlan             local
631e4ef63d66        none                null                local
```

```docker
$ docker network inspect macvlan-mynet
[
    {
        "Name": "macvlan-mynet",
        "Id": "a4a33de2232bdbfb0ea954f1dff43755e001fdcd9ad174368feaf0d0ff5859c2",
        "Created": "2018-06-07T10:25:43.24356479Z",
        "Scope": "local",
        "Driver": "macvlan",
        "EnableIPv6": false,
        "IPAM": {
            "Driver": "default",
            "Options": {},
            "Config": [
                {
                    "Subnet": "192.10.86.0/24",
                    "Gateway": "192.10.86.1"
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
        "Containers": {},
        "Options": {
            "parent": "eth1"
        },
        "Labels": {}
    }
]
```

## Check that both containers are actually started

```docker
$ docker container ls
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS              PORTS               NAMES
602dbf1edc81        alpine              "ash"               4 seconds ago       Up 3 seconds                            alpine2
da33b7aa74b0        alpine              "ash"               17 seconds ago      Up 16 seconds                           alpine1
```

- Start and attach an alpine container to the macvlan-mynet network

```docker
$ docker run --rm -itd \
  --network macvlan-mynet \
  --name macvlan-alpine \
  alpine:latest \
  ash
```

## Inspect the `macvlan-alpine` container and notice the MacAddress key within the Networks key

```docker
$ docker container inspect macvlan-alpine
...truncated...
"Networks": {
  "my-macvlan-net": {
      "IPAMConfig": null,
      "Links": null,
      "Aliases": [
          "bec64291cd4c"
      ],
      "NetworkID": "5e3ec79625d388dbcc03dcf4a6dc4548644eb99d58864cf8eee2252dcfc0cc9f",
      "EndpointID": "8caf93c862b22f379b60515975acf96f7b54b7cf0ba0fb4a33cf18ae9e5c1d89",
      "Gateway": "192.10.86.1",
      "IPAddress": "192.10.86.2",
      "IPPrefixLen": 24,
      "IPv6Gateway": "",
      "GlobalIPv6Address": "",
      "GlobalIPv6PrefixLen": 0,
      "MacAddress": "02:42:ac:10:56:02",
      "DriverOpts": null
  }
}
...truncated
```

## Run `docker exec` commands

```docker
$ docker exec macvlan-alpine ip route default via 192.10.86.1 dev eth0 172.16.86.0/24 dev eth0 scope link  src 172.16.86.2
```

Now root user within alpine2 container.

## Stop container and remove the macvlan network

```docker
$ docker container stop macvlan-alpine

$ docker network rm macvlan-mynet
```


