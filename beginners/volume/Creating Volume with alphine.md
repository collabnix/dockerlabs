## Creating Volume with alphine


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

# how to work with Docker volumes
 3 sub-sections:<br>
Create a Docker volume and pull Alpine image <br>
Create files in Alpine<br>
Verify the existence of Docker volume<br>

## Create a Docker volume and pull Alpine image
Create a Docker volume to which you will add persistent data.
docker volume create --name mydata

Create a Docker container, attach the data volume, and add persistent data. Pull a lightweight Alpine distribution image.
docker pull alpine
Create a container from Alpine and mount the volume mydata to /mnt.
```
docker run -ti --name client -v mydata:/mnt alpine /bin/sh
```
## Create files in Alpine 
Go to the /mnt directory, touch (create) two files, and verify they exist.
```
cd /mnt
touch foo.txt
touch bar.txt
ls
```
Exit the container.
```exit```

## Verify that the container exists and is stopped.
```docker ps -a```

 

##  Verify the existence of Docker volume 
Delete the container and then verify that it is gone.
```docker rm client
   docker ps –a
```

## Run a new container and mount the volume mydata to /mnt again.
```
docker run --rm -ti -v mydata:/mnt alpine /bin/sh
```

## Go to the /mnt directory and observe if the files still exist.
```
cd /mnt
ls
```

## Exit the container.
```
exit
```
## Verify that the volume still exists.
```
docker volume ls
```

 

## Clean up artifacts. 
```
docker rm -f $(docker ps -aq) .
docker rmi $(docker images -q)
docker volume rm $(docker volume ls -q)
```
 

## Contributor -

Sangam biradar -https://engineitops.github.io
