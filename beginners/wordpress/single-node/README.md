# Running Wordpress Blog using a Single Docker Container(Single Node Cluster)

```docker
$ docker build -t wordpress -f ./singlecontainer.Dockerfile .

$ docker run -d -p 80:80 wordpress
```
