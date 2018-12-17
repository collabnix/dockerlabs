## Getting Started with Docker Swarm

To get started with Docker Swarm, you can use "Play with Docker", aka PWD. 
It's free of cost and open for all.
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

[Proceed >> What is Docker Swarm](https://github.com/collabnix/dockerlabs/blob/master/intermediate/swarm/what-is-docker-swarm.md)
