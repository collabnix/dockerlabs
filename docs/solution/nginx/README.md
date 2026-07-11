# Demonstrating Nginx Docker Container using Bind Mount

When you use a bind mount, a file or directory on the host machine is mounted into a container. The file or directory is referenced by its full or relative path on the host machine. By contrast, when you use a volume, a new directory is created within Docker’s storage directory on the host machine, and Docker manages that directory’s contents.

The file or directory does not need to exist on the Docker host already. It is created on demand if it does not yet exist. Bind mounts are very performant, but they rely on the host machine’s filesystem having a specific directory structure available.

Below tutorial showcases how Nginx default page can be changed using -v bind mount.


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


## Cloning the Repository



```
$ git clone https://github.com/collabnix/dockerlabs
$ cd dockerlabs
$ cd solution/nginx
```

## Running the Nginx Container 

```
$ docker run -d -p 80:80 nginx
```

You will see the default NGINX page gets displayed while you click on port 80 displayed on top of the PWD screen.


## Modifying default NGINX page using volume mount

```
$ docker run -d -p 81:80 -v /root/dockerlabs/solution/nginx/sample:/usr/share/nginx/html:ro  nginx
```

You will see that the default NGINX page gets modified and the new Dockerlabs page gets displayed under port 81.

# Building Nginx using Dockerfile

```
cd dockerfile
docker build -t ajeetraina/mynginx .
docker run -d -p 83:80 ajeetraina/mynginx
```


## Contributor

- [Ajeet Singh Raina](ajeetraina@gmail.com)
