# Docker for Mac 18.03 comes with NFS Functionality for Kubernetes

# Pre-requisite:

- Install Docker for Mac 18.03


# Getting Started

## Execute the below script on your macOS system

```
sh env_vars.sh
```

```
sh setup_native_nfs_docker_osx.sh

 +-----------------------------+
 | Setup native NFS for Docker |
 +-----------------------------+

WARNING: This script will shut down running containers.

-n Do you wish to proceed? [y]:
y

== Stopping running docker containers...
== Resetting folder permissions...
Password:
== Setting up nfs...
== Restarting nfsd...
The nfsd service does not appear to be running.
Starting the nfsd service
== Restarting docker...

SUCCESS! Now go run your containers 🐳
```

# Bringing up Your Application

```
docker stack deploy -c docker-compose.yml myapp2
 docker stack ls
NAME                SERVICES
myapp2                1
```

```
[Captains-Bay]🚩 >  kubectl get po
NAME      READY     STATUS    RESTARTS   AGE
web-0     1/1       Running   0          3m
[Captains-Bay]🚩 >  kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)     AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP     1d
web          ClusterIP   None         <none>        55555/TCP   3m
```
