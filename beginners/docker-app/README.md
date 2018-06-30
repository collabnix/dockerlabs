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
wget https://github.com/docker/app/releases/download/v0.3.0/docker-app-linux.tar.gz
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
$ 
```

## Verify docker-app version

```
$ docker-app version
Version:      v0.3.0
Git commit:   fba6a09
Built:        Fri Jun 29 13:09:30 2018
OS/Arch:      linux/amd64
Experimental: off
Renderers:    none
```
The ```docker-app``` tool comes with various options as shown below:

```
$ docker-app
Build and deploy Docker applications.

Usage:
  docker-app [command]

Available Commands:
  deploy      Deploy or update an application
  helm        Generate a Helm chart
  help        Help about any command
  init        Start building a Docker application
  inspect     Shows metadata and settings for a given application
  ls          List applications.
  merge       Merge the application as a single file multi-document YAML
  push        Push the application to a registry
  render      Render the Compose file for the application
  save        Save the application as an image to the docker daemon(in preparation for push)
  split       Split a single-file application into multiple files
  version     Print version information

Flags:
      --debug   Enable debug mode
  -h, --help    help for docker-app

Use "docker-app [command] --help" for more information about a command.
[manager1] (local) root@192.168.0.48 ~/app
```

## WordPress Application under dev & Prod environment

```
$ ls
README.md            install-wp           with-secrets.yml
devel                prod                 wordpress.dockerapp
```

## Wordpress Application Package for Dev Environ

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
    
    
## Inspect the WordPress App
    
    
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

## Deploying the WordPress App

```
$ docker-app deploy wordpress
Creating network wordpress_overlay
Creating service wordpress_mysql
Creating service wordpress_wordpress

```

## Switching to Dev Environ


```
$docker-app deploy wordpress -f devel/dev-settings.yml
```


![docker-app](https://github.com/ajeetraina/docker101/blob/master/images/dockerapp1.png)<br><br><br>

## Switching to Prod Environ

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

## Listing out 

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

```
$ docker-app ls
REPOSITORY            TAG                 IMAGE ID            CREATED              SIZE
wordpress.dockerapp   1.0.1               299fb78857cb        About a minute ago   1.62kB
wordpress.dockerapp   1.0.0               c1ec4d18c16c        16 minutes ago       1.62kB
```

## Pusing it to Dockerhub

```
$ docker-app push --namespace ajeetraina --tag 1.0.1
The push refers to repository [docker.io/ajeetraina/wordpress.dockerapp]
51cfe2cfc2a8: Pushed
1.0.1: digest: sha256:14145fc6e743f09f92177a372b4a4851796ab6b8dc8fe49a0882fc5b5c1be4f9 size: 524
```

## Pulling it from Dockerhub on new system

```
$ docker pull ajeetraina/wordpress.dockerapp:1.0.1
1.0.1: Pulling from ajeetraina/wordpress.dockerapp
a59931d48895: Pull complete
Digest: sha256:14145fc6e743f09f92177a372b4a4851796ab6b8dc8fe49a0882fc5b5c1be4f9
Status: Downloaded newer image for ajeetraina/wordpress.dockerapp:1.0.1
[manager3] (local) root@192.168.0.24 ~/app
$ docker images
REPOSITORY                       TAG                 IMAGE ID            CREATED             SIZE
ajeetraina/wordpress.dockerapp   1.0.1               299fb78857cb        8 minutes ago       1.62kB
[manager3] (local) root@192.168.0.24 ~/app
$

```

## Deploying the Application in Easy Way

```
$ docker images
REPOSITORY                       TAG                 IMAGE ID            CREATED             SIZE
ajeetraina/wordpress.dockerapp   1.0.1               299fb78857cb        9 minutes ago       1.62kB
[manager3] (local) root@192.168.0.24 ~/app
$ docker-app deploy ajeetraina/wordpress
Creating network wordpress_overlay
Creating service wordpress_mysql
Creating service wordpress_wordpress
[manager3] (local) root@192.168.0.24 ~/app
$
```

## Using ```docker-app merge``` option

```
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$ docker-app merge -o mywordpress
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$ ls
README.md            install-wp           prod                 wordpress.dockerapp
devel                mywordpress          with-secrets.yml
```

```
$ cat mywordpress
version: 1.0.1
name: wordpress
description: "Welcome to Collabnix"
maintainers:
  - name: ajeetraina
    email: ajeetraina@gmail.com
targets:
  swarm: true
  kubernetes: true

--
version: "3.6"

services:

  mysql:
    image: mysql:${mysql.image.version}
    environment:
      MYSQL_ROOT_PASSWORD: ${mysql.rootpass}
      MYSQL_DATABASE: ${mysql.database}
      MYSQL_USER: ${mysql.user.name}
      MYSQL_PASSWORD: ${mysql.user.password}
    volumes:
       - source: db_data
         target: /var/lib/mysql
         type: volume
    networks:
       - overlay
    deploy:
      mode: ${mysql.scale.mode}
      replicas: ${mysql.scale.replicas}
      endpoint_mode: ${mysql.scale.endpoint_mode}

  wordpress:
    image: wordpress
    environment:
      WORDPRESS_DB_USER: ${mysql.user.name}
      WORDPRESS_DB_PASSWORD: ${mysql.user.password}
      WORDPRESS_DB_NAME: ${mysql.database}
      WORDPRESS_DB_HOST: mysql
      WORDPRESS_DEBUG: ${debug}
    ports:
      - "${wordpress.port}:80"
    networks:
      - overlay
    deploy:
      mode: ${wordpress.scale.mode}
      replicas: ${wordpress.scale.replicas}
      endpoint_mode: ${wordpress.scale.endpoint_mode}
    depends_on:
      - mysql

volumes:
  db_data:
     name: ${volumes.db_data.name}

networks:
  overlay:

--
debug: true
mysql:
  image:
    version: 5.6
  rootpass: wordpress101
  database: wordpressdata
  user:
    name: wordpress
    password: wordpress
  scale:
    endpoint_mode: dnsrr
    mode: replicated
    replicas: 1
wordpress:
  scale:
    mode: replicated
    replicas: 1
    endpoint_mode: vip
  port: 8081
volumes:
  db_data:
    name: db_data
 ```
