## Creating Volume Mount from **docker run** command & sharing same Volume Mounts among multiple containers

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
- Click on "Add New Node"


## Volumes can be shared across containers

## Preparations

 - Clean your docker host using the commands :

```
$ docker rm -f $(docker ps -a -q)
```

```
$ docker volume rm $(docker volume ls -q)
```

## Task 

1. The Task for this lab is to create a volume, call it my_volume.

2. you should than run a simple an thin container and attach a volume to it.
use the image selaworkshops/busybox:latest and use any name to the mounted volume directory (e.g : data)

3. change something in the volume folder , e.g : add a file with some content.

4. create a second volume mounted to the same volume , make sure the file you created in step 3 exists !


## Instructions

 - Display existing volumes:
```
$ docker volume ls
```

 - Create a new volume:
```
$ docker volume create my-volume
```

 - Inspect the new volume to find the mountpoint (volume location):
```
$ docker volume inspect my-volume
```
```
[
    {
        "CreatedAt": "2018-06-13T20:36:15Z",
        "Driver": "local",
        "Labels": {},
        "Mountpoint": "/var/lib/docker/volumes/my-volume/_data",
        "Name": "my-volume",
        "Options": {},
        "Scope": "local"
    }
]
```

 - Let's run a container and mount the created volume to the root:
```
$ docker run -it -v my-volume:/data --name my-container selaworkshops/busybox:latest
```

 - Create a new file under /data:
```
$ cd /data
$ echo "hello" > hello.txt
$ ls
```

 - Open other terminal instance and run other container with the same volume:
```
$ docker run -it -v my-volume:/data --name my-container-2 selaworkshops/busybox:latest
```

 - Inspect the /data folder (the created file will be there):
```
$ cd data
$ ls
```

 - Exit from both containers and delete them:
```
$ exit
$ docker rm -f my-container my-container-2
```

 - Ensure the containers were deleted
```
$ docker ps -a
```

 - Run a new container attaching the created volume:
```
$ docker run -it -v my-volume:/data --name new-container selaworkshops/busybox:latest
```

 - Inspect the /data folder (the created file will be there):
```
$ cd data
$ ls
```

 - Exit from the container and delete it:
```
$ exit
$ docker rm -f new-container
```

Next >> [The docker network Command](http://dockerlabs.collabnix.com/beginners/using-docker-network.html)
