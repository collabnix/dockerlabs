# Docker for Mac 18.03 comes with NFS Functionality for Kubernetes

# Pre-requisite:

- Install Docker for Mac 18.03


# Getting Started

## Execute the below script on your macOS system

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
docker-compose up -d
```
