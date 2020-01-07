# Kubectl for Docker

## PWD:

```
docker run -d --restart=always -e DOMAIN=cluster --name nginx-app -p 80:80 nginx
```

```
[node4 ~]$ docker exec -it 9dc env
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
HOSTNAME=9dc0816328dcTERM=xterm
DOMAIN=cluster
NGINX_VERSION=1.17.6
NJS_VERSION=0.3.7
PKG_RELEASE=1~buster
HOME=/root
```

## PWK:

Start the pod running nginx

```
kubectl run --image=nginx nginx-app --port=80 --env="DOMAIN=cluster"
```

Expose a port through with a service

```
kubectl expose deployment nginx-app --port=80 --name=nginx-http
```


```
[node1 replicaset101]$ kubectl get po,svc,deploy
NAME                             READY   STATUS    RESTARTS   AGE
pod/nginx-app-7c58988fb9-sckpd   1/1     Running   0          3m12s
pod/portainer-8586dccbb5-x66vk   1/1     Running   1          49m

NAME                 TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
service/kubernetes   ClusterIP      10.96.0.1       <none>        443/TCP        53m
service/nginx-http   ClusterIP      10.108.29.166   <none>        80/TCP         2m11s
service/portainer    LoadBalancer   10.98.58.121    <pending>     80:32001/TCP   49m

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.extensions/nginx-app   1/1     1            1           3m15s
deployment.extensions/portainer   1/1     1            1           49m
[node1 replicaset101]$ curl 10.108.29.166:80
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>

```
