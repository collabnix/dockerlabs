# Demonstrating Nginx running inside Docker Container using Volume mount option


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


# Modifying default NGINX page using volume mount

```
$ docker run -d -p 80:80 -v /test/nginx.conf:/usr/share/nginx/html:ro  nginx
```

You will see that the default NGINX page gets modified.
