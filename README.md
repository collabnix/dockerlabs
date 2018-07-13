# Docker for Everyone

[Docker for Beginners](https://github.com/ajeetraina/docker101/tree/master/beginners)<br>


[Docker for Intermediate](https://github.com/ajeetraina/docker101/tree/master/intermediate)<br>

[Docker for Advanced Users](https://github.com/ajeetraina/docker101/tree/master/advanced)<br>

## Getting Started with Docker Swarm

To get started with Docker Swarm, you can use "Play with Docker", shortly called PWD. It's free of cost and open for all.
You get maximum of 5 instances of Linux system to play around with Docker.

- Open https://labs.play-with-docker.com on your browser
- Click on Icon near to Instance to choose 3 Managers & 2 Worker Nodes


![My image](https://github.com/ajeetraina/docker101/blob/master/images/pwd_1.png)


- Wait for few seconds to bring up 5-Node Swarm Cluster



## A Bonus... Docker Swarm Visualizer 

Swarm Visualizer is a fancy tool which visualized the Swarm Cluster setup. It displays containers running on each node in the form of visuals. If you are conducting Docker workshop, it's a perfect way to show your audience how the containers are placed under each node. Go..try it out..

## Clone the Repository

```
git clone https://github.com/dockersamples/docker-swarm-visualizer
```



```
cd docker-swarm-visualizer
docker-compose up -d
```

![My image](https://github.com/ajeetraina/docker101/blob/master/images/visualizer.png)

To run in a docker swarm:

```
$ docker service create \
  --name=viz \
  --publish=8080:8080/tcp \
  --constraint=node.role==manager \
  --mount=type=bind,src=/var/run/docker.sock,dst=/var/run/docker.sock \
  dockersamples/visualizer
```

# Quick List of Dockerized Applications for your Demo

[WordPress under Docker Swarm](https://github.com/ajeetraina/docker101/tree/master/play-with-docker/wordpress/example1/README.md)<br>
[ELK under Docker Swarm](https://github.com/ajeetraina/docker101/tree/master/play-with-docker/ELK/README.md)<br>
[Prometheus Stack under Docker Swarm](https://github.com/ajeetraina/docker101/tree/master/play-with-docker/docker-prometheus-swarm/README.md)<br>
[Apache Jmeter under Docker Swarm Mode](https://github.com/ajeetraina/docker101/tree/master/play-with-docker/jmeter-docker/README.md)<br>
[Voting App Example](https://github.com/ajeetraina/docker101/tree/master/play-with-docker/example-voting-app/README.md)<br>
[Playing around with Photon OS](https://github.com/ajeetraina/docker101/tree/master/play-with-docker/vmware/powercli/README.md)<br>
[Playing around with MacVLAN](https://github.com/ajeetraina/docker101/tree/master/play-with-docker/macvlan/README.md)<br>
[IPv6 & Docker Compose](https://github.com/ajeetraina/docker101/tree/master/play-with-docker/ipv6/README.md)<br>
[Trying out Gitlab](https://github.com/ajeetraina/docker101/tree/master/play-with-docker/gitlab/README.md)<br>
[Getting Started with Nginx](https://github.com/ajeetraina/docker101/tree/master/play-with-docker/nginx/README.md)<br>

