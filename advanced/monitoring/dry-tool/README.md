---
layout: default
title: Manage and Monitor Your Docker Containers with Dry Tool in 5 Min
description: collabnix | DockerLab | Docker - Advanced Track 
---

#  Manage and Monitor Your Docker Containers with Dry Tool in 5 Min

If you are looking out for a tool which can manage Docker & Docker Swarm, you really need to try out "Dry" tool. With close to 1500 stars in short span of time, this tool is a terminal application to manage both Docker Host & Docker Swarm Mode.It shows information about Containers, Images and Networks, and, if running a Swarm cluster, it shows information about Nodes, Service, Stacks and the rest of Swarm constructs. It can be used with both local or remote Docker daemons.

Besides showing information, it can be used to manage Docker. Most of the commands that the official Docker CLI provides, are available in dry with the same behaviour. also, it can also be used as a monitoring tool for Docker containers.Dry can be installed as a single binary and does not require external libraries.

Under this tutorial, I will show you how to get started with this tool to manage and monitor your Docker containers

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Docker</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side

## Running Multiple containers in an interactive and detached mode. 



```
[node1] (local) root@192.168.0.33 ~
$ docker pull busybox
Using default tag: latest
latest: Pulling from library/busybox
57c14dd66db0: Pull complete
Digest: sha256:7964ad52e396a6e045c39b5a44438424ac52e12e4d5a25d94895f2058cb863a0
Status: Downloaded newer image for busybox:latest
```

```
[node1] (local) root@192.168.0.33 ~
$ docker pull hello-world
Using default tag: latest
latest: Pulling from library/hello-world
1b930d010525: Pull complete
Digest: sha256:2557e3c07ed1e38f26e389462d03ed943586f744621577a99efb77324b0fe535
Status: Downloaded newer image for hello-world:latest
```

```
[node1] (local) root@192.168.0.33 ~
$ docker run -t -d busybox
7c96cde9894fd9ff42d1c3638cad65cf306cb2757b3925a925f4d421a510a79f
```
```
[node1] (local) root@192.168.0.33 ~
$ docker run -t -d hello-world
7a4198a31f61c380ddbe3b06eeb313da74de3d232727b0325937434900e8be8d
```


## Verifying if containers are Up and Running: 

```
$ docker ps

```
## Verifying the exited containers

```
$ docker ps -a
```

## Observe the below results:

```
[node1] (local) root@192.168.0.33 ~
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS      PORTS               NAMES
7c96cde9894f        busybox             "sh"                3 minutes ago       Up 3 minutes                          romantic_greider
[node1] (local) root@192.168.0.33 ~
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS             PORTS               NAMES
7a4198a31f61        hello-world         "/hello"            3 minutes ago       Exited (0) 3 minutes ago                       stupefied_tu
7c96cde9894f        busybox             "sh"                3 minutes ago       Up 3 minutes                                 romantic_greider

```

# Direct method 

## Running Dry tool in a single Shot 

```
$ docker run -it -v /var/run/docker.sock:/var/run/docker.sock moncho/dry
```



```
[node1] (local) root@192.168.0.33 ~
$ docker run -it -v /var/run/docker.sock:/var/run/docker.sock moncho/dry
Unable to find image 'moncho/dry:latest' locally
latest: Pulling from moncho/dry
4fe2ade4980c: Pull complete
e9c4f9f2a7e3: Pull complete
28bab79b92a9: Pull complete
Digest: sha256:ad57f88f39fd910cc42e9416594dd2cf92ae561ddd914fd1c333f989a8d5bd4b
Status: Downloaded newer image for moncho/dry:latest

```


## Interacting with Docker Containers:

Use the navigation keys mentioned below to interact with the terminal.

```
[H]:Help [Q]:Quit | [F1]:Sort [F2]:Toggle Show Containers [F5]:Refresh [%]:Filter |
[m]:Monitor mode [2]:Images [3]:Networks [4]:Nodes [5]:Services | [Enter]:Commands 

```

### Select any container from the list and hit [enter] to open the options:

```
Fetch logs
Inspect container
Kill container
Remove container
Restart
Show image history
Stats + Top
Stop

```
## Verifying the Results

![](https://raw.githubusercontent.com/sangam14/Docker-Containers-with-Dry-Tool/master/pic2.png)



## 2.Interacting with Docker images:

![](https://raw.githubusercontent.com/sangam14/Docker-Containers-with-Dry-Tool/master/Picture1.png)

 - Press [2] to switch to Docker images. It will show a list of your Docker images.
 - Select any image from the list and hit [enter] to show the details of the selected image.

You can use the shortcuts in Dry:<br>
“Ctrl + D” to remove dangling. It is equivalent to docker volume rm with the flag dangling=true <br>
“Ctrl + E” to remove image. It is equivalent to docker rmi. <br>
“CTRL + F” to force remove. It is equivalent to docker rmi --force <br>

## 3.Interacting with Docker Networks:

![](https://raw.githubusercontent.com/sangam14/Docker-Containers-with-Dry-Tool/master/Picture1.png)

- Press [3] to switch to Docker networks. It will show a list of your active Docker networks. 
- Select any network from the list and hit [enter] to fetch and show the details of the selected network. The output will look similar to the below: 

![](https://raw.githubusercontent.com/sangam14/Docker-Containers-with-Dry-Tool/master/Picture3.png)

# Manual method 

Download the latest version of Dry :

```
wget https://github.com/moncho/dry/releases/download/v0.9-beta.3/dry-linux-amd64

```
## Moving the file to /usr/local/bin/dry

```
sudo mv dry-linux-amd64 /usr/local/bin/dry

```
## Providing the access permissions.

```
sudo chmod 755 /usr/local/bin/dry

```
## Check the version of Dry:

```
dry -v

```

Next, time to tun dry. 
Type dry in the command and hit [enter]. 

You should get the similar output where your containers are running.
![](https://raw.githubusercontent.com/sangam14/Docker-Containers-with-Dry-Tool/master/Picture1.png)


# Reference:

- https://github.com/moncho/dry

## Contributor - 

[Sangam biradar](mailto:smbiradar14@gmail.com) -https://engineitops.com 

