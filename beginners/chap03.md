# What is Dockerfile?

The humble but powerful Dockerfile is the building block of Docker images and containers. In essence, it's a list of commands the Docker engine runs to assemble the
image, and thus instances of images as containers.

## Building Nginx Docker Image using Dockerfile

```
git clone https://github.com/ajeetraina/docker101
cd docker101/beginners/nginx
```

```
docker build -t ajeetraina/mynginx .
```


