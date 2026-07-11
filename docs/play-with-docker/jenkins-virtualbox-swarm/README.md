# Demonstrating CI-CD Pipeline using Jenkins, Docker Swarm Mode and Virtualbox running on Docker for Mac

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

## Installing Jenkins on the Manager node

```
docker service create --mode=global --name jenkins-swarm-agent -e LABELS=docker-test --mount "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock" --mount "type=bind,source=/tmp/,target=/tmp/" --secret source=jenkins-v1,target=jenkins vipconsult/jenkins-swarm-agent
```

Login to one of instance running the above service and get the password using the below command:

```
cat /var/jenkins_home/secrets/initialAdminPassword
```

## 
