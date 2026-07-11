# Running Desktop GUI Applications on Docker

## How is it  different from runing any other application?

There is not much of a difference between running desktop applications and web applications on docker, Only difference which arises is desktop applications requires GUI service/server which serves the interface. This GUI server is not present in the container but surely it is present on the host. So, one needs to map this server socket (or commong server file) to the container (Volume bind mounts to the rescue) so that container can serve using hosts GUI service/server.

![GUI server placement](https://raw.githubusercontent.com/akshitgrover/dockerlabs/master/beginners/images/desktop-gui.png)

Image Courtesy: https://medium.com/@SaravSun/running-gui-applications-inside-docker-containers-83d65c0db110

## Why would we do something like that? Running Desktop GUI on docker, I mean like why?

Well, There is not much to it but once you use this your life will be a lot easier if you are a developer building those GUI apps.

- Easy distribution thorugh docker images.
- Easy, Efficient and automated application builds.
- Avoid OS specific builds.
- Less testing overhead. (Redundant builds avoided)
- No dependency issue at all. (Ofcourse, What is docker for!)
- No installation issues, But you'll definitely need a fast internet though to pull the image.

I am pretty sure there will be many more advantages but above mentioned are enough to know the importance right?

***Note:*** Do create a PR if you would like to add more advantages.

`
One thing to care about while running desktop apps is that every OS (Linux, Mac, Windows)uses underlying GUI server in different ways. So, we'll have to tweak our docker commands a little, In order to run same GUI server on hosts with different OS.
`

## Operating System

- [Linux](#linux)

## Linux

Linux has an underlying XServer which is used to serve GUI. Linux host running docker will surely have XServer (Considering you are not running it in cloud console which does not have desktop environment), This XServer is than bind mounted in the container.

Also, We share $DISPLAY env var of the host with the container. As far as I understand this $DISPLAY var is nothing but XServer display port at which the GUI is served.

One more thing to note is we need to run container using --network=host flag as container has to reach the XServer of the host. (So one cannot run GUI applications on swarms)

Without further do let's dive into running one desktop GUI on a docker contianer on a Linux host.

```
docker container run --env="DISPLAY" -v="/tmp/.X11-unix:/tmp/.X11-unix" akshitgrover/xeyes:alpine
```

Dockerfile for akshitgrover/xeyes:alpine
```Dockerfile
FROM alpine

RUN apk update && \
apk add xeyes

CMD ["xeyes"]
```

***Note:*** 
- /tmp/.X11-unix is the socket file created by XServer.
- You may need to run `xhost local:` to allow local connections to XServer which are only allowed to specific users on the host.

Above example is a basic one. One can do something as cool as running firefox or android studio in a container.

Refer:

- [Running firefox](http://fabiorehm.com/blog/2014/09/11/running-gui-apps-with-docker/)
- [Running android studio](https://medium.com/@SaravSun/running-gui-applications-inside-docker-containers-83d65c0db110)


# Contributor:

- [Akshit Grover](https://www.linkedin.com/in/akshit-grover/)
