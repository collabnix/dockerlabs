---
layout: default
title: Beginners Track - Accessing the Container Shell
description: collabnix | DockerLab | Docker - Beginners Track
---

# Accessing the Container Shell


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

## Accessing the container shell

```
docker exec -t <container-id> bash
```

## Accesssing the container shell

```
docker attach <container-id>

```

[Proceed >> Running a Command inside running Container](http://dockerlabs.collabnix.com/beginners/running-command-inside-running-container.html)
