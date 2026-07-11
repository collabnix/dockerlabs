
# Docker Machine 

In this section we'll introduce `docker-machine`.

## Install Docker Toolbox

Download and install [Docker Toolbox](https://www.docker.com/docker-toolbox).

The toolbox installs a handful of tools on your local Windows or Mac OS X computer. In this exercise, you use two of those tools:

* Docker Machine: To deploy virtual machines that run Docker Engine
* VirtualBox: To host the virtual machines deployed from Docker Machine


## Create a VM running Docker

Open a terminal on your computer. 

Create and run a VM named `default` using the following command:

```
docker-machine create -d virtualbox default
```

You can list the existing docker-machines:

```
docker-machine ls
```

In case you already had the machine created, you can simply start the VM:

```
docker-machine start default
```

## Run a docker container in a docker-machine
Now, let's use the docker-machine we've just created. We want to run the `hello-world`.

If you use Mac, you need to run:
```
eval $(docker-machine env default)
```

This command set the `DOCKER_HOST` variable to the IP of your `default` `docker-machine`.

Then we can run the `hello-world` container:
```
docker run hello-world
```

## Clean up

After we tested our `default` `docker-machine` we want to remove it from our computer.

Stop the VM named `default`:

```
docker-machine stop default
```

You can destroy the VM named `default`:

```
docker-machine rm default
```

## Create two machines

To create two machines do:

```
docker-machine create -d virtualbox client1
docker-machine create -d virtualbox client2
```

Now you can see the machines with:


```
docker-machine ls
```

## Run Nginx on client1

```
eval $(docker-machine env client1)
docker run -d -p 80:80 nginx:1.8-alpine
docker-machine ip client1
open "http://$(docker-machine ip client1)"
```

## Run Nginx on client2

```
eval $(docker-machine env client2)
docker run -d -p 80:80 nginx:1.8-alpine
docker-machine ip client2
open "http://$(docker-machine ip client2)"
```

## SSH to machine

To SSH inside a machine:

```
docker-machine ssh client1
```

## Environment variables

Docker client is configured by environment variables to connect with remote daemons. The following command outputs the variables for connecting to previously created `default` VM.

```
docker-machine env default
```

## Active Machine

To get the active machine's name do:

```
docker-machine active
```

## Cleanup


```
docker-machine stop client1 client2
docker-machine rm client1 client2
```
