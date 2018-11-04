# How is ENTRYPOINT instruction under Dockerfile different from RUN instruction?



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
