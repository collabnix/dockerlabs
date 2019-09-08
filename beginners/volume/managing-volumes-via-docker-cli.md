## Managing volumes through Docker CLI

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


Execute the following commands:


## Creating Volume called demo
```
docker volume create demo
```


## Listing Docker Volumes

```
docker volume ls
```

## Inspecting "demo" Docker Volume

```
docker inspect demo
```


## Removing the "demo" Docker Volume
```
docker volume rm demo
```
Next >> [Creating Volume Mount from docker run command & sharing same Volume Mounts among multiple containers](https://collabnix.github.io/dockerlabs/beginners/volume/creating-volume-mount-from-dockercli.html)
