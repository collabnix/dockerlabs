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


## CMD vs Entrypoint

In order to understand the dfference between CMD and ENTRYPOINT, let us first look at CMD.

When building a Dockerfile, the CMD instruction specifies the default program that will execute once the container runs.

Let's understand with the following Dockerfile:

```
FROM ubuntu:20.10
RUN    apt-get update
CMD ["echo", "Hello, Ubuntu"]
```

The CMD instruction in the file above echoes the message Hello, Ubuntu when the container is started without a CLI argument.
Let's build it:

```
docker build -t greeting .
```

The above command will build a Docker image by name "greeting". Let's run the Docker container:

```
docker run greeting hostname
```

As a CMD default command gets overridden, the above command will run the container and display the hostname, thereby ignoring the echo instruction in the Dockerfile with the following output:

```
 7145eerey430
```

Now let's replace CMD with Entrypoint and see the difference:

```
FROM ubuntu:20.10
RUN    apt-get update
ENTRYPOINT ["echo", "Hello, Ubuntu"]
```

The above Dockerfile uses an ENTRYPOINT instruction that echoes Hello, Ubuntu when the container is running.

Let's build it:

```
docker build -t greeting .
```


When building this image, the daemon looks for the ENTRYPOINT instruction and specifies it as a default program that will run with or without a command-line input.

When running a Docker container using the greeting Docker image without command line arguments, the default ENTRYPOINT instructions are executed, echoing Hello, Ubuntu.

In case additional command-line arguments are introduced through the CLI, the ENTRYPOINT is not ignored. Instead, the command line parameters are appended as arguments for the ENTRYPOINT command, i.e.:

```
docker run greeting hostname
```

will execute the ENTRYPOINT, echoing Hello, Ubuntu then displaying the hostname to return the following output:

```
Hello, Ubuntu  7145eerey430
````


Example #2

## What is ENTRYPOINT meant for?

ENTRYPOINT is meant to provide the executable while CMD is to pass the default arguments to the executable.
To understand it clearly, let us consider the below Dockerfile:

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/dockerfile/dockerfile-1.png)

If you try building this Docker image using `docker build command` -

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/dockerfile/dockerfile-2.png)

 Let us run this image without any argument.

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/dockerfile/dockerfile-3.png)

Let's run it passing a command line argument

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/dockerfile/dockerfile-4.png)

This clearly state that ENTRYPOINT is meant to provide the executable while CMD is to pass the default arguments to the executable.

## Contributor

- [Ajeet Singh Raina](mailto:ajeetraina@gmail.com)

Next >> [Lab #17: USER instruction](https://dockerlabs.collabnix.com/beginners/dockerfile/user.html)
