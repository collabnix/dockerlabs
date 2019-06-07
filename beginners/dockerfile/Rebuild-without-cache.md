## Concept of Caching in Docker

When you first build a Dockerfile, Docker caches the results so that subsequent builds become fast. When a RUN, ADD, COPY or a similar instruction is encountered, a new layer is created over the base image. The file structure formed is stored by default at /var/lib/docker in a Linux based host system. All base images and containers are stored in this folder only. 

These files/directories are stored on disk and disk operations are time-consuming and resource-intensive.
If these files/filesystem objects remain unchanged during future builds or during container creations, Docker cache becomes useful to save time. New containers or images are created at a faster rate since disk operations are eliminated.

Let's see what happens when we rebuild an image which was already built.

Dockerfile used in this case is as such:



![Dockerfile](https://github.com/Prashansa-K/Docker/blob/master/Writing%20Dockerfiles/layering1.png)



We first built this Dockerfile to create testimage:latest. Now, building testimage:v2.

![Cache](https://github.com/Prashansa-K/Docker/blob/master/Writing%20Dockerfiles/cache.png)

As you can see in the image, every instruction was executed using the cache as the same file was already built before.

Usually, caching is desirable and beneficial, but at times we want new rebuilds due to changes in layers which could not be detected by the docker daemon. For example, change of command provided with RUN instruction. Sometimes, due to faulty installations, our application crashes. We wish to install everything from the beginning, but the cache may create conflicts.

To resolve such issues, we can opt for builds using --no-cache flag. With this flag, cache is ignored and the build is treated as a new one and everything begins from the start.

Let's build the same Dockerfile again. This time we will use the option --no-cache. 

![No Cache](https://github.com/Prashansa-K/Docker/blob/master/Writing%20Dockerfiles/nocache.png)

As you can see, the build is fresh and no cache is used.


## Contributor

[Prashansa Kulshrestha](https://github.com/Prashansa-K/)
