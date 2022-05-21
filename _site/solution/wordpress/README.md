# Running Dockerized WordPress Application in 5-Node Docker Swarm Mode Cluster


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
- Click on "Template" sign near to Instance on the left side of the PWD window.
- Select 3 Managers and 2 worker nodes template from drop-down menu
- This will bring up 5-Node Docker Swarm Mode cluster for you.


## Cloning the Repository

Run the below command on Manager1 node terminal

```
$ git clone https://github.com/collabnix/dockerlabs
$ cd dockerlabs
$ cd solution/wordpress
```

## Bring up WordPress Application Stack

```
$ docker stack deploy -c stack.yml myapp4

Creating network myapp4_default
Creating service myapp4_db
Creating service myapp4_wordpress
```

A Port 8000 will appear instantly. Wait for 20 seconds and then click it to open WordPress App.



## Contributor

- [Ajeet Singh Raina](mailto:ajeetraina@gmail.com)
