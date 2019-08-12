# Introduction to Docker Compose

This section will show how to use Docker Compose with some small exercises and with a simple Node/Redis app. Before starting, you'll need to have [Docker Compose installed](https://docs.docker.com/compose/install/).

# Docker-compose

Compose is a tool for defining and running multi-container Docker applications. With Compose, you use a Compose file to configure your application’s services. Then, using a single command, you create and start all the services from your configuration. To learn more about all the features of Compose see [the list of features](https://docs.docker.com/compose/overview/#features).

Using Compose is basically a three-step process:

1. Define your app’s environment with a `Dockerfile` so it can be reproduced anywhere.
1. Define the services that make up your app in `docker-compose.yml` so they can be run together in an isolated environment.
1. Lastly, run `docker-compose up` and Compose will start and run your entire app.


## Commands

Check the available commands of Docker Compose. Type in your terminal:

```
docker-compose
```

* Whenever you don't remember a command, just type docker-compose
* For more info, type `docker-compose help COMMAND` (e.g. `docker-compose help build`)

## docker-compose.yml

The `docker-compose.yml` file is a [YAML](http://yaml.org/) file defining [services](https://docs.docker.com/compose/compose-file/#service-configuration-reference), [networks](https://docs.docker.com/compose/compose-file/#network-configuration-reference) and [volumes](https://docs.docker.com/compose/compose-file/#volume-configuration-reference). The default path for a Compose file is `./docker-compose.yml`.

A service definition contains configuration which will be applied to each container started for that service, much like passing command-line parameters to `docker run`. Likewise, network and volume definitions are analogous to `docker network create` and `docker volume create`.

Options specified in the `Dockerfile` (e.g., `CMD`, `EXPOSE`, `VOLUME`, `ENV`) are respected by default - you don’t need to specify them again in `docker-compose.yml`.


## Project's components

We've already created a simple app in `git clone https://github.com/sangam14/docker-compose` that uses node.js with express and redis.

1. Go to `docker-compose` folder

2. Review `Dockerfile`:

```
FROM node:7.7.0-alpine
RUN mkdir /docker-compose
WORKDIR /code
ADD package.json /docker-compose/
RUN npm install
ADD . /docker-compose/
CMD ["node", "main.js"]
```

We use the base image of `node:7.7.0-alpine`. It is the official image in Alpine, a minimal OS.

The `Dockerfile` then creates the directory where our code will be stored, `/code`, and it copies the `package.json` so it can install the node dependencies.

Afterwards it copies all the code we have in the host machine and runs the command that will keep the container running.

3. Review `docker-compose.yml`:

```
version: '2'
services:
  redis:
    image: redis:alpine
  web:
    build: .
    ports:
      - "80:3000"
    depends_on:
      - redis
```

The `docker-compose.yml` file describes the services that make your app. In this example those services are a web server and database. The compose file also describes which Docker images these services use, how they link together, any volumes they might need mounted inside the containers. Finally, the `docker-compose.yml` file describes which ports these services expose. See the docker-compose.yml [reference](https://docs.docker.com/compose/compose-file/) for more information on how this file works.

In this case, we defined two services, `redis` that uses `redis:alpine` and `web`, our nodejs app. We linked the two of them, and `web` depends on `redis` as you can see in `depends_on`. Also, our nodejs app listens the port `3000` so we linked host's port 80 to the docker container 3000 port.


## Run the app

### Build the images

With docker-compose we can build all the images at once running:
```
docker-compose build
```

The `docker-compose build` reads `docker-compose.yml` and build all the services defined in there.

### Run a command against a service
We can run a one-time command against a service. For example, the following command starts the `web` service and runs `sh` as its command.
```
docker-compose run web sh
```

Commands you use with `run` start in new containers with the same configuration as defined by the service's configuration. This means the container has the same volumes, links, as defined in the configuration file. There two differences though.

First, the command passed by `run` overrides the command defined in the service configuration. For example, if the `web` service configuration is started with `node`, then `docker-compose run web sh` overrides it with `sh`.

The second difference is the `docker-compose run` command does not create any of the ports specified in the service configuration. This prevents the port collisions with already open ports.

### Start services

We can run `docker-compose up` that builds, (re)creates, starts, and attaches to containers for a service. Unless they are already running, this command also starts any linked services.

Type in your terminal: 

```
docker-compose up
```

This instructs Compose to run the services defined in the `docker-compose.yml` in containers, using the `redis` image and the `web` service's image and configuration. 

The docker-compose up command aggregates the output of each container. When the command exits, all containers are stopped.

If we want, we can run the containers in background with `-d` flag:
```
docker-compose up -d
```

At this point, your Node app should be running at port `8088` on your Docker host. If you are using a Docker Machine VM, you can use the `docker-machine ip MACHINE_NAME` to get the IP address.

### Logs

We can see the log output from services running:
```
docker-compose logs
```

If we want to review the logs of a specific service, e.g. `web`:
```
docker-compose logs web
```

### List containers

We can run `ps` like in `docker ps` to list containers and their status:
```
docker-compose ps
```

### Stop containers

```
docker-compose stop 
```

Stops running containers without removing them. They can be started again with `docker-compose start`.

If we want we can stop only one container:
```
docker-compose stop web
```

### Start container

Starts existing containers for a service, e.g. `web`:
```
docker-compose start web
```

### Remove containers
```
docker-compose rm
```

The previous command removes __stopped__ service containers. 

If we want to stop and remove them:

```
docker-compose down
```

## Exercise 1 (10 min)

Update the title of `guestbook` app adding your name.

The goal of this exercise is:
- Understand the development process
- Understand how to update the code and deploy it


## Exercise 2 (15 min)

Add a new service like `web` in the `docker-compose.yml` to have another application that connects to the existing `redis` and expose a different port.

The goal of this exercise is:

- Understand how `docker-compose.yml` works
- Understand how to add a new service
- Understand how to expose ports
- Be able to run at the same time the two `web` containers
