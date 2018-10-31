# Welcome to DockerLabs

![My image](https://github.com/collabnix/dockerlabs/blob/master/images/dockerlabs.jpeg)

Are you new to Docker & Kubernetes? Want to build your career in Container Technology?

Then Welcome ! You are at the right place.

This repository brings you tutorials that help you get hands-on experience using Docker & Kubernetes. Here you will find a mix of labs and tutorials that will help you, no matter if you are a beginner, SysAdmin, IT Pro or Developer. Yes, you read it correct ! Its $0 learning platform. You don't need any infrastructure. Most of the tutorials runs on [Play with Docker Platform](http://play-with-docker.com). This is a free browser based learning platform for you. Docker tools like Docker Engine, Docker Compose & Docker Machine are already installed for you. All you need is to get started.

[![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/fold_left.svg?style=social&label=Follow%20%40collabnix)](https://twitter.com/collabnix)

# Categories

This repo contains Docker Labs and tutorials authored by members of the open community. Below are the list of categories -

## Docker

- [Docker for Beginners](https://github.com/collabnix/dockerlabs/tree/master/beginners/README.md)

- [Docker for Intermediate](https://github.com/collabnix/dockerlabs/tree/master/intermediate/README.md)

- [Docker for Advanced](https://github.com/collabnix/dockerlabs/tree/master/advanced/README.md)

- [Docker Cheatsheet](https://github.com/collabnix/dockerlabs/tree/master/docker/cheatsheet/README.md)


## Kubernetes

- [Kubernetes for Beginners](https://github.com/collabnix/dockerlabs/tree/master/kubernetes/README.md)

- [Kubernetes for Intermediate](https://github.com/collabnix/dockerlabs/tree/master/kubernetes/README.md)

- [Kubernetes for Advanced](https://github.com/collabnix/dockerlabs/tree/master/kubernetes/README.md)

- [Kubernetes Cheatsheet](https://github.com/collabnix/dockerlabs/tree/master/kubernetes/cheatsheet/README.md)

# A Quick Reference

## Getting Started with Docker

Interestingly, you don't need to do any investment. Throughout the tutorial, you will be using Play with Docker (PWD in short) Playground. Cool....Isn't it?

PWD is a Docker playground which allows users to run Docker commands in a matter of seconds. It gives the experience of having a free Alpine Linux Virtual Machine in browser, where you can build and run Docker containers and even create clusters in Docker Swarm Mode. Under the hood Docker-in-Docker (DinD) is used to give the effect of multiple VMs/PCs.

To get started with Docker, follow the below steps:

- Create Dockerhub Account

- Open [Play with Docker Platform](http://play-with-docker.com)

- Click on "Start"

- This will open up an easy to understand PWD(Play with Docker) tool which displays instances on the left hand side while terminal at the right hand side

- Click on "Create Instance" to create your first Linux instance

## Getting Started with Docker Swarm

To get started with Docker Swarm, you can use "Play with Docker", shortly called PWD. It's free of cost and open for all.
You get maximum of 5 instances of Linux system to play around with Docker.

- Open [Play with Docker labs](https://labs.play-with-docker.com) on your browser

- Click on Icon near to Instance to choose 3 Managers & 2 Worker Nodes

![My image](https://github.com/collabnix/dockerlabs/blob/master/images/pwd_1.png)

- Wait for few seconds to bring up 5-Node Swarm Cluster

We recommend you start with one of our Beginners Guides, and then move to intermediate and expert level tutorials that cover most of the features of Docker. For a comprehensive approach to understanding Docker, I have categorized it as shown below:

# A Bonus... Docker Swarm Visualizer

Swarm Visualizer is a fancy tool which visualized the Swarm Cluster setup. It displays containers running on each node in the form of visuals. If you are conducting Docker workshop, it's a perfect way to show your audience how the containers are placed under each node. Go..try it out..

## Clone the Repository

```docker
git clone https://github.com/dockersamples/docker-swarm-visualizer
```

```docker
cd docker-swarm-visualizer
docker-compose up -d
```

![My image](https://github.com/collabnix/dockerlabs/blob/master/images/visualizer.png)

To run in a docker swarm:

```docker
$ docker service create \
  --name=viz \
  --publish=8080:8080/tcp \
  --constraint=node.role==manager \
  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  dockersamples/visualizer
```

## How to Contribute

Thank you so much for your interest in contributing to [Dockerlabs](https://github.com/collabnix/dockerlabs) tutorials.

[Guide to submitting your own tutorial](https://github.com/collabnix/dockerlabs/tree/master/CONTRIBUTING.md)<br>
[Template for writing Tutorial Page](https://github.com/collabnix/dockerlabs/tree/master/template/EXAMPLE.md)

## Docker-Ready Solution for You

In case you're looking out to conduct workshop or demo, you can refer these below links to bring up Application Stack in no time.

- [WordPress under Docker Swarm](https://github.com/collabnix/dockerlabs/tree/master/play-with-docker/wordpress/example1/README.md)

- [ELK under Docker Swarm](https://github.com/collabnix/dockerlabs/tree/master/play-with-docker/ELK/README.md)

- [Prometheus Stack under Docker Swarm](https://github.com/collabnix/dockerlabs/tree/master/play-with-docker/docker-prometheus-swarm/README.md)

- [Apache Jmeter under Docker Swarm Mode](https://github.com/collabnix/dockerlabs/tree/master/play-with-docker/jmeter-docker/README.md)

- [Voting App Example](https://github.com/collabnix/dockerlabs/tree/master/play-with-docker/example-voting-app/README.md)

- [Playing around with Photon OS](https://github.com/collabnix/dockerlabs/tree/master/play-with-docker/vmware/powercli/README.md)

- [Playing around with MacVLAN](https://github.com/collabnix/dockerlabs/tree/master/play-with-docker/macvlan/README.md)

- [IPv6 & Docker Compose](https://github.com/collabnix/dockerlabs/tree/master/play-with-docker/ipv6/README.md)

- [Trying out Gitlab](https://github.com/collabnix/dockerlabs/tree/master/play-with-docker/gitlab/README.md)

- [Getting Started with Nginx](https://github.com/collabnix/dockerlabs/tree/master/play-with-docker/nginx/README.md)

## License

[MIT](https://github.com/collabnix/dockerlabs/blob/master/LICENSE.md)

   [Proceed to Beginners Track >>](https://github.com/collabnix/dockerlabs/blob/master/beginners/README.md)
