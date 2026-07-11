# Deploying Nginx on Single Node K8s Cluster

```
kubectl create deployment nginx --image=nginx
```

```
[node1 ~]$ kubectl create service nodeport nginx --tcp=80:80 --node-port=30036
service "nginx" created
```

```
[node1 ~]$ curl 127.0.0.1:30036
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
[node1 ~]$
```
You can access Nginx using URL:

```
http://ip172-18-0-10-bdom99pfea0000fqcvgg.direct.labs.play-with-k8s.com:30036/
```



