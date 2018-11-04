# How is ENTRYPOINT instruction under Dockerfile different from RUN instruction?

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


ENTRYPOINT is meant to provide the executable while CMD is to pass the default arguments to the executable.
To understand it clearly, let us consider the below Dockerfile:

![My Image](https://github.com/collabnix/dockerlabs/blob/master/beginners/dockerfile/dockerfile-1.png)

If you try building this Docker image using `docker build command` -

![My Image](https://github.com/collabnix/dockerlabs/blob/master/beginners/dockerfile/dockerfile-2.png)

 Let us run this image without any argument.

![My Image](https://github.com/collabnix/dockerlabs/blob/master/beginners/dockerfile/dockerfile-3.png)

Let's run it passing a command line argument

![My Image](https://github.com/collabnix/dockerlabs/blob/master/beginners/dockerfile/dockerfile-4.png)

This clearly state that ENTRYPOINT is meant to provide the executable while CMD is to pass the default arguments to the executable.

## Contributor

- [Ajeet Singh Raina](ajeetraina@gmail.com)
