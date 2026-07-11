# Demonstrating Docker-Ready Solution for Apache Jmeter

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

## cloning ng the Repository 

```
$git clone https://github.com/ajeetraina/jmeter-docker
$cd jmeter-docker
```

## Running Docker Compose</b>

```
$docker-compose up -d
```

It will push jmeter-master to the master node and jmeter-server to the slave nodes and make it ready to start load using the external JMX file.

```
$ docker service ls
              ID            NAME         MODE        REPLICAS  IMAGE
              mlffd5djek3t  myjm_slave   replicated  3/3       ajeetraina/jmeter-server:latest
              rv1r3cjvzkg3  myjm_master  replicated  1/1       ajeetraina/jmeter-master:latest
```

Let us verify these containers on both the nodes:

```
@master:~$ docker ps
          CONTAINER ID        IMAGE                                                                                                     
          COMMAND             CREATED             STATUS              PORTS               NAMES
          4954e3ef40f6        ajeetraina/jmeter-master@sha256:1ad38973587725480e76a8914463c674ca95ddfe32e180e4695b8f9150c34981       
          "/bin/bash"         2 hours ago         Up 2 hours          60000/tcp           myjm_master.1.bz2r7rrdrzomqwv56dpxi0m08
```

Use the same command to verify on the slave nodes.
 
## Pushing the JMX file into the container</b>

```
$docker exec -i <container-running-on-master-node> sh -c 'cat > /jmeter/apache-jmeter-2.13/bin/jmeter-docker.jmx' < jmeter-docker.jmx
```

## Starting the Load testing

```
$docker exec -it <container-on-master-node> bash
      root@4954e3ef40f6:/#cd /jmeter/apache-jmeter-2.13/bin
      $./jmeter -n -t jmeter-docker.jmx -R<list of containers running on slave nodes seperated by commas)
```       

# Handful Commands 

<b> Listing the Slave IPs </b>

```
$ docker inspect --format '{{ .Name }} => {{ .NetworkSettings.IPAddress }}' $(sudo docker ps -a -q)
```

<b> Stopping all the containers in a single shot </b>

```
$docker stop $(docker ps -a -q)
```

# Contributor

[Ajeet S Raina](https://github.com/ajeetraina)









