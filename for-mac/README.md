# Curated List of Docker for Mac Tutorials


[Docker for Mac is built with LinuxKit. How to access the LinuxKit VM](https://github.com/ajeetraina/docker101/blob/master/for-mac/linuxkit.md)<br>
[Top 5 Exclusive Features of Docker for Mac That you can't afford to ignore](http://collabnix.com/top-5-exclusive-features-of-docker-for-mac-that-you-cant-afford-to-miss/)<br>
[5 Minutes to Bootstrap Kubernetes Cluster on GKE using Docker for Mac 18.03.0](http://collabnix.com/bootstrapping-kubernetes-cluster-using-docker-for-mac-18-03-0-ce-edition/)<br>
[Context Switching Made Easy under Kubernetes powered Docker for Mac 18.02.0](http://collabnix.com/namespace-context-toggling-made-easy-under-docker-for-mac-18-02-release/)<br>
[2-minutes to Kubernetes Cluster on Docker for Mac 18.01 using Swarm CLI](http://collabnix.com/running-kubernetes-cluster-on-docker-for-mac-18-01-using-swarm-cli/)<br>
[Docker For Mac 1.13.0 brings support for macOS Sierra, now runs ARM & AARCH64 based Docker containers](http://collabnix.com/running-docker-engine-1-13-0-on-apple-mac-os-x-sierra/)<br>
[Docker for Mac 18.03.0 now comes with NFS Volume Sharing Support for Kubernetes](https://github.com/ajeetraina/docker101/blob/master/for-mac/nfs/README.md)<br>

# Docker for Mac Tips & Tricks

## #1: How to change hostname of Swarm Node under Docker for Mac?

```
docker run -it --privileged --pid=host justincormack/nsenter1 /bin/sh -c "hostname foobar"
```

```

DOCKER_ORCHESTRATOR=swarm docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
oumrrgu03r2r8ml7zlec5kozb *   foobar              Ready               Active              Leader              18.05.0-ce-rc1
```

## #2: How to fix "docker node ls is not supported" error?

```
[Captains-Bay]🚩 >  docker node ls
docker node ls is only supported on a Docker cli with swarm features enabled
```
```
[Captains-Bay]🚩 DOCKER_ORCHESTRATOR=swarm docker node ls
ID                            HOSTNAME                STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
oumrrgu03r2r8ml7zlec5kozb *   linuxkit-025000000001   Ready               Active              Leader              18.05.0-ce-rc1
```

## #3: If Docker for Mac is built with LinuxKit. How shall I verify that the service container is running inside Linuxkit VM?


You can enter into LinuxKit VM with the below command:

```
screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty

```


```
ctr -n services.linuxkit tasks ls
TASK                    PID     STATUS
acpid                   854     RUNNING
diagnose                898     RUNNING
docker-ce               936     RUNNING
host-timesync-daemon    984     RUNNING
ntpd                    1025    RUNNING
trim-after-delete       1106    RUNNING
vpnkit-forwarder        1157    RUNNING
vsudd                   1198    RUNNING
```
