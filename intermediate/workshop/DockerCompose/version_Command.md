# Lab #1: version Command

The `docker-compose version` command shows the Docker-Compose version information.


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

### Checking docker-compose version 
```
$ docker-compose version
docker-compose version 1.23.2, build 1110ad0
docker-py version: 3.7.3
CPython version: 2.7.16
OpenSSL version: OpenSSL 1.1.1c  28 May 2019
```
`docker-py` is the Docker Remote API, it does everything the docker command does, but from within Python – run containers, manage them, pull/push images, etc.<br>


## Contributor
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

Next » [help Command](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/help_command.html)
