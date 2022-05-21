# Docker Images vs. Containers

In Dockerland, there are images and there are containers. The two are closely related, but distinct. 
For me, grasping this dichotomy has clarified Docker immensely.

## What's an Image?

An image is an inert, immutable, file that's essentially a snapshot of a container. 
Images are created with the build command, and they'll produce a container when started with run. 
Images are stored in a Docker registry such as registry.hub.docker.com. Because they can become quite large, 
images are designed to be composed of layers of other images, allowing a miminal amount of data to be sent 
when transferring images over the network.

Local images can be listed by running docker images:

```
REPOSITORY                TAG                 IMAGE ID            CREATED             VIRTUAL SIZE
ubuntu                    13.10               5e019ab7bf6d        2 months ago        180 MB
ubuntu                    14.04               99ec81b80c55        2 months ago        266 MB
ubuntu                    latest              99ec81b80c55        2 months ago        266 MB
ubuntu                    trusty              99ec81b80c55        2 months ago        266 MB
<none>                    <none>              4ab0d9120985        3 months ago        486.5 MB
```

## Important Points:

- IMAGE ID is the first 12 characters of the true identifier for an image. You can create many tags of a given image, but their IDs will all be the same (as above).
- VIRTUAL SIZE is virtual because it's adding up the sizes of all the distinct underlying layers. This means that the sum of all the values in that column is probably much larger than the disk space used by all of those images.
- The value in the REPOSITORY column comes from the -t flag of the docker build command, or from docker tag-ing an existing image. You're free to tag images using a nomenclature that makes sense to you, but know that docker will use the tag as the registry location in a docker push or docker pull.
- The full form of a tag is [REGISTRYHOST/][USERNAME/]NAME[:TAG]. For ubuntu above, REGISTRYHOST is inferred to be registry.hub.docker.com. So if you plan on storing your image called my-application in a registry at docker.example.com, you should tag that image docker.example.com/my-application.
- The TAG column is just the [:TAG] part of the full tag. This is unfortunate terminology.
- The latest tag is not magical, it's simply the default tag when you don't specify a tag.
- You can have untagged images only identifiable by their IMAGE IDs. These will get the <none> TAG and REPOSITORY. It's easy to forget about them.



## What's a container?

To use a programming metaphor, if an image is a class, then a container is an instance of a class—a runtime object. Containers are hopefully why you're using Docker; they're lightweight and portable encapsulations of an environment in which to run applications.

View local running containers with docker ps:

```
CONTAINER ID        IMAGE                               COMMAND                CREATED             STATUS              PORTS                    NAMES
f2ff1af05450        samalba/docker-registry:latest      /bin/sh -c 'exec doc   4 months ago        Up 12 weeks         0.0.0.0:5000->5000/tcp   docker-registry
```

Here I'm running a dockerized version of the docker registry, so that I have a private place to store my images. Again, some things to note:

- Like IMAGE ID, CONTAINER ID is the true identifier for the container. It has the same form, but it identifies a different kind of object.
- docker ps only outputs running containers. You can view all containers (running or stopped) with  docker ps -a.
- NAMES can be used to identify a started container via the --name flag.

## How to avoid image and container buildup?

One of my early frustrations with Docker was the seemingly constant buildup of untagged images and stopped containers. On a handful of occassions this buildup resulted in maxed out hard drives slowing down my laptop or halting my automated build pipeline. Talk about "containers everywhere"!

We can remove all untagged images by combining docker rmi with the recent dangling=true query:

```
docker images -q --filter "dangling=true" | xargs docker rmi
```

Docker won't be able to remove images that are behind existing containers, so you may have to remove stopped containers with docker rm first:

```
docker rm `docker ps --no-trunc -aq`
```

These are known pain points with Docker, and may be addressed in future releases. However, with a clear understanding of images and containers, these situations can be avoided with a couple of practices:

- Always remove a useless, stopped container with docker rm [CONTAINER_ID].
- Always remove the image behind a useless, stopped container with docker rmi [IMAGE_ID].
