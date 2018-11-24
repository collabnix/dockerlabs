# Dockerize WordPress Application running under 5-Node Docker Swarm Node Cluster


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
- Click on "Hammer" sign near to select 3 Managers and 2 worker nodes


## Cloning the Repository

```
$ git clone https://github.com/collabnix/dockerlabs
$ cd dockerlabs
$ cd solution/wordpress
```

## Bring up WordPress Application Stack

```
$ docker stack deploy -c docker-stack.yml myapp4

Creating network myapp4_default
Creating service myapp4_db
Creating service myapp4_wordpress
```

## Contributor

- [Ajeet Singh Raina](ajeetraina@gmail.com)
