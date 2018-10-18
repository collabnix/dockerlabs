# Running Your First Ubuntu Container

```docker
docker run ubuntu date
```

## Accessing Shell inside Ubuntu container

```docker
docker run -it ubuntu /bin/bash
```

## Provide hostname to Ubuntu container(using -h or --hostname)

```docker
docker run -h collabnix -i -t debian /bin/bash
Unable to find image 'debian:latest' locally
latest: Pulling from library/debian
cc1a78bfd46b: Pull complete
Digest: sha256:de3eac83cd481c04c5d6c7344cd7327625a1d8b2540e82a8231b5675cef0ae5f
Status: Downloaded newer image for debian:latest
root@collabnix:/# hostname
collabnix
```

## Inspecting the Running Container

```docker
$ docker inspect a1b
[
    {
        "Id": "a1bce73ff5ac652b1f60462010f3b0b219035f57f61fed2a37568b3209c51c55",
        "Created": "2018-06-01T11:02:15.55550308Z",
        "Path": "/bin/bash",
        "Args": [],
        "State": {
            "Status": "running",
            "Running": true,
            "Paused": false,
            "Restarting": false,
            "OOMKilled": false,
            "Dead": false,
            "Pid": 326,
            "ExitCode": 0,
            "Error": "",
            "StartedAt": "2018-06-01T11:02:15.981450203Z",
            "FinishedAt": "0001-01-01T00:00:00Z"
        },
        "Image": "sha256:8626492fecd368469e92258dfcafe055f636cb9cbc321a5865a98a0a6c99b8dd",
        "ResolvConfPath": "/var/lib/docker/containers/a1bce73ff5ac652b1f60462010f3b0b219035f57f61fed2a37568b3209c51c55/resolv.conf",
        "HostnamePath": "/var/lib/docker/containers/a1bce73ff5ac652b1f60462010f3b0b219035f57f61fed2a37568b3209c51c55/hostname",
        "HostsPath": "/var/lib/docker/containers/a1bce73ff5ac652b1f60462010f3b0b219035f57f61fed2a37568b3209c51c55/hosts",
        "LogPath": "/var/lib/docker/containers/a1bce73ff5ac652b1f60462010f3b0b219035f57f61fed2a37568b3209c51c55/a1bce73ff5ac652b1f60462010f3b0b219035f57f61fed2a37568b3209c51c55-json.log",
        "Name": "/vibrant_roentgen",
        "RestartCount": 0,
        "Driver": "overlay2",
        "Platform": "linux",
        "MountLabel": "",
        "ProcessLabel": "",
        "AppArmorProfile": "docker-default",
        "ExecIDs": null,
        "HostConfig": {
            "Binds": null,
            "ContainerIDFile": "",
            "LogConfig": {
                "Type": "json-file",
                "Config": {}
            },
            "NetworkMode": "default",
            "PortBindings": {},
            "RestartPolicy": {
                "Name": "no",
                "MaximumRetryCount": 0
            },
            "AutoRemove": false,
            "VolumeDriver": "",
            "VolumesFrom": null,
            "CapAdd": null,
            "CapDrop": null,
            "Dns": [],
            "DnsOptions": [],
            "DnsSearch": [],
            "ExtraHosts": null,
            "GroupAdd": null,
            "IpcMode": "shareable",
            "Cgroup": "",
            "Links": null,
            "OomScoreAdj": 0,
            "PidMode": "",
            "Privileged": false,
            "PublishAllPorts": false,
            "ReadonlyRootfs": false,
            "SecurityOpt": null,
            "UTSMode": "",
            "UsernsMode": "",
            "ShmSize": 67108864,
            "Runtime": "runc",
            "ConsoleSize": [
                0,
                0
            ],
            "Isolation": "",
            "CpuShares": 0,
            "Memory": 0,
            "NanoCpus": 0,
            "CgroupParent": "",
            "BlkioWeight": 0,
            "BlkioWeightDevice": [],
            "BlkioDeviceReadBps": null,
            "BlkioDeviceWriteBps": null,
            "BlkioDeviceReadIOps": null,
            "BlkioDeviceWriteIOps": null,
            "CpuPeriod": 0,
            "CpuQuota": 0,
            "CpuRealtimePeriod": 0,
            "CpuRealtimeRuntime": 0,
            "CpusetCpus": "",
            "CpusetMems": "",
            "Devices": [],
            "DeviceCgroupRules": null,
            "DiskQuota": 0,
            "KernelMemory": 0,
            "MemoryReservation": 0,
            "MemorySwap": 0,
            "MemorySwappiness": null,
            "OomKillDisable": false,
            "PidsLimit": 0,
            "Ulimits": null,
            "CpuCount": 0,
            "CpuPercent": 0,
            "IOMaximumIOps": 0,
            "IOMaximumBandwidth": 0
        },
        "GraphDriver": {
            "Data": {
                "LowerDir": "/var/lib/docker/overlay2/616cc7a9c0b25c592ce18b67396d0049dcb5df92ca7ccf14f769d48d222a5c1b-init/diff:/var/lib/docker/overlay2/8b3bcd052764edd56857a350d83714af77995b66d6cb430b3c133ed7419d1db8/diff",
                "MergedDir": "/var/lib/docker/overlay2/616cc7a9c0b25c592ce18b67396d0049dcb5df92ca7ccf14f769d48d222a5c1b/merged",
                "UpperDir": "/var/lib/docker/overlay2/616cc7a9c0b25c592ce18b67396d0049dcb5df92ca7ccf14f769d48d222a5c1b/diff",
                "WorkDir": "/var/lib/docker/overlay2/616cc7a9c0b25c592ce18b67396d0049dcb5df92ca7ccf14f769d48d222a5c1b/work"
            },
            "Name": "overlay2"
        },
        "Mounts": [],
        "Config": {
            "Hostname": "collabnix",
            "Domainname": "",
            "User": "",
            "AttachStdin": true,
            "AttachStdout": true,
            "AttachStderr": true,
            "Tty": true,
            "OpenStdin": true,
            "StdinOnce": true,
            "Env": [
                "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
            ],
            "Cmd": [
                "/bin/bash"
            ],
            "Image": "debian",
            "Volumes": null,
            "WorkingDir": "",
            "Entrypoint": null,
            "OnBuild": null,
            "Labels": {}
        },
        "NetworkSettings": {
            "Bridge": "",
            "SandboxID": "cb5a9be309efb4f71ff9a78d56e8fb6886b3093b3b5b7945d258f09fde7e9030",
            "HairpinMode": false,
            "LinkLocalIPv6Address": "",
            "LinkLocalIPv6PrefixLen": 0,
            "Ports": {},
            "SandboxKey": "/var/run/docker/netns/cb5a9be309ef",
            "SecondaryIPAddresses": null,
            "SecondaryIPv6Addresses": null,
            "EndpointID": "f5b8b162d69f5c364f62a75b9583a477a36b45971fc99a13c6f4cf1a3a7592fe",
            "Gateway": "172.17.0.1",
            "GlobalIPv6Address": "",
            "GlobalIPv6PrefixLen": 0,
            "IPAddress": "172.17.0.2",
            "IPPrefixLen": 16,
            "IPv6Gateway": "",
            "MacAddress": "02:42:ac:11:00:02",
            "Networks": {
                "bridge": {
                    "IPAMConfig": null,
                    "Links": null,
                    "Aliases": null,
                    "NetworkID": "4084e5ed851e9e39d029bdc91919879893a3dd5c769b804c5b99a8600f48548e",
                    "EndpointID": "f5b8b162d69f5c364f62a75b9583a477a36b45971fc99a13c6f4cf1a3a7592fe",
                    "Gateway": "172.17.0.1",
                    "IPAddress": "172.17.0.2",
                    "IPPrefixLen": 16,
                    "IPv6Gateway": "",
                    "GlobalIPv6Address": "",
                    "GlobalIPv6PrefixLen": 0,
                    "MacAddress": "02:42:ac:11:00:02",
                    "DriverOpts": null
                }
            }
        }
    }
]
```

## Displaying IP address

```docker
$ docker inspect a1b | grep IPAddress
            "SecondaryIPAddresses": null,
            "IPAddress": "172.17.0.2",
                    "IPAddress": "172.17.0.2",
```

## Displaying IP address using Filters

```docker
$ docker inspect --format {{.NetworkSettings.IPAddress}} a1b
```

## How to check Logs

```docker
$ docker logs a1b
root@collabnix:/# hostname
collabnix
```

## Stopping the Container

```docker
docker stop <containerid>
```

## Cleaning up stopped containers

```docker
$ docker rm -v $(docker ps -aq -f status=exited)
```

## Stopping all containers

```docker
$ docker stop $(docker ps -a -q)
```
