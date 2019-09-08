# Lab 17: USER Instruction under Dockerfile


The `USER` directive is similar to `WORKDIR`, which changes the state of the environment and affects future layers. `WORKDIR` is to change the working directory, and `USER` is the identity of the commands such as `RUN`, `CMD` and `ENTRYPOINT`.


Of course, like `WORKDIR`, `USER` just helps you switch to the specified user. This user must be pre-established, otherwise it cannot be switched.

Example:

```Dockerfile
RUN groupadd -r redis && useradd -r -g redis redis
USER redis
RUN [ "redis-server" ]
```

If the script executed with `root` wants to change the identity during execution, such as wanting to run a service process with an already established user, don't use `su` or `sudo`, which requires a more cumbersome configuration. And often in the absence of TTY environment. It is recommended to use [`gosu`] (https://github.com/tianon/gosu).

```Dockerfile
# Create a redis user and use gosu to change another user to execute the command
RUN groupadd -r redis && useradd -r -g redis redis
# download gosu
RUN wget -O /usr/local/bin/gosu "https://github.com/tianon/gosu/releases/download/1.7/gosu-amd64" \
    && chmod +x /usr/local/bin/gosu \
    && gosu nobody true
# Set CMD and execute it as another user
CMD [ "exec", "gosu", "redis", "redis-server" ]
```

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


## Contributor - [Sangam Biradar](https://www.linkedin.com/in/sangambiradar14/)

Next >>[Writing Dockerfile with Hello Python Script Added](https://dockerlabs.collabnix.com/beginners/dockerfile/lab_dockerfile_python.html)


