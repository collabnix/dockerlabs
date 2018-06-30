# A First Look at docker-app


## Deploy 5 Node Swarm Mode Cluster

```
$ docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
juld0kwbajyn11gx3bon9bsct *   manager1            Ready               Active              Leader              18.03.1-ce
uu675q2209xotom4vys0el5jw     manager2            Ready               Active              Reachable           18.03.1-ce
05jewa2brfkvgzklpvlze01rr     manager3            Ready               Active              Reachable           18.03.1-ce
n3frm1rv4gn93his3511llm6r     worker1             Ready               Active                                  18.03.1-ce
50vsx5nvwx5rbkxob2ua1c6dr     worker2             Ready               Active                                  18.03.1-ce
```

## Cloning the Repository

```
$ git clone https://github.com/ajeetraina/app
Cloning into 'app'...remote: Counting objects: 14147, done.
remote: Total 14147 (delta 0), reused 0 (delta 0), pack-reused 14147Receiving objects: 100% (14147/14147), 17.32 MiB | 18.43 MiB/s, done.
Resolving deltas: 100% (5152/5152), done.
```

## Installing docker-app

```
wget https://github.com/docker/app/releases/download/v0.2.0/docker-app-linux.tar.gz
tar xf docker-app-linux.tar.gz
cp docker-app-linux /usr/local/bin/docker-app
```

OR

```
$ ./install.sh
Connecting to github.com (192.30.253.112:443)
Connecting to github-production-release-asset-2e65be.s3.amazonaws.com (52.216.227.152:443)
docker-app-linux.tar 100% |**************************************************************|  8780k  0:00:00 ETA
[manager1] (local) root@192.168.0.13 ~/app
$ ^C
```

## Verify docker-app version

```
$ docker-app version
Version:      v0.2.0
Git commit:   854872f
Build time:   2018-06-11T15:06:17.093522032+00:00
OS/Arch:      linux/amd64
Experimental: off
Renderers:    none
```

## WordPress Application under dev & Prod environment

```
$ ls
README.md            install-wp           with-secrets.yml
devel                prod                 wordpress.dockerapp
```

## Rendering Wordpress Application Package for Development

```
$ docker-app render wordpress -f devel/dev-settings.yml
version: "3.6"
services:
  mysql:
    deploy:
      mode: replicated
      replicas: 1
      endpoint_mode: dnsrr
    environment:
      MYSQL_DATABASE: wordpressdata
      MYSQL_PASSWORD: wordpress
      MYSQL_ROOT_PASSWORD: wordpress101
      MYSQL_USER: wordpress
    image: mysql:5.6
    networks:
      overlay: null
    volumes:
    - type: volume
      source: db_data
      target: /var/lib/mysql
  wordpress:
    depends_on:
    - mysql
    deploy:
      mode: replicated
      replicas: 1
      endpoint_mode: vip
    environment:
      WORDPRESS_DB_HOST: mysql
      WORDPRESS_DB_NAME: wordpressdata
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DEBUG: "true"
    image: wordpress
    networks:
      overlay: null
    ports:
    - mode: ingress
      target: 80
      published: 8082
      protocol: tcp
networks:
  overlay: {}
volumes:
  db_data:
    name: db_data
```
    
    ## Rendering Wordpress Application Package for Prod
    
```
       image: wordpress
    networks:
      overlay: null
    ports:
    - mode: ingress
      target: 80
      published: 80
      protocol: tcp
networks:
  overlay: {}
volumes:
  db_data:
    name: db_data
```
    
    
## 
    
    
```
$ docker-app inspect wordpress
wordpress 1.0.0
Maintained by: ajeetraina <ajeetraina@gmail.com>

Welcome to Collabnix

Setting                       Default
-------                       -------
debug                         true
mysql.database                wordpressdata
mysql.image.version           5.6
mysql.rootpass                wordpress101
mysql.scale.endpoint_mode     dnsrr
mysql.scale.mode              replicated
mysql.scale.replicas          1
mysql.user.name               wordpress
mysql.user.password           wordpress
volumes.db_data.name          db_data
wordpress.port                8081
wordpress.scale.endpoint_mode vip
wordpress.scale.mode          replicated
wordpress.scale.replicas      1
[manager1] (local) root@192.168.0.13 ~/app/examples/wordpress
$
```

## 

```
$ docker-app deploy wordpress
Creating network wordpress_overlay
Creating service wordpress_mysql
Creating service wordpress_wordpress

```

## Under Dev Environ

```

$docker-app deploy wordpress -f devel/dev-settings.yml
```


![docker-app](https://github.com/ajeetraina/docker101/blob/master/images/dockerapp1.png)<br><br><br>

## Under Prod Environ

```

$docker-app deploy wordpress -f prod/prod-settings.yml
```


![docker-app](https://github.com/ajeetraina/docker101/blob/master/images/dockerapp2.png)<br>


```
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$ docker-app deploy -f devel/dev-settings.yml
Updating service wordpress_wordpress (id: l95b4s6xi7q5mg7vj26lhzslb)
Updating service wordpress_mysql (id: lhr4h2uaer861zz1b04pst5sh)
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$ docker-app deploy -f prod/prod-settings.yml
Updating service wordpress_wordpress (id: l95b4s6xi7q5mg7vj26lhzslb)
Updating service wordpress_mysql (id: lhr4h2uaer861zz1b04pst5sh)
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$
```

## Pushing Application Package to Dockerhub

```
$ docker login
Login with your Docker ID to push and pull images from Docker Hub. If you don't have a Docker ID, head over to
 https://hub.docker.com to create one.
Username: ajeetraina
Password:
Login Succeeded
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$

```

## Saving this Application Package as DOcker Image

```
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$ docker-app save wordpress
Saved application as image: wordpress.dockerapp:1.0.0
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$

```

##

```
$ docker images
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
wordpress.dockerapp   1.0.0               c1ec4d18c16c        47 seconds ago      1.62kB
mysql                 5.6                 97fdbdd65c6a        3 days ago          256MB
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$

```

```
$ docker stack services wordpress
ID                  NAME                  MODE                REPLICAS            IMAGE               PORTS
l95b4s6xi7q5        wordpress_wordpress   replicated          1/1                 wordpress:latest    *:80->80
/tcp
lhr4h2uaer86        wordpress_mysql       replicated          1/1                 mysql:5.6
[manager1] (local) root@192.168.0.48 ~/docker101/play-with-docker/visualizer
```

