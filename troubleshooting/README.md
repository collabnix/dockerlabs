# Troubleshooting Docker

# #1: Error starting daemon: error initializing graphdriver: \"/var/lib/docker\" contains several valid graph drivers: devicemapper, overlay; Please cleanup or explicitly choose storage driver (-s <DRIVER>)"

# Summary: 

It looks like you previously ran docker on this host with a different graph-driver. 
Because of that, docker refuses to start, because it cannot automatically choose which graph-driver it should use. 
You need to set the -s daemon option, for example -s=overlay or -s=devicemapper to pick which one you want to use.

# Error Mesaage

[root@ax ~]# docker info

Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running? 

# How to identify the issue

```
dockerd -D
```

# Resolution:

Open /etc/docker/daemon.json and add the below entry:

```
[root@awx ~]# cat /etc/docker/daemon.json
{ "storage-driver": "devicemapper" }
```

## Restart the Docker Daemon

```
systemctl restart docker
```



