### ONBUILD Making wedding clothes for others

Format: `ONBUILD <other instructions>`.

`ONBUILD` is a special instruction, followed by other instructions, such as `RUN`, `COPY`, etc., and these instructions will not be executed when the current image is built. Only when the current image is mirrored, the next level of mirroring will be executed.

The other instructions in `Dockerfile` are prepared to customize the current image. Only `ONBUILD` is prepared to help others customize themselves.

Suppose we want to make an image of the application written by Node.js. We all know that Node.js uses `npm` for package management, and all dependencies, configuration, startup information, etc. are placed in the `package.json` file. After getting the program code, you need to do `npm install` first to get all the required dependencies. Then you can start the app with `npm start`. Therefore, in general, `Dockerfile` will be written like this:

```Dockerfile
FROM node:slim
RUN mkdir /app
WORKDIR /app
COPY ./package.json /app
RUN [ "npm", "install" ]
COPY . /app/
CMD [ "npm", "start" ]
```

Put this `Dockerfile` in the root directory of the Node.js project, and after building the image, you can use it to start the container. But what if we have a second Node.js project? Ok, then copy this `Dockerfile` to the second project. If there is a third project? Copy it again? The more copies of a file, the more difficult it is to have version control, so let's continue to look at the maintenance of such scenarios.

If the first Node.js project is in development, I find that there is a problem in this `Dockerfile`, such as typing a typo, or installing an extra package, then the developer fixes the `Dockerfile`, builds it again, and solves the problem. The first project is ok, but the second one? Although the original `Dockerfile` was copied and pasted from the first project, it will not fix their `Dockerfile` because the first project, and the `Dockerfile` of the second project will be automatically fixed.

So can we make a base image, and then use the base image for each project? In this way, the basic image is updated, and each project does not need to synchronize the changes of `Dockerfile`. After rebuilding, it inherits the update of the base image. Ok, yes, let's see the result. Then the above `Dockerfile` will become:

```Dockerfile
FROM node:slim
RUN mkdir /app
WORKDIR /app
CMD [ "npm", "start" ]
```

Here we take out the project-related build instructions and put them in the subproject. Assuming that the name of the base image is `my-node`, the own `Dockerfile` in each project becomes:

```Dockerfile
FROM my-node
```

Yes, there is only one such line. When constructing a mirror with this one-line `Dockerfile` in each project directory, the three lines of the previous base image `ONBUILD` will start executing, successfully copy the current project code into the image, and execute for this project. `npm install`, generate an application image.


# Lab 
```
# Dockerfile
FROM busybox
ONBUILD RUN echo "You won't see me until later"
```
# Docker build 
```
docker build -t me/no_echo_here .

Uploading context  2.56 kB
Uploading context
Step 0 : FROM busybox
Pulling repository busybox
769b9341d937: Download complete
511136ea3c5a: Download complete
bf747efa0e2f: Download complete
48e5f45168b9: Download complete
 ---&gt; 769b9341d937
Step 1 : ONBUILD RUN echo "You won't see me until later"
 ---&gt; Running in 6bf1e8f65f00
 ---&gt; f864c417cc99
Successfully built f864c417cc9
```
Here the ONBUILD instruction is read, not run, but stored for later use.
```
# Dockerfile
FROM me/no_echo_here
```
docker build -t me/echo_here .
Uploading context  2.56 kB
Uploading context
Step 0 : FROM cpuguy83/no_echo_here

# Executing 1 build triggers
```
Step onbuild-0 : RUN echo "You won't see me until later"
 ---&gt; Running in ebfede7e39c8
You won't see me until later
 ---&gt; ca6f025712d4
 ---&gt; ca6f025712d4
Successfully built ca6f025712d4
```

## Ubutu Rails 

```
FROM ubuntu:12.04

RUN apt-get update -qq && apt-get install -y ca-certificates sudo curl git-core
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN locale-gen  en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
ENV LC_ALL en_US.UTF-8

RUN curl -L https://get.rvm.io | bash -s stable
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
RUN /bin/bash -l -c rvm requirements
RUN source /usr/local/rvm/scripts/rvm && rvm install ruby
RUN rvm all do gem install bundler

ONBUILD ADD . /opt/rails_demo
ONBUILD WORKDIR /opt/rails_demo
ONBUILD RUN rvm all do bundle install
ONBUILD CMD rvm all do bundle exec rails server

```
This Dockerfile is doing some initial setup of a base image. Installs Ruby and bundler. Pretty typical stuff. At the end are the ONBUILD instructions.

ONBUILD ADD . /opt/rails_demo Tells any child image to add everything in the current directory to /opt/railsdemo. Remember, this only gets run from a child image, that is when another image uses this one as a base (or FROM). And it just so happens if you look in the repo I have a skeleton rails app in railsdemo that has it's own Dockerfile in it, we'll take a look at this later.

ONBUILD WORKDIR /opt/rails_demo Tells any child image to set the working directory to /opt/rails_demo, which is where we told ADD to put any project files

ONBUILD RUN rvm all do bundle install Tells any child image to have bundler install all gem dependencies, because we are assuming a Rails app here.

ONBUILD CMD rvm all do bundle exec rails server Tells any child image to set the CMD to start the rails server

Ok, so let's see this image build, go ahead and do this for yourself so you can see the output.

```
git clone git@github.com:sangam14/docker_onbuild.git 
cd docker_onbuild
docker build -t sangam14/docker_onbuild .

Step 0 : FROM ubuntu:12.04
 ---&gt; 9cd978db300e
Step 1 : RUN apt-get update -qq &amp;&amp; apt-get install -y ca-certificates sudo curl git-core
 ---&gt; Running in b32a089b7d2d
# output supressed
ldconfig deferred processing now taking place
 ---&gt; d3fdefaed447
Step 2 : RUN rm /bin/sh &amp;&amp; ln -s /bin/bash /bin/sh
 ---&gt; Running in f218cafc54d7
 ---&gt; 21a59f8613e1
Step 3 : RUN locale-gen  en_US.UTF-8
 ---&gt; Running in 0fcd7672ddd5
Generating locales...
done
Generation complete.
 ---&gt; aa1074531047
Step 4 : ENV LANG en_US.UTF-8
 ---&gt; Running in dcf936d57f38
 ---&gt; b9326a787f78
Step 5 : ENV LANGUAGE en_US.UTF-8
 ---&gt; Running in 2133c36335f5
 ---&gt; 3382c53f7f40
Step 6 : ENV LC_ALL en_US.UTF-8
 ---&gt; Running in 83f353aba4c8
 ---&gt; f849fc6bd0cd
Step 7 : RUN curl -L https://get.rvm.io | bash -s stable
 ---&gt; Running in b53cc257d59c
# output supressed
---&gt; 482a9f7ac656
Step 8 : ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
 ---&gt; Running in c4666b639c70
 ---&gt; b5d5c3e25730
Step 9 : RUN /bin/bash -l -c rvm requirements
 ---&gt; Running in 91469dbc25a6
# output supressed
Step 10 : RUN source /usr/local/rvm/scripts/rvm &amp;&amp; rvm install ruby
 ---&gt; Running in cb4cdfcda68f
# output supressed
Step 11 : RUN rvm all do gem install bundler
 ---&gt; Running in 9571104b3b65
Successfully installed bundler-1.5.3
Parsing documentation for bundler-1.5.3
Installing ri documentation for bundler-1.5.3
Done installing documentation for bundler after 3 seconds
1 gem installed
 ---&gt; e2ea33486d62
Step 12 : ONBUILD ADD . /opt/rails_demo
 ---&gt; Running in 5bef85f266a4
 ---&gt; 4082e2a71c7e
Step 13 : ONBUILD WORKDIR /opt/rails_demo
 ---&gt; Running in be1a06c7f9ab
 ---&gt; 23bec71dce21
Step 14 : ONBUILD RUN rvm all do bundle install
 ---&gt; Running in 991da8dc7f61
 ---&gt; 1547bef18de8
Step 15 : ONBUILD CMD rvm all do bundle exec rails server
 ---&gt; Running in c49139e13a0c
 ---&gt; 23c388fb84c1
Successfully built 23c388fb84c1
```


## Contributor - [Sangam Biradar](https://www.linkedin.com/in/sangambiradar14/)

Next >> [healthcheck](https://dockerlabs.collabnix.com/beginners/dockerfile/healthcheck.html)
