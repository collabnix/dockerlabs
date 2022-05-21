# How to run Dockerized Redis DB on  Jetson Nano

## Why Redis on IoT?

If things connected with network it doesn’t mean it’s “smart”.Truly smart devices provide valuable services, are trusted, and are easy to use. This Make your life easier by implementing your own IoT solution as smart way.

Redis is an open source in memory database,cache and message broker. Redis supports various types of data structures such as strings, hashes, lists, sets, sorted sets with range queries, bitmaps, hyperloglogs and geospatial indexes with radius queries.
Most Off other database require considerable amount of resources for handle millions of transactions.Also it may be difficult to handle real-time analytics.
Redis use minimum amount of resources and it has in built data structures, modules are advantage in delivering reliable IoT solutions.

Please note that Jetson Nano is ARMv8 (64bit) and hence we need to verify if ARM64v8 Redis image is available or not.


## Run Redis Server

```
jetson@master1:~$ docker run --name redis-server -d arm64v8/redis redis-server --appendonly yes
6b80312b1e05499d565c6962b03f852db7064d5be97acb11dae31791b55ef320
jetson@master1:~$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
6b80312b1e05        arm64v8/redis       "docker-entrypoint.s…"   6 seconds ago       Up 3 seconds        6379/tcp            redis-server
jetson@master1:~$

```

```
jetson@master1:~$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS               NAMES
340437cc7c7c        arm64v8/redis       "docker-entrypoint.s…"   35 seconds ago      Up 32 seconds       6379/tcp            myredis
```

```
jetson@master1:~$ docker logs -f 4e194
1:C 23 Dec 2019 15:49:21.819 # oO0OoO0OoO0Oo Redis is starting oO0OoO0OoO0Oo
1:C 23 Dec 2019 15:49:21.819 # Redis version=5.0.7, bits=64, commit=00000000, modified=0, pid=1, just started
1:C 23 Dec 2019 15:49:21.819 # Configuration loaded
1:M 23 Dec 2019 15:49:21.828 * Running mode=standalone, port=6379.
1:M 23 Dec 2019 15:49:21.828 # WARNING: The TCP backlog setting of 511 cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of 128.
1:M 23 Dec 2019 15:49:21.828 # Server initialized
1:M 23 Dec 2019 15:49:21.828 # WARNING you have Transparent Huge Pages (THP) support enabled in your kernel. This will create latency and memory usage issues with Redis. To fix this issue run the command 'echo never > /sys/kernel/mm/transparent_hugepage/enabled' as root, and add it to your /etc/rc.local in order to retain the setting after a reboot. Redis must be restarted after THP is disabled.
1:M 23 Dec 2019 15:49:21.829 * Ready to accept connections

```

## Run the Redis CLI in the container

```
jetson@master1:~$ docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                        NAMES
4e1941c5be9b        arm64v8/redis       "docker-entrypoint.s…"   5 minutes ago       Up 4 minutes        192.168.1.7:6379->6379/tcp   redis-server
jetson@master1:~$ docker exec -it 4e1941 sh
# redis-cli
127.0.0.1:6379>

```

```
# redis-cli
127.0.0.1:6379> ping
PONG
127.0.0.1:6379>
```
```
# redis-cli
127.0.0.1:6379> ping
PONG
127.0.0.1:6379> set name collabnix
OK
127.0.0.1:6379> get name
"collabnix"
```

```
127.0.0.1:6379> incr counter
(integer) 1
127.0.0.1:6379> incr counter
(integer) 2
127.0.0.1:6379>
```

## Connect from another linked container

```
jetson@master1:~$ docker run -it --rm --link redis-server:redis --name client1 arm64v8/redis sh
# redis-cli -h redis
redis:6379> get name
"collabnix"
redis:6379>
```

## Important Notes

Redis database is not an equivalent of database names in DBMS like mysql. It is a way to create isolation and namespacing for the keys, and only provides index based naming, not custom names like my_database.

By default, redis has 0-15 indexes for databases, you can change that number databases NUMBER in redis.conf.

And then you use SELECT command to select the database you want to work on.
