# Visualizer + Redis + Docker Swarm

# Pre-requisite:

- Browse through https://play-with-docker.com
- Set up 5 Node Docker Swarm Cluster

## Clone the Repository

```
git clone https://github.com/collabnix/dockerlabs
cd dockerlabs/solution/redis/viz-web-redis
```

```
docker stack deploy -c docker-compose.yml myredis
```

## Verifying the Services

```
$ docker service ls
ID                  NAME                 MODE                REPLICAS            IMAGE                             PORTS
kbs2qhmqq81b        myredis_redis        replicated          1/1                 redis:3.0.6                       *:6379->6379/tcp
om5yzf5jxkka        myredis_visualizer   replicated          1/1                 dockersamples/visualizer:stable   *:8080->8080/tcp
ih89yqze2bnx        myredis_web          replicated          5/5                 ajeetraina/hellowhale:latest      *:80->80/tcp
[manager1] (local) root@192.168.0.45 ~/dockerlabs/solution/redis/viz-web-redis
```

# Verifying if redis is running successfully

```
$ docker service ps myredis_redis
ID                  NAME                IMAGE               NODE                DESIRED STATE       CURRENT STATE           ERROR               PORTS
p9kmflmsd999        myredis_redis.1     redis:3.0.6         manager3            Running             Running 4 minutes ago                       
[manager1] (local) root@192.168.0.45 ~/dockerlabs/solution/redis/viz-web-redis
$ 

```


## Verifying the Redis Volume



```
$ docker volume inspect myredis_data
[
    {
        "CreatedAt": "2019-12-29T02:18:00Z",
        "Driver": "local",
        "Labels": {
            "com.docker.stack.namespace": "myredis"
        },
        "Mountpoint": "/var/lib/docker/volumes/myredis_data/_data",
        "Name": "myredis_data",
        "Options": null,
        "Scope": "local"
    }
]
```


# [Optional] Running Redis Service under Docker Swarm Mode

Method: 2

```
$ docker service create --name myredis --publish 6379:6379 --replicas 5 --mount type=volume,source=data,destination=/home/docker/data redis:3.0.6
dkbe281eyx1ixadec1q6iexq7
overall progress: 5 out of 5 tasks 
1/5: running   
2/5: running   
3/5: running   
4/5: running   
5/5: running   
verify: Service converged
```


