# Lab #14: Create a Docker Image with HEALTHCHECK instruction

The HEALTHCHECK directive tells Docker how to determine if the state of the container is normal. This was a new directive introduced during Docker 1.12. Before the HEALTHCHECK directive, the Docker engine can only determine if the container is in a state of abnormality by whether the main process in the container exits. In many cases, this is fine, but if the program enters a deadlock state, or an infinite loop state, the application process does not exit, but the container is no longer able to provide services. Prior to 1.12, Docker did not detect this state of the container and would not reschedule it, causing some containers to be unable to serve, but still accepting user requests.

The syntax look like:


`HEALTHCHECK [options] CMD <command>`: 

The above syntax set the command to check the health of the container

## How does it work?

When a HEALTHCHECK instruction is specified in an image, the container is started with it, the initial state will be starting, and will become healthy after the HEALTHCHECK instruction is checked successfully. If it fails for a certain number of times, it will become unhealthy.

## What options does  HEALTHCHECK support?

`--interval=<interval>`: interval between two health checks, the default is 30 seconds;
`--timeout=<time length>`: The health check command runs the timeout period. If this time is exceeded, the health check is regarded as a failure. The default is 30 seconds.
`--retries=<number>`: When the specified number of consecutive failures, the container status is treated as unhealthy, the default is 3 times.
Like CMD, ENTRYPOINT, HEALTHCHECK can only appear once. If more than one is written, only the last one will take effect.


## Pre-requisite:

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


## Assignment:

- Writing a Dockerfile with HEALTHCHECK instruction
- Build a Docker Image
- Check that the nginx config file exists
- Check if nginx is healthy
- Make Docker container Unhealthy and check
- Create the nginx.conf file and Making the container go healthy



## Writing a Dockerfile with HEALTHCHECK instruction

Suppose we have a simple Web service. We want to add a health check to determine if its Web service is working. We can use curl to help determine the HEALTHCHECK of its Dockerfile:

```
FROM nginx:1.13
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost/ || exit 1
EXPOSE 80
```

Here we set a check every 3 seconds (here the interval is very short for the test, it should be relatively long), if the health check command does not respond for more than 3 seconds, it is considered a failure, and use curl -fs http://localhost/ || exit 1 As a health check command.

## Building Docker Image

```
docker image build -t nginx:1.13 .
```

## Check that the nginx config file exists

```
docker run --name=nginx-proxy -d \
        --health-cmd='stat /etc/nginx/nginx.conf || exit 1' \
        nginx:1.13
```

## Check if nginx is healthy

```
docker inspect --format='{{.State.Health.Status}}' nginx-proxy
```

## Make Docker container Unhealthy and check

```
docker exec nginx-proxy rm /etc/nginx/nginx.conf
```

## Check if nginx is healthy

```
sleep 5; docker inspect --format='{{.State.Health.Status}}' nginx-proxy
```

## Creating the nginx.conf file and Making the container go healthy

```
docker exec nginx-proxy touch /etc/nginx/nginx.conf
```

```
sleep 5; docker inspect --format='{{.State.Health.Status}}' nginx-proxy
healthy
```

## Contributors

[Sangam Biradar](https://www.linkedin.com/in/sangambiradar14/)<br>
[Balasundaram](mailto:balasundarammaster@gmail.com)<br>

Next >> [Lab #15: SHELL instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/Lab-14-Create-an-image-with-SHELL-instruction.html)
