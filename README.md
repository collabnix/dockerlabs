# Getting Started

## Step-1:  Login to PWD Playground

- Open http://play-with-docker on your browser
- Click on Icon near to Instance to choose 3 Managers & 2 Worker Nodes


![My image](https://github.com/ajeetraina/docker101/blob/master/images/pwd_1.png)


- Wait for few seconds to bring up 5-Node Swarm Cluster



## Getting Swarm Visualizer Up and Running 

Swarm Visualizer is a fancy tool which visualized the Swarm Cluster setup. It displays containers running on each node.

Follow the steps below:

```
cd docker101/play-with-docker/visualizer/
docker-compose up -d
```
# List of Applications for the demonstration 

[WordPress under Docker Swarm](https://github.com/ajeetraina/docker101/tree/master/play-with-docker/wordpress/example1)
[ELK under Docker Swarm](https://github.com/ajeetraina/docker101/tree/master/play-with-docker/ELK)
