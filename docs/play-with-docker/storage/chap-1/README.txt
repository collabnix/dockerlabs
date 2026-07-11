## Testing Persistent Data

## Running Redis Server

docker run -d -p 6379:6379 -v <data-dir>:/data --name redisredis

## Running Redis Server with Persistence

Remove the old container which might be running in the background

$ docker rm -f $(docker ps -a -q)
9073521d6a64b0eb09ad4609

[node1] (local) root@192.168.0.8 ~$ docker run -d -p 6379:6379 -v /opt:/data --name redis redis
986e083328e757de6ee66381051949c5db703e7906e0d40ef8af14d50854328c
[node1] (local) root@192.168.0.8 ~

$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS          PORTS                    NAMES
986e083328e7        redis               "docker-entrypoint..."   4 seconds ago       Up 4 seconds  

# Run Redis with persistent Storage and Password

docker run -d -p 6379:6379 -v <data-dir>:/data --name redis redis redis-server /etc/redis/redis.conf --requirepass <password>

#Run redis-cli

docker run -it --rm --link redis:redis dockerfile/redis bash -c 'redis-cli -h redis'
