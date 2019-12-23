# How to run Redis Open Source on Jetson Nano

Please note that Jetson Nano is ARMv8 (64bit) and hence we need to verify if ARM64v8 Redis image is available or not.


## Create a network

```
jetson@master1:~$ docker network create jetnet
3ec1dd0052978e999ccd27dab8b581644e7113b956a2b9c14fef03128731d3ae
```

## Run Redis Server


jetson@master1:~$ docker run --name myredis -d arm64v8/redis redis-server --appendonly yes
Unable to find image 'arm64v8/redis:latest' locally
latest: Pulling from arm64v8/redis
a4f3dd4087f9: Pull complete
b4732d44fe3a: Pull complete
31356b9173df: Pull complete
8d7b209a7506: Pull complete
9e4b3a6b2cf6: Waiting
cce4db8cec51: Download complete

```

## Connect Redis Client running inside Docker container to Redis Server using rediscli

```
docker run -it --network jetnet --rm arm64v8/redis redis-cli -h myredis
```
