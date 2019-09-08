# Building Docker Image from Scratch


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

You can use Docker’s reserved, minimal image, scratch, as a starting point for building containers. Using the scratch “image” signals to the build process that you want the next command in the Dockerfile to be the first filesystem layer in your image.

While scratch appears in Docker’s repository on the hub, you can’t pull it, run it, or tag any image with the name scratch. 
Instead, you can refer to it in your Dockerfile. For example, to create a minimal container using scratch:

```
FROM scratch
ADD hello /
CMD ["/hello"]
```

Assuming you built the “hello” executable example by following the instructions at https://github.com/docker-library/hello-world/, and you compiled it with the -static flag, you can build this Docker image using this docker build command:

```
docker build --tag hello .
```

Don’t forget the . character at the end, which sets the build context to the current directory.

```
$ docker run --rm -it -v $PWD:/build ubuntu:16.04

container# apt-get update && apt-get install build-essential
container# cd /build
container# gcc -o hello -static -nostartfiles hello.c
```

To run your new image, use the docker run command:

```
docker run --rm hello
```

This example creates the hello-world image used in the tutorials. If you want to test it out, you can clone the image repo.

Next » [Accessing the Container Shell](http://dockerlabs.collabnix.com/beginners/accessing-the-container.html)
