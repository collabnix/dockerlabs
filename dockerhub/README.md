# How to authenticate your DockerHub Account with new V2 API and list out all the repositories

The following example script demonstrates authentication with the new V2 API.

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


## Steps

## Install jq

```
apk update
apk add jq
```

## Cloning the Repository

```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/dockerhub/
```

## Setting up username and password

Edit the file and add your username and password:

```
vi 

