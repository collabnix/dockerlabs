# How is ENTRYPOINT instruction under Dockerfile different from RUN instruction?



ENTRYPOINT is meant to provide the executable while CMD is to pass the default arguments to the executable.
To understand it clearly, let us consider the below Dockerfile:


If you try building this Docker image using `docker build command` -


 Let us run this image without any argument.



Let's run it passing a command line argument

This clearly state that ENTRYPOINT is meant to provide the executable while CMD is to pass the default arguments to the executable.
