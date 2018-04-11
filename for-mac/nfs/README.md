# Docker for Mac 18.03.0 now comes with NFS Volume Sharing Support for Kubernetes

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


```
[Captains-Bay]🚩 >  kubectl describe po web-0
Name:           web-0
Namespace:      default
Node:           docker-for-desktop/192.168.65.3
Start Time:     Wed, 11 Apr 2018 23:00:18 +0530
Labels:         com.docker.service.id=up2u-web
                com.docker.service.name=web
                com.docker.stack.namespace=up2u
                controller-revision-hash=web-7dbbf8689d
                statefulset.kubernetes.io/pod-name=web-0
Annotations:    <none>
Status:         Running
IP:             10.1.0.34
Controlled By:  StatefulSet/web
Containers:
  web:
    Container ID:  docker://ec9ad2a3192bdeb0cc5028453310f40fd0ac3595021b070465c4e7725f626d63
    Image:         alpine:3.6
    Image ID:      docker-pullable://alpine@sha256:3d44fa76c2c83ed9296e4508b436ff583397cac0f4bad85c2b4ecc193ddb5106
    Port:          <none>
    Args:
      ping
      127.0.0.1
    State:          Running
      Started:      Wed, 11 Apr 2018 23:00:19 +0530
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      #{CONTAINER_DIR} from nfsmount (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-n8trf (ro)
Conditions:
  Type           Status
  Initialized    True
  Ready          True
  PodScheduled   True
Volumes:
  nfsmount:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  nfsmount-web-0
    ReadOnly:   false
  default-token-n8trf:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-n8trf
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type    Reason                 Age   From                         Message
  ----    ------                 ----  ----                         -------
  Normal  Scheduled              5m    default-scheduler            Successfully assigned web-0 to docker-for-desktop
  Normal  SuccessfulMountVolume  5m    kubelet, docker-for-desktop  MountVolume.SetUp succeeded for volume "pvc-bbdc7903-3dad-11e8-a612-025000000001"
  Normal  SuccessfulMountVolume  5m    kubelet, docker-for-desktop  MountVolume.SetUp succeeded for volume "default-token-n8trf"
  Normal  Pulled                 5m    kubelet, docker-for-desktop  Container image "alpine:3.6" already present on machine
  Normal  Created                5m    kubelet, docker-for-desktop  Created container
  Normal  Started                5m    kubelet, docker-for-desktop  Started container
  ```


Reference:
- https://github.com/firepress-org/Docker-For-Mac-with-Native-NFS
