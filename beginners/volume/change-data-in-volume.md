## Creating Volume and modify data


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
- Click on "Add New Node"

# Getting Started


- Create a Docker volume with name nginx <br>
- Pull down nginx docker image <br>
- Mount the volume, start and stop the nginx container <br>
- Modify the data in the volume<br>
- Verify the updated content in the volume<br>

## Create a Docker volume and pull nginx alpine image

Create a Docker volume to which you will add persistent data.
```
docker volume create nginx_vol
```

Create a Docker container, attach the data volume, and add persistent data. Pull a lightweight nginx alpine distribution image.
```
nginx:stable-alpine
```

Create a container from nginx and mount the volume nginx_vol to /usr/share/nginx/html

```
docker run -n nginx -v nginx:/usr/share/nginx/html:ro -p 80:80 nginx:stable-alpine
```
Verify the html content by lauching the http://localhost:80

Stop the container
```
docker kill nginx
docker rm nginx
```

Verify that the volume still exists.

```
docker volume ls
```

Change the data in the volume by knowing the mount point of the local volume using docker volume inspect
```
docker volume inspect nginx_vol
```

Go into the mount directory such as '/var/lib/docker/volumes/nginx_vol/_data'
Change the data in index.html. Update it as below

```
<html>
<body>

<h1>Welcome to Docker Community</h1>
<p>This is an example for understanding concept of volumes</p>

</body>
</html>
```

Re-create the nginx container with the same data volume

```
docker run -n nginx -v nginx:/usr/share/nginx/html:ro -p 80:80 nginx:stable-alpine
```

Verify the html content by lauching the browser and entering http://localhost:80

Keep doing changes in your local volume and verify it by refreshing the browser

## Clean up artifacts. 

```
docker rm -f $(docker ps -aq) .
docker rmi $(docker images -q)
docker volume rm $(docker volume ls -q)
```
 


