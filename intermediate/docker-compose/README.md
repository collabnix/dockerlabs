# Docker compose


Docker compose is a tool built by Docker team to ease the task to creating and configuring multiple containers in a development environment counter-part of docker-compose 
for prodcution environment is `docker swarm`. Docker compose takes as input a `YAML` configuration file and creates the resources (*containers*, *networks*, *volumes* etc.) 
by communicating with the docker daemon through Docker API.


# Introduction to Compose

`Compose` project is the official open source project for Docker and is responsible for the rapid orchestration of Docker container clusters. Functionally, it is very similar to Heat OpenStack .

The code is currently open sourced at https://github.com/docker/compose .

`Compose` positioned as "Defining and running multi-container Docker applications", and its predecessor is the open source project Fig.

Through the introduction in the first part, we know that using a Dockerfile template file allows users to easily define a separate application container. However, in daily work, it is often the case that multiple containers need to cooperate to complete a certain task. For example, to implement a Web project, in addition to the Web service container itself, it is often necessary to add a back-end database service container, and even a load balancing container.

`Compose` just meets this need. It allows the user to define a set of associated application containers as a project through a separate docker-compose.yml template file (YAML format).

There are two important concepts in Compose :

`Service:` A container for an application that can actually include several container instances running the same image.

Project: A complete business unit consisting of a set of associated application containers, defined in the `docker-compose.yml `file.

`Compose` 's default management object is a project that provides convenient lifecycle management of a set of containers in a project through subcommands.

`Compose` project is written in Python, and the implementation calls the API provided by the Docker service to manage the container. Therefore, as long as the platform being operated supports the Docker API, you can use Compose to manage it.

## Compose file used in examples

```yaml
version: '3'

services:
    web:
        build: .
        image: web-client
        depends_on:
        - server
        ports:
        - "8080:8080"
    server:
        image: akshitgrover/helloworld
        volumes:
        - "/app" # Anonymous volume
        - "data:/data" # Named volume
        - "mydata:/data" # External volume

volumes:
    data:
    mydata:
        external: true
```

Refer [this](https://docs.docker.com/compose/compose-file/) for configuring your compose file.

## CLI Cheatsheet

- [Docker compose](#docker-compose)
  - [Compose file used in examples](#compose-file-used-in-examples)
  - [CLI Cheatsheet](#cli-cheatsheet)
    - [Build](#build)
    - [Bundle](#bundle)
    - [Config](#config)
    - [Up](#up)
    - [Down](#down)
    - [Scale](#scale)
    - [Start](#start)
    - [Stop](#stop)

### Build

Used to build services specified in docker-compose.yml file with `build` specification.

Refer [this](https://docs.docker.com/compose/compose-file/#build) for more details.

**Note:**
Images build will be tagged as {DIR}_{SERVICE} unless image name is specified in the service specification.

```
docker-compose build [OPTIONS] [SERVICE...]

OPTIONS:

--compress | Command line flag to compress the build context, Build context is nothing but a directory where docker-compose.yml file is located. As this directory can container a lot of files, sending build context to the container can take a lot of time thus compression is needed.

--force-rm | Remove any intermediate container while building.

--no-cache | Build images without using any cached layers from previoud builds.

--pull | Allways pull newer version of the base image.

-m, --memory | Set memory limit for the container used for building the image.

--parallel | Exploit go routines to parallely build images, As docker daemon is written in go.

--build-arg key=val | Pass any varaible to the dockerfile from the command line.


SERVICE:

If you want to build any particular services instead of every service specified in the compose file pass the name (same as in the compose file) as arguments to the command.

Example:

docker-compose build --compress     # Will compress the build context of service web.

```

### Bundle

Used to generate distributed application bundle (DAB) from the compose file.

Refer [this](https://docs.docker.com/compose/bundles/) for more details about DBA.

```
docker-compose bundle [OPTIONS]

OPTIONS:

--push-image | Push images to the register if any service has build specifcation.

-o, --output PATH | Output path for .dab file.
```

### Config

Used to validate the compose file

NOTE:
Run this command in directory where docker-compose.yml file is located.

```
docker-compose config
```

### Up

Creates and starts the resources as per the specification the docker-compose.yml file.

```
docker-compose up [OPTIONS] [SERVICE...]

OPTIONS:

-d, --detach | Run containers in background.

--build | Always build images even if it exists.

--no-deps | Avoid creating any linked services.

--force-recreate | Force recreating containers even if specification is not changed.

--no-recreate | Do not recreate containers.

--no-build | Do not build any image even if it is missing.

--no-start | Just create the containers without starting them.

--scale SERVICE=NUM | Create multiple containers for a service.

-V, --renew-anon-volumes | Recreate anonymous volumes instead of getting data from previous ones.

Example:

docker-compose up -d        # Will run service containers in background
docker-compose up web       # Will start service web and server because of 'depends_on' field
docker-compose up server    # will start server service only.
```

### Down

Stop and clear any resources created while lifting docker-compose.

By default only containers and networks defined in the compose file are removed.
Networks and Volumes with external = true and never removed.

```
docker-compose down [OPTIONS]

--rmi type | Remove images Type = all (Remove every image in the compose file), local (Remove images with no custom tag)

-v, --volumes | Remove named volumes except the external ones and also remove anonymous volumes

-t, --timeout TIMEOUT | Speficy shutdown time in seconds. (default = 10)

Example:

docker-compose down         # Will delete all containers of both web and server and no volume will be removed

docker-compose down -v      # Will also delete anonymous and data volumes.
```

### Scale

Scale particular services

```
docker-compose scale [SERVICE=NUM...]

Example:

docker-compose scale server=3 web=2
```

### Start

Start created containers.

```
docker-compose start [SERVICE...]

Example:

docker-compose start        # Start containers for every service.
docker-compose start web    # Start containers only for service web. 
```

### Stop

Stop running containers.

```
docker-compose stop [SERVICE...]

Example:

docker-compose stop         # Stop containers for every service.
docker-compose stop web     # Stop containers only for service web.
```

# Contributor

[Akshit Grover]() <br>
[Sangam Biradar]()

[Next >> Docker Compose Cheatsheet ](https://github.com/collabnix/dockerlabs/blob/master/intermediate/docker-compose/compose-cheatsheet.md)
