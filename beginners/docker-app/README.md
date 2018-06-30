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

![docker-app](https://github.com/ajeetraina/docker101/blob/master/images/dockerapp1.png)<br>
![docker-app](https://github.com/ajeetraina/docker101/blob/master/images/dockerapp1.png)<br>
