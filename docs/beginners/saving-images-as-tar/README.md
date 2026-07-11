# Saving Images and Containers as Tar Files for Sharing

Imagine a scenario where you have built Docker images and containers that you would be interested to keep and share it with your other collaborators or colleagues. The below methods shall help you achieve it.

Four basic Docker CLI comes into action:

- The `docker export` - Export a container’s filesystem as a tar archive
- The `docker import` - Import the contents from a tarball to create a filesystem image
- The `docker save` - Save one or more images to a tar archive (streamed to STDOUT by default)
- The `docker load` - Load an image from a tar archive or STDIN


## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Docker</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side


## Create Nginx Container

```
$ docker run -d -p 80:80 nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
a5a6f2f73cd8: Pull complete
1ba02017c4b2: Pull complete
33b176c904de: Pull complete
Digest: sha256:5d32f60db294b5deb55d078cd4feb410ad88e6fe77500c87d3970eca97f54dba
Status: Downloaded newer image for nginx:latest
df2caf9283e84a15bb2321a17aabe84e3e0762ec82fc180e2a4c15fcf0f96588
[node1] (local) root@192.168.0.33 ~
```

## Displaying Running Container
```
$ docker ps -a
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                NAMES
df2caf9283e8        nginx               "nginx -g 'daemon of…"   35 seconds ago      Up 34 seconds       0.0.0.0:80->80/tcp   vigorous_jang
```


```
$ docker export df2 > nginx.tar
```

You could commit this container as a new image  locally, but you could also use the Docker import command:

```
$ docker import - mynginx < nginx.tar
sha256:aaaed50d250a671042e8dc383c6e05012e245f5eaf555d10c40be63f6028ee7b
```

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
mynginx             latest              aaaed50d250a        25 seconds ago      107MB
nginx               latest              568c4670fa80        2 weeks ago         109MB
```


If you wanted to share this image with one of your collaborators, you could upload the tar file on a web server and let your collaborator download it and use the import command on his Docker host.

If you would rather deal with images that you have already committed, you can use the load and save commands:

```
$ docker save -o mynginx1.tar nginx
```

```
$ ls -l
total 218756
-rw-------    1 root     root     112844800 Dec 18 02:53 mynginx1.tar
-rw-r--r--    1 root     root     111158784 Dec 18 02:50 nginx.tar
```

```
$ docker rmi mynginx
Untagged: mynginx:latest
Deleted: sha256:aaaed50d250a671042e8dc383c6e05012e245f5eaf555d10c40be63f6028ee7b
Deleted: sha256:41135ad184eaac0f5c4f46e4768555738303d30ab161a7431d28a5ccf1778a0f
```

Now delete all images and containers running and try to run the below command to load Docker image into your system:

```
$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
```

```
$ docker load < mynginx1.tar
Loaded image: nginx:latest
```

```
[node1] (local) root@192.168.0.33 ~$ docker images
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
nginx               latest              568c4670fa80        2 weeks ago         109MB
[node1] (local) root@192.168.0.33 ~
$
```

## Contributor

[Ajeet Singh Raina](mailto:ajeetraina@gmail.com)


[Building Your First Alpine Image and Pushing it to DockerHub](http://dockerlabs.collabnix.com/beginners/building-your-first-alpine-container.html)
