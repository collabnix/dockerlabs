
# Sandboxed containers  Up & Running with gVisor and Docker.


## Download a Nightly Build

```
root@ubuntu18:~# wget https://storage.googleapis.com/gvisor/releases/nightly/latest/runsc
--2018-05-18 22:18:14--  https://storage.googleapis.com/gvisor/releases/nightly/latest/runsc
Resolving storage.googleapis.com (storage.googleapis.com)... 172.217.11.176, 2607:f8b0:4007:804::2010
Connecting to storage.googleapis.com (storage.googleapis.com)|172.217.11.176|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 14586715 (14M) [application/octet-stream]
Saving to: ‘runsc’

runsc             100%[==========>]  13.91M   903KB/s    in 17s

2018-05-18 22:18:33 (829 KB/s) - ‘runsc’ saved [14586715/14586715]

root@ubuntu18:~#

```


```
chmod +xrunsc
```
```
mv runsc /usr/local/bin
```


## Configuring Docker


```
root@ubuntu18:~# cat /etc/docker/daemon.json
{
    "runtimes": {
        "runsc": {
            "path": "/usr/local/bin/runsc"
        }
    }
}

```

# Restarting the Docker Daemon

```
sudo systemctl restart docker
```

## Verifying using `docker info`


```
root@ubuntu18:~# docker info
Containers: 84
 Running: 0
 Paused: 0
 Stopped: 84
Images: 86
Server Version: 17.12.1-ce
Storage Driver: overlay2
 Backing Filesystem: extfs
 Supports d_type: true
 Native Overlay Diff: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: bridge host macvlan null overlay
 Log: awslogs fluentd gcplogs gelf journald json-file logentries splu                                   nk syslog
Swarm: active
 NodeID: h3rplbo27li6pat6kijyzvoh5
 Is Manager: true
 ClusterID: j7sr08grm7daq7zfr4evlaqb8
 Managers: 1
 Nodes: 1
 Orchestration:
  Task History Retention Limit: 5
 Raft:
  Snapshot Interval: 10000
  Number of Old Snapshots to Retain: 0
  Heartbeat Tick: 1
  Election Tick: 3
 Dispatcher:
  Heartbeat Period: 5 seconds
 CA Configuration:
  Expiry Duration: 3 months
  Force Rotate: 0
 Autolock Managers: false
 Root Rotation In Progress: false
 Node Address: 100.98.26.129
 Manager Addresses:
  100.98.26.129:2377
Runtimes: runc runsc
Default Runtime: runc
Init Binary: docker-init
containerd version: 9b55aab90508bd389d7654c4baf173a981477d55
runc version: 9f9c96235cc97674e935002fc3d78361b696a69e
init version: v0.13.0 (expected: 949e6facb77383876aeff8a6944dde66b308                                   9574)
Security Options:
 apparmor
 seccomp
  Profile: default
Kernel Version: 4.15.0-15-generic
Operating System: Ubuntu Bionic Beaver (development branch)
OSType: linux
Architecture: x86_64
CPUs: 1
Total Memory: 19.6GiB
Name: ubuntu18
ID: HN7H:YV3P:VXZA:CMUS:NH4Z:GPEG:OUEJ:DM5L:56PF:GTHB:WQRU:TAB5
Docker Root Dir: /var/lib/docker
Debug Mode (client): false
Debug Mode (server): false
Registry: https://index.docker.io/v1/
Labels:
Experimental: false
Insecure Registries:
 127.0.0.0/8
Live Restore Enabled: false
```

## Can Nginx work with runsc?

No. nginx: Requires ioctl(FIOASYNC), but see workaround in bug #1.

```
root@ubuntu18:~/gvisor# docker run --runtime=runsc -d -p 83:80 nginx
cb2be712933805a4652f312d17967f168cd2695870babba82db297f2830f9e0e
root@ubuntu18:~/gvisor# docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
cb2be7129338        nginx               "nginx -g 'daemon of…"   3 seconds ago       Up 2 seconds        0.0.0.0:83->80/tcp   eager_wright
9669c55f3c22        nginx               "nginx -g 'daemon of…"   52 seconds ago      Up 51 seconds       0.0.0.0:80->80/tcp   priceless_leakey
root@ubuntu18:~/gvisor# docker logs -f cb2
2018/05/18 16:58:47 [alert] 1#1: ioctl(FIOASYNC) failed while spawning "worker process" (25: Inappropriate ioctl for device)

```

