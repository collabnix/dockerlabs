# Running WordPress Application using Docker under Docker Swarm Mode


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


## Cloning the Repository

```
$ git clone https://github.com/collabnix/dockerlabs
$ cd dockerlabs
$ cd solution/wordpress
```

## Bring up WordPress Application Stack

```
$ docker stack deploy -c docker-stack.yml myapp4
Ignoring unsupported options: restart

Creating network myapp4_default
Creating service myapp4_db
Creating service myapp4_wordpress
```
