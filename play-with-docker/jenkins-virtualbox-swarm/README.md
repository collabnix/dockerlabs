# Demonstratin CI-CD Pipeline using Jenkins, Docker Swarm Mode and Virtualbox running on Docker for Mac

## Pre-requisite:

- Ensure that Docker for Mac is installed
- Ensure that Virtualbox is installed
- Download https://gist.github.com/ajeetraina/11d38a790db147d6c2b519a460fe357d script and change the name it to swarm-script.sh

## Execute the script

```
$chmod +x swarm-script.sh
$./swarm-script.h
```

## Verify the Cluster

Do check if 3 node Swarm Mode cluster is up and running using the below command:



```
[Captains-Bay]🚩 >  sudo docker-machine ls
Password:
NAME     ACTIVE   DRIVER       STATE     URL                         SWARM   DOCKER        ERRORS
master   -        virtualbox   Running   tcp://192.168.99.103:2376           v18.02.0-ce
node01   -        virtualbox   Running   tcp://192.168.99.104:2376           v18.02.0-ce
node02   -        virtualbox   Running   tcp://192.168.99.102:2376           v18.02.0-ce
```

```
docker@master:~/jenkins-demo/cd/swarm$ sh init.sh
w8da93f54kt7oxfgqlb93bjeu
owzna0aaq7dadlvs603roakez
overall progress: 1 out of 1 tasks
1/1: running
verify: Service converged
b1r3m1t1tsetni9ltek721d9h
jhuqlikixksxm2dwbxy6dg8ru
zwvggk1j32h9vzqwdhrvfq5s7
docker@master:~/jenkins-demo/cd/swarm$ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
owzna0aaq7da        db                  replicated          1/1                 mysql:5.7.17
docker@master:~/jenkins-demo/cd/swarm$ docker service ps db
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE            ERROR               PORTS
bytzyuwd2mpt        db.1                mysql:5.7.17        master              Running             Running 22 seconds ago
docker@master:~/jenkins-demo/cd/swarm$
```
