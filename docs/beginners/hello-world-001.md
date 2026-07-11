# Running Hello World Example

```docker
docker run hello-world
```

So what happened here?

We’ve called the docker run command, which is responsible for launching containers. The argument hello-world is the name of the image someone created on dockerhub for us.
It will first search for "hello-world" image locally and then search it in Dockerhub. Once the image has been downloaded, Docker turns the image into a running container and executes it.

The result of running this command is shown as shown below:

```docker
Hello from Docker!
This message shows that your installation appears to be working correctly.

To generate this message, Docker took the following steps:
 1. The Docker client contacted the Docker daemon.
 2. The Docker daemon pulled the "hello-world" image from the Docker Hub.
    (amd64)
 3. The Docker daemon created a new container from that image which runs the
    executable that produces the output you are currently reading.
 4. The Docker daemon streamed that output to the Docker client, which sent it
    to your terminal.

To try something more ambitious, you can run an Ubuntu container with:
 $ docker run -it ubuntu bash

Share images, automate workflows, and more with a free Docker ID:
 https://hub.docker.com/

For more examples and ideas, visit:
 https://docs.docker.com/engine/userguide/
```

## Check if container is still running or not

```docker
docker ps
```

Result: No Container running. It ran the container and exited quickly.

## How to check the last ran Container

```docker
$ docker ps -l
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS                     POR
TS               NAMES
c9f8264d041f        hello-world         "/hello"            7 seconds ago       Exited (0) 6 seconds ago
                 admiring_bhaskara
```
