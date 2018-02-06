# Running WordPress Application Stack under Docker Swarm Mode

## Setting up Multi-Node Cluster Node on Play with Docker Platform

Go to http://www.play-with-docker.com and then click on icon next to "Create New Instance" section. Select 3 Managers and 2 Worker node configuration and this is how the screen look like:


![alt text](https://github.com/ajeetraina/docker101/blob/master/images/pwd-multinode.png)



```

[manager1] (local) root@192.168.0.149 ~
$ git clone https://github.com/ajeetraina/docker101
Cloning into 'docker101'...
remote: Counting objects: 1881, done.
remote: Compressing objects: 100% (84/84), done.
remote: Total 1881 (delta 49), reused 0 (delta 0), pack-reused 1796
Receiving objects: 100% (1881/1881), 2.81 MiB | 16.53 MiB/s, done.
Resolving deltas: 100% (562/562), done.
[manager1] (local) root@192.168.0.149 ~
$ cd docker101/pl
play-with-docker/     play-with-kubernetes/
[manager1] (local) root@192.168.0.149 ~
$ cd docker101/play-with-docker/wordpress/example1/
[manager1] (local) root@192.168.0.149 ~/docker101/play-with-docker/wordpress/example1
$ ls
README.md         docker-stack.yml
[manager1] (local) root@192.168.0.149 ~/docker101/play-with-docker/wordpress/example1

```
# Setting up WordPress Application Cluster

```
$ docker stack deploy -c docker-stack.yml myapp4
Ignoring unsupported options: restart

Creating network myapp4_default
Creating service myapp4_db
Creating service myapp4_wordpress

```

```
 docker stack ls
NAME                SERVICES
myapp4              2
[manager1] (local) root@192.168.0.149 ~/docker101/play-with-docker/wordpress/example1
$ docker stack services myapp4
ID                  NAME                MODE                REPLICAS            IMAGE               PORTS
eu354pdpy4bp        myapp4_db           replicated          1/1                 mysql:5.7
k2t4wuhswpd3        myapp4_wordpress    replicated          1/1                 wordpress:latest    *:8000->80/tcp
```
