---
layout: default
title: Beginners Track - Running a command inside running Container
description: collabnix | DockerLab | Docker - Beginners Track
--- 

# Running a command inside running Container


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


## Create Ubuntu Container

```
docker run -dit ubuntu
```

## Opening up the bash shell

```
docker exec -t <container-id> bash
```

Proceed » [Managing Docker Containers](http://dockerlabs.collabnix.com/beginners/managing-containers.html)
