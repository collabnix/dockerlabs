# A First Look at Docker Application Packages ("docker-app")

Consider a scenario where you have separate development, test, and production environments for your Web application. Under development environment, your team might be spending time in building up Web application(say, WordPress), developing WP Plugins and templates, debugging the issue etc.  When you are in development you’ll probably want to check your code changes in real-time. The usual way to do this is mounting a volume with your source code in the container that has the runtime of your application. But for production this works differently. Before you host your web application in production environment, you might want to turn-off the debug mode and host it under the right port so as to test your application usability and accessibility. In production you have a cluster with multiple nodes, and in most of the case volume is local to the node where your container (or service) is running, then you cannot mount the source code without complex stuff that involve code synchronization, signals, etc. In nutshell, this might require multiple Docker compose files for each environment and as your number of service applications increases, it becomes more cumbersome to manage those pieces of Compose files. Hence, we need a tool which can ease the way Compose files can be shareable across  different environment seamlessly.

To solve this problem, Docker, Inc recently announced a new tool called “docker-app”(Application Packages) which makes “Compose files more reusable and shareable”. This tool not only makes Compose file shareable but provide us with simplified approach to share multi-service application (not just Docker Image) directly on Dockerhub.

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Docker</b></td>
    <td class="tg-yw4l"><b>5</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Spanner Sign** on the left side of the screen to bring up template of 3 Managers & 2 Worker Nodes


## Verifying 5 Node Swarm Mode Cluster

```bash
$ docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
juld0kwbajyn11gx3bon9bsct *   manager1            Ready               Active              Leader              18.03.1-ce
uu675q2209xotom4vys0el5jw     manager2            Ready               Active              Reachable           18.03.1-ce
05jewa2brfkvgzklpvlze01rr     manager3            Ready               Active              Reachable           18.03.1-ce
n3frm1rv4gn93his3511llm6r     worker1             Ready               Active                                  18.03.1-ce
50vsx5nvwx5rbkxob2ua1c6dr     worker2             Ready               Active                                  18.03.1-ce
```

## Cloning the Repository

```bash
$ git clone https://github.com/ajeetraina/app
Cloning into 'app'...remote: Counting objects: 14147, done.
remote: Total 14147 (delta 0), reused 0 (delta 0), pack-reused 14147Receiving objects: 100% (14147/14147), 17.32 MiB | 18.43 MiB/s, done.
Resolving deltas: 100% (5152/5152), done.
```

## Installing docker-app

```bash
wget https://github.com/docker/app/releases/download/v0.3.0/docker-app-linux.tar.gz
tar xf docker-app-linux.tar.gz
cp docker-app-linux /usr/local/bin/docker-app
```

OR

```bash
$ ./install.sh
Connecting to github.com (192.30.253.112:443)
Connecting to github-production-release-asset-2e65be.s3.amazonaws.com (52.216.227.152:443)
docker-app-linux.tar 100% |**************************************************************|  8780k  0:00:00 ETA
[manager1] (local) root@192.168.0.13 ~/app
$
```

## Verify docker-app version

```bash
$ docker-app version
Version:      v0.3.0
Git commit:   fba6a09
Built:        Fri Jun 29 13:09:30 2018
OS/Arch:      linux/amd64
Experimental: off
Renderers:    none
```

The ```docker-app``` tool comes with various options as shown below:

```bash
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

Under this demo, you will see that there is a folder called wordpress.dockerapp that contains three YAML documents:

- metadata
- the compose file
- settings for your application

You can create these files using the below command:

```bash
docker-app init --single-file wordpress
```

For more details, you can visit https://github.com/docker/app

## Listing the Wordpress Application package related files/directories

```bash
$ ls
README.md            install-wp           with-secrets.yml
devel                prod                 wordpress.dockerapp
```

## Wordpress Application Package for Dev environment

```bash
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

## Wordpress Application Package for Prod

Under Prod environment, I have the following content under prod/prod-settings.yml as shown :

```bash
debug: false
wordpress:
port: 80
```

Post rendering, you should be able to see port:80 exposed as shown below in the snippet:

```bash
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

```bash
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

```bash
$ docker-app deploy wordpress
Creating network wordpress_overlay
Creating service wordpress_mysql
Creating service wordpress_wordpress
```

## Switching to Dev Environ

```bash
$ docker-app deploy wordpress -f devel/dev-settings.yml
```

![docker-app](https://github.com/ajeetraina/docker101/blob/master/images/dockerapp1.png)

## Switching to Prod Environ

```bash
$ docker-app deploy wordpress -f prod/prod-settings.yml
```

![docker-app](https://github.com/ajeetraina/docker101/blob/master/images/dockerapp2.png)

```bash
$ [manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
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

```bash
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

```bash
$ [manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$ docker-app save wordpress
Saved application as image: wordpress.dockerapp:1.0.0
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$
```

## Listing out the images

```bash
$ docker images
REPOSITORY            TAG                 IMAGE ID            CREATED             SIZE
wordpress.dockerapp   1.0.0               c1ec4d18c16c        47 seconds ago      1.62kB
mysql                 5.6                 97fdbdd65c6a        3 days ago          256MB
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$
```

## Listing out the services

```bash
$ docker stack services wordpress
ID                  NAME                  MODE                REPLICAS            IMAGE               PORTS
l95b4s6xi7q5        wordpress_wordpress   replicated          1/1                 wordpress:latest    *:80->80
/tcp
lhr4h2uaer86        wordpress_mysql       replicated          1/1                 mysql:5.6
[manager1] (local) root@192.168.0.48 ~/docker101/play-with-docker/visualizer
```

## Using ```docker-app ls``` command to list out the application packages

```bash
$ docker-app ls
REPOSITORY            TAG                 IMAGE ID            CREATED              SIZE
wordpress.dockerapp   1.0.1               299fb78857cb        About a minute ago   1.62kB
wordpress.dockerapp   1.0.0               c1ec4d18c16c        16 minutes ago       1.62kB
```

## Pushing it to Dockerhub

```bash
$ docker-app push --namespace ajeetraina --tag 1.0.1
The push refers to repository [docker.io/ajeetraina/wordpress.dockerapp]
51cfe2cfc2a8: Pushed
1.0.1: digest: sha256:14145fc6e743f09f92177a372b4a4851796ab6b8dc8fe49a0882fc5b5c1be4f9 size: 524
```

Say, you built WordPress application package and pushed it to Dockerhub. Now one of your colleague pull it on his development system.

## Pulling it from Dockerhub

```bash
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

```bash
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

Docker Team has introduced ```docker-app merge``` option under the new 0.3.0 release.

```bash
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$ docker-app merge -o mywordpress
[manager1] (local) root@192.168.0.48 ~/app/examples/wordpress
$ ls
README.md            install-wp           prod                 wordpress.dockerapp
devel                mywordpress          with-secrets.yml
```

```bash
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
 
 # Contributor
 
 [Ajeet Singh Raina](mailto:ajeetraina@gmail.com)
