# How to run Jenkins inside Docker

## Step-1: Building Docker Image

```
$docker build -t ajeetraina/jenkins .
```

## 

```
docker build -t ajeetraina/jenkins .
```

```
docker run --rm -p 8080:8080 -p 4040:4040 -v /var/run/docker.sock:/var/run/docker.sock ajeetraina/jenkins
```


