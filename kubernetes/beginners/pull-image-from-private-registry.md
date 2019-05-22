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


```
[node1 install]$ kubectl get nodes
NAME      STATUS     ROLES     AGE       VERSION
node1     Ready      master    39s       v1.11.3
node2     NotReady   <none>    19s       v1.11.3
[node1 install]$ cat ~/.docker/config.json
{
        "auths": {
                "https://index.docker.io/v1/": {
                        "auth": "YWplZXRyYWluYTpPcmFjbGU5aWFz"                }
        },
        "HttpHeaders": {
                "User-Agent": "Docker-Client/18.06.1-ce (linux)"
        }
}[node1 install]$
```

