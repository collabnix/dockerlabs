# What is Dockerfile?

The humble but powerful Dockerfile is the building block of Docker images and containers. In essence, it's a list of commands the Docker engine runs to assemble the
image, and thus instances of images as containers.

## Building Nginx Docker Image using Dockerfile

```
git clone https://github.com/ajeetraina/docker101
cd docker101/beginners/nginx
```

```
docker build -t ajeetraina/mynginx .
```

``
docker inspect <containerid>
```

```
]
[node2] (local) root@192.168.0.7 ~
$ docker inspect 8f| grep Vendor
                "Vendor": "Collabnix Products",
                "Vendor": "Collabnix Products",
[node2] (local) root@192.168.0.7 ~
$
```

