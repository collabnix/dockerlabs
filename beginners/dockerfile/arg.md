## ARG build parameters

Format: `ARG <parameter name>[=<default>]`

The build parameters have the same effect as `ENV`, which is to set the environment variables. The difference is that the environment variables of the build environment set by `ARG` will not exist in the future when the container is running. But don't use `ARG` to save passwords and the like, because `docker history` can still see all the values.

The `ARG` directive in `Dockerfile` defines the parameter name and defines its default value. This default value can be overridden by the `--build-arg <parameter name>=<value>` in the build command `docker build`.

In versions prior to 1.13, the parameter name in `--build-arg` must be defined in `Dockerfile` with `ARG`. In other words, the parameter specified by `--build-arg` must be Used in `Dockerfile`. If the corresponding parameter is not used, the error will exit the build. Starting from 1.13, this strict restriction is released, no longer exits with an error, but a warning message is displayed and construction continues. This is useful when using the CI system to build different `Dockerfile`s with the same build process. Avoiding build commands must be modified based on the contents of each Dockerfile.


# Lab #8: Create an image with ARG instruction

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

We are writing a Dockerfile which echo "Welcome $WELCOME_USER, to Docker World!" where default argument value for <b>WELCOME_USER</b> as <b>Collabnix</b>.
```
FROM alpine:3.9.3
LABEL maintainer="Collabnix"

#Setting a default value to Argument WELCOME_USER
ARG WELCOME_USER=Collabnix
RUN echo "Welcome $WELCOME_USER, to Docker World!" > message.txt
CMD cat message.txt
```
## Building Docker Image wit default argument
```
docker image build -t arg:v1 .
```
## Running container argv:v1
```
docker run arg:v1

Welcome Collabnix, to Docker World!
```

## Now lets supply the argument(WELCOME_USER) during image build time using <b>--build-arg</b> flag 
```
docker image build -t arg:v2 --build-arg WELCOME_USER=Savio .
```
## Running container argv:v2
```
docker run arg:v2

Welcome Savio, to Docker World!
```
<b>NOTE:</b> ARG is the only one instruction which can come before FROM instruction, but then arg value can be used only by FROM.

## Contributor -
[Sangam Biradar](https://www.linkedin.com/in/sangambiradar14/)<br>
[savio]()
