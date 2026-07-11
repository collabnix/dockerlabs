# Quick 10 Examples with Nginx

Pre-requisite:

- Bring up Visualizer tool

## #1: Bringing up a simple Nginx Page

```
docker service create --name nginx1 --publish 82:80 nginx
```

## #2: Bringing up another Nginx Instance

```
docker service create --name nginx2 --publish 83:80 nginx
```

## #3: Bringing up Hello Whale Page

```
docker service create --name hellowhale --publish 84:80 ajeetraina/hellowhale
```

## #4: How to customize your Webpage using Nginx container

- Create a directory called mysite1
- Under this direcotry, create a file called index.html

```
<html>
<body>
<h1> Hello World ! I am running inside Docker Container
</h1>
</body>
</html>
```

Now run the below command:

```
docker service create \
  --name my-service \
  --replicas 6 --publish 89:80  nginx:alpine
```



## #5: 
