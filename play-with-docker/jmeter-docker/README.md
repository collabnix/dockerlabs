# jmeter-docker
<h1>Setting up JMeter under Swarm Mode</h1>

<b>Pre-requisite:</b>

1. Installing Docker 17.03 on all the cluster of nodes
2. Setting up Swarm Mode Cluster( running atleast 1 master and n-number of Slave Nodes)
3. Installing Docker Compose on the master node

<b>1. Installing Docker 17.03 on all the cluster of nodes:</b>

                $curl -sSL https://get.docker.com/ | sh

<b>2. Setting up Swarm Mode Cluster:</b>

<b>On Master Node:</b>

              $docker swarm init --listen-addr <master-ip>:2377 --advertise-addr <master-ip>:2377

<b>On Slave Node:</b>

              $docker swarm join --token <TOKEN> master-ip  <-- Run this command on all the slave nodes

<b>3. Installing Docker Compose on the master node:</b>

            $curl -L https://github.com/docker/compose/releases/download/1.11.2/docker-compose-`uname -s`-`uname -m` > /usr/local 
              /bin/docker-compose
              $chmod +x /usr/local/bin/docker-compose

<b> Pulling the Repository </b>

Login to master node and pull the repository:

                $git clone https://github.com/ajeetraina/jmeter-docker
                $cd jmeter-docker

<b>Running Docker Compose</b>

                $docker-compose up -d

It will push jmeter-master to the master node and jmeter-server to the slave nodes and make it ready to start load using the external JMX file.

              @master:~$ docker service ls
              ID            NAME         MODE        REPLICAS  IMAGE
              mlffd5djek3t  myjm_slave   replicated  3/3       ajeetraina/jmeter-server:latest
              rv1r3cjvzkg3  myjm_master  replicated  1/1       ajeetraina/jmeter-master:latest

Let us verify these containers on both the nodes:

          @master:~$ docker ps
          CONTAINER ID        IMAGE                                                                                                     
          COMMAND             CREATED             STATUS              PORTS               NAMES
          4954e3ef40f6        ajeetraina/jmeter-master@sha256:1ad38973587725480e76a8914463c674ca95ddfe32e180e4695b8f9150c34981       
          "/bin/bash"         2 hours ago         Up 2 hours          60000/tcp           myjm_master.1.bz2r7rrdrzomqwv56dpxi0m08

Use the same command to verify on the slave nodes.
 

<b> Pushing the JMX file into the container</b>

       $docker exec -i <container-running-on-master-node> sh -c 'cat > /jmeter/apache-jmeter-2.13/bin/jmeter-docker.jmx' < jmeter-docker.jmx
       
<b> Starting the Load testing

      $docker exec -it <container-on-master-node> bash
      root@4954e3ef40f6:/#cd /jmeter/apache-jmeter-2.13/bin
      $./jmeter -n -t jmeter-docker.jmx -R<list of containers running on slave nodes seperated by commas)
       

# Handful Commands 

<b> Listing the Slave IPs </b>

       $ docker inspect --format '{{ .Name }} => {{ .NetworkSettings.IPAddress }}' $(sudo docker ps -a -q)


<b> Stopping all the containers in a single shot </b>

       $docker stop $(docker ps -a -q)









