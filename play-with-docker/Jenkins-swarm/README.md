# Continuous Integration and Deployment Made Easy using Jenkins under Docker Swarm Mode

## Pre-requisite:

- Login to http://play-with-docker.com

- Create 3 Manager and 2 worker nodes Instances by a single click

## On Manager Node:

## Create Jenkins-master service

```
docker service create --name jenkins-master -p 50000:50000 -p 80:8080 jenkins
```

## Creating Secrets

```
echo "-master http://192.168.0.119 -password admin -username admin"|docker secret create jenkins-v1 -
```

## Creating Jenkins-Swarm Agent Service for Test Environment

```
docker service create --mode=global --name jenkins-swarm-agent -e LABELS=docker-test --mount "type=bind,source=/var/run/docker.sock,target=/var/run/docker.sock" --mount "type=bind,source=/tmp/,target=/tmp/" --secret source=jenkins-v1,target=jenkins vipconsult/jenkins-swarm-agent
```
