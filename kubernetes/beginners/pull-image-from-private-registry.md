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





