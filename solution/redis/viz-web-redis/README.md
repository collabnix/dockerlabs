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

![My Image](https://github.com/collabnix/dockerlabs/blob/master/solution/redis/viz-web-redis/redis1.png)

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

# Checking the redis logs 

```
$ docker service logs -f myredis_redis
myredis_redis.1.p9kmflmsd999@manager3    |                 _._                                                  
myredis_redis.1.p9kmflmsd999@manager3    |            _.-``__ ''-._                                             
myredis_redis.1.p9kmflmsd999@manager3    |       _.-``    `.  `_.  ''-._           Redis 3.0.6 (00000000/0) 64 bit
myredis_redis.1.p9kmflmsd999@manager3    |   .-`` .-```.  ```\/    _.,_ ''-._                                   
myredis_redis.1.p9kmflmsd999@manager3    |  (    '      ,       .-`  | `,    )     Running in standalone mode
myredis_redis.1.p9kmflmsd999@manager3    |  |`-._`-...-` __...-.``-._|'` _.-'|     Port: 6379
myredis_redis.1.p9kmflmsd999@manager3    |  |    `-._   `._    /     _.-'    |     PID: 1
myredis_redis.1.p9kmflmsd999@manager3    |   `-._    `-._  `-./  _.-'    _.-'                                   
myredis_redis.1.p9kmflmsd999@manager3    |  |`-._`-._    `-.__.-'    _.-'_.-'|                                  
myredis_redis.1.p9kmflmsd999@manager3    |  |    `-._`-._        _.-'_.-'    |           http://redis.io        
myredis_redis.1.p9kmflmsd999@manager3    |   `-._    `-._`-.__.-'_.-'    _.-'                                   
myredis_redis.1.p9kmflmsd999@manager3    |  |`-._`-._    `-.__.-'    _.-'_.-'|                                  
myredis_redis.1.p9kmflmsd999@manager3    |  |    `-._`-._        _.-'_.-'    |                                  
myredis_redis.1.p9kmflmsd999@manager3    |   `-._    `-._`-.__.-'_.-'    _.-'                                   
myredis_redis.1.p9kmflmsd999@manager3    |       `-._    `-.__.-'    _.-'                                       
myredis_redis.1.p9kmflmsd999@manager3    |           `-._        _.-'                                           
myredis_redis.1.p9kmflmsd999@manager3    |               `-.__.-'                                               
myredis_redis.1.p9kmflmsd999@manager3    | 
myredis_redis.1.p9kmflmsd999@manager3    | 1:M 29 Dec 02:18:02.749 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
myredis_redis.1.p9kmflmsd999@manager3    | 1:M 29 Dec 02:18:02.749 # Server started, Redis version 3.0.6
myredis_redis.1.p9kmflmsd999@manager3    | 1:M 29 Dec 02:18:02.749 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
myredis_redis.1.p9kmflmsd999@manager3    | 1:M 29 Dec 02:18:02.749 * The server is now ready to accept connections on port 6379
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


