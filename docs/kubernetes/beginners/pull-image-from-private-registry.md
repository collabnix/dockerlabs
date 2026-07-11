# How to create Pod that uses secret to pull an Image from Private Docker Registry

This tutorial shows how to create a Pod that uses a Secret to pull an image from a private Docker registry or repository.

## Infrastructure Setup

- Open https://play-with-k8s.com
- Clone the Repository

```
git clone https://github.com/ajeetraina/kubernetes101
```

- Execute the script

```
cd kubernetes101/install
sh bootstrap.sh
```

- Copy the join token and paste it on new instance to create 1 manager and 1 worker node

## Steps:

## Creating Password File

Create a password file with one entry for the user testuser, with password testpassword:

```
$ mkdir auth
$ docker run \
  --entrypoint htpasswd \
  registry:2 -Bbn testuser testpassword > auth/htpasswd
```

## Stop the registry.

```
$ docker container stop registry
```

## Start the registry with basic authentication.

```
$ docker run -d \
  -p 5000:5000 \
  --restart=always \
  --name registry \
  -v "$(pwd)"/auth:/auth \
  -e "REGISTRY_AUTH=htpasswd" \
  -e "REGISTRY_AUTH_HTPASSWD_REALM=Registry Realm" \
  -e REGISTRY_AUTH_HTPASSWD_PATH=/auth/htpasswd \
  -v "$(pwd)"/certs:/certs \
  -e REGISTRY_HTTP_TLS_CERTIFICATE=/certs/domain.crt \
  -e REGISTRY_HTTP_TLS_KEY=/certs/domain.key \
  registry:2
```

```
[node1 ~]$ ls
anaconda-ks.cfg  auth  certs  kubernetes101
```

```
[node1 ~]$ cd auth/
[node1 auth]$ ls
htpasswd
```

```
[node1 ~]$ docker login 127.0.0.1:5000
Username: testuser
Password: testpassword
WARNING! Your password will be stored unencrypted in /root/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store
```

```
[node1 ~]$ kubectl create secret docker-registry myregistrykey --docker-server=http://127.0.0.1:5000 --docker-username=testuser --docker-password=testpassword --docker-email=ajeetraina@gmail.com
secret/myregistrykey created
```

```
[node1 ~]$ docker tag ubuntu:18.04 127.0.0.1:5000/myubuntu
[node1 ~]$ docker push 127.0.0.1:5000/myubuntu
The push refers to repository [127.0.0.1:5000/myubuntu]
8d267010480f: Pushed
270f934787ed: Pushed
02571d034293: Pushed
latest: digest: sha256:b36667c98cf8f68d4b7f1fb8e01f742c2ed26b5f0c965a788e98dfe589a4b3e4 size: 943
```

```
export DOCKER_REGISTRY_SERVER=https://index.docker.io/v1/
export DOCKER_USER=Type your dockerhub username, same as when you `docker login`
export DOCKER_EMAIL=Type your dockerhub email, same as when you `docker login`
export DOCKER_PASSWORD=Type your dockerhub pw, same as when you `docker login`
```

```
kubectl create secret docker-registry myregistrykey \
  --docker-server=$DOCKER_REGISTRY_SERVER \
  --docker-username=$DOCKER_USER \
  --docker-password=$DOCKER_PASSWORD \
  --docker-email=$DOCKER_EMAIL
```

If your username on DockerHub is DOCKER_USER, and your private repo is called PRIVATE_REPO_NAME, and the image you want to pull is tagged "latest", create this dummy.yaml file:

```
apiVersion: v1
kind: Pod
metadata:
  name: foo
spec:
  containers:
    - name: whatever
      image: index.docker.io/ajeetraina/myubuntu:latest
      imagePullPolicy: Always
      command: [ "echo", "SUCCESS" ]
  imagePullSecrets:
    - name: myregistrykey
```

Then run:

```
kubectl create -f dummy.yaml
```

```
oo       0/1       Completed   2          36s
[node1 ~]$ kubectl get po
NAME      READY     STATUS    RESTARTS   AGE
foo       1/1       Running   4          1m
[node1 ~]$ kubectl get po
NAME      READY     STATUS      RESTARTS   AGE
foo       0/1       Completed   4          1m
[node1 ~]$ kubectl describe po fooName:               foo
Namespace:          default
Priority:           0
PriorityClassName:  <none>
Node:               node2/192.168.0.7
Start Time:         Wed, 22 May 2019 16:59:51 +0000
Labels:             <none>
Annotations:        kubectl.kubernetes.io/last-applied-configuration={"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"name":"foo","namespace":"default"},"spec":{"containers":[{"command":["echo","SUCCESS"],"i...
Status:             Running
IP:                 10.32.0.4
Containers:
  whatever:
    Container ID:  docker://01d1b2c3717bca065ef4a2cdf1f5b48d5aaa05ea6610f1ebfab4aed562f41d08
    Image:         index.docker.io/ajeetraina/myubuntu:latest
    Image ID:      docker-pullable://ajeetraina/myubuntu@sha256:6102e25bafa73573ecdc7e06a98d3bb968f0d11de294cbf15d7a3001d8f92887
    Port:          <none>
    Host Port:     <none>
    Command:
      echo
      SUCCESS
    State:          Waiting
      Reason:       CrashLoopBackOff
    Last State:     Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Wed, 22 May 2019 17:01:32 +0000
      Finished:     Wed, 22 May 2019 17:01:33 +0000
    Ready:          False
    Restart Count:  4
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-n4s7j (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             False
  ContainersReady   False
  PodScheduled      True
Volumes:
  default-token-n4s7j:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-n4s7j
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute for 300s
                 node.kubernetes.io/unreachable:NoExecute for 300s
Events:
  Type     Reason     Age               From               Message
  ----     ------     ----              ----               -------
  Normal   Scheduled  1m                default-scheduler  Successfully assigned default/foo to node2
  Normal   Created    1m (x4 over 1m)   kubelet, node2     Created container
  Normal   Started    1m (x4 over 1m)   kubelet, node2     Started container
  Warning  BackOff    33s (x7 over 1m)  kubelet, node2     Back-off restarting failed container
  Normal   Pulling    18s (x5 over 1m)  kubelet, node2     pulling image "index.docker.io/ajeetraina/myubuntu:latest"
  Normal   Pulled     17s (x5 over 1m)  kubelet, node2     Successfully pulled image "index.docker.io/ajeetraina/myubuntu:latest"
[node1 ~]$
[node1 ~]$
[node1 ~]$
f042e2df8b77        b3b94275d97c            "/coredns -conf /etc…"   About an hour ago    Up About an hour
```


# A Simple Nginx Example

```
[node1 ~]$ kubectl get po^C[node1 ~]$ export DOCKER_REGISTRY_SERVER=http://127.0.0.1:5000[node1 ~]$ export DOCKER_USER=testuser[node1 ~]$ export DOCKER_PASSWORD=testpassword
[node1 ~]$ kubectl create secret docker-registry myown   --docker-server=$DOCKER_REGISTRY_SERVER   --docker-username=$DOCKER_USER   --docker-password=$DOCKER_PASSWORD   --docker-email=$DOCKER_EMAIL
secret/myown created
[node1 ~]$ docker pull nginxUsing default tag: latest
latest: Pulling from library/nginx
743f2d6c1f65: Pull complete
6bfc4ec4420a: Pull complete
688a776db95f: Pull complete
Digest: sha256:23b4dcdf0d34d4a129755fc6f52e1c6e23bb34ea011b315d87e193033bcd1b68
Status: Downloaded newer image for nginx:latest
[node1 ~]$ docker images | grep nginx
nginx                                      latest              53f3fd8007f7        2 weeks ago         109MB
[node1 ~]$ docker tag nginx:latest 127.0.0.1:5000/mynginx
[node1 ~]$ docker push 127.0.0.1:5000/mynginx
The push refers to repository [127.0.0.1:5000/mynginx]
332fa54c5886: Pushed
6ba094226eea: Pushed
6270adb5794c: Pushed
latest: digest: sha256:e770165fef9e36b990882a4083d8ccf5e29e469a8609bb6b2e3b47d9510e2c8d size: 948
```

