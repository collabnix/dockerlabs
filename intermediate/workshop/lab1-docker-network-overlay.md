# Lab01 - Create Overlay Network under Docker Swarm

The overlay network is used to enable containers on different hosts to communicate. Under this lab exercise, we will see how to create Overlay network.

## Pre-requisite:

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
- Create 5 Node Instances by clicking on "hammer" sign on the left side of the UI interface

The following command will create a new overlay network called collabnet. All containers registered to this network can communicate with 
each other, regardless of which node they are deployed onto.

```
docker network create -d overlay collabnet
```

## Displaying the overlay network

```
docker network ls
```

## Inspecting the overlay network

```
docker network inspect collabnet
```


[Lab2- Deploy Services](lab2-deploy-services.md)
