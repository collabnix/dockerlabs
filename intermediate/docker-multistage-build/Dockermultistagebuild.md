# Building Dockerfiles in Multistage Build

### Before Multistage Build

Keeping the image size small is one of the most difficult aspects of creating images.Every Dockerfile command adds a layer to the image, therefore before adding the next layer, remember to remove any artifacts you don't need.Traditionally, writing an extremely effective Dockerfile required using shell tricks and other logic to keep the layers as compact as possible and to make sure that each layer only included the items it required from the previous layer and nothing else.

In reality, it was rather typical to use one Dockerfile for development (which included everything required to build your application) and a slimmed-down one for production (which only included your application and precisely what was required to run it).The "builder pattern" has been applied to this.It is not ideal to keep two Dockerfiles up to date.

The example that follows uses a simple React application that is first developed and then has its static content served by a Nginx virtual server.The two Dockerfiles that were utilized to produce the optimized image are listed below.You'll also see a shell script that illustrates the Docker CLI instructions that must be executed to achieve this result.

Here’s an example of a `Dockerfile.build`, `Dockerfile.main` and `Dockerfile` which adhere to the builder pattern above:

`Dockerfile.build`

```
FROM node:alpine3.15
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build
```

`Dockerfile.main`

```
FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY /app/build /usr/share/nginx/html
```

`Build.sh`

```
#!/bin/sh
echo Building myimage/react:build

docker build -t myimage:build . -f Dockerfile.build

docker create --name extract myimage:build

docker cp extract:/app/build ./app

docker rm -f extract

echo Building myimage/react:latest

docker build --no-cache -t myimage/react:latest . -f Dockerfile.main
```

### How to Use Multistage Builds in Docker 

In **Docker Engine 17.05**, multi-stage build syntax was included. You use numerous `FROM` statements in your Dockerfile while performing multi-stage builds.Each `FROM` command can start a new stage of the build and may use a different base.Artifacts can be copied selectively from one stage to another, allowing you to remove anything unwanted from the final image.Let's modify the `Dockerfile` from the preceding section to use multi-stage builds to demonstrate how this works. 

`Dockerfile`

```
FROM node:alpine3.15 as build
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=build /app/build /usr/share/nginx/html
```

Here only one Dockerfile is required.Additionally, you don't require a separate build script.Simply run `docker build .` 

There are two `FROM` commands in this `Dockerfile`, and each one represents a different build step.In this phase, the application is created and stored in the directory that the `WORKDIR` command specifies.The Nginx image is first pulled from Docker Hub to begin the second stage.The revised virtual server configuration is then copied to replace the stock Nginx configuration.then, the image created by the prior stage is utilised to copy only the production-related application code using the `COPY -from` command. 

The stages are not named by default; instead, you refer to them by their integer number, which starts at 0 for the first `FROM` command.However, you can give your stages names by following the `FROM` instruction with an `AS <NAME>`.Here we used `build` as a name.By naming the stages and using the names in the `COPY` command, this example enhances the prior one.This means that the `COPY` remains intact even if the instructions in your `Dockerfile` are later rearranged. 

### Repurpose an earlier stage as a new stage. 

The `FROM` command allows you to continue where a previous stage ended by referring to it.For instance: 
```
FROM alpine:latest AS builder
...
...

FROM builder AS build1
...
...

FROM builder AS build2
...
...
```

### Use an external image as a "stage"
When using multi-stage builds, you are not limited to copying from stages you created earlier in your Dockerfile. You can use the `COPY --from` instruction to copy from a separate image, either using the local image name, a tag available locally or on a Docker registry, or a tag ID. The Docker client pulls the image if necessary and copies the artifact from there. The syntax is:

`COPY --from=sampleapp:latest home/user/app/config.json app/config.json`

## Demonstrating Multi-Stage Builds

For demonstration, Let us consider a nodejs project and build a binary out of it. When you execute this binary, it will call a [NASA api](https://api.nasa.gov/api.html) which returns some interesting facts about today's date.

#### Before: docker images

![Before docker images list](https://github.com/kumarrishav/dockerlabs/blob/patch-2/images/multi-stage-img1.png)

Currently we have two images which I pulled from [dockerhub](https://hub.docker.com/): 
* `alpine (~4Mb)` - Lightest version of linux os
* `alpine-node (~70Mb)` - alpine + Node/Npm and other dependency.

#### File structure

![file structure](https://github.com/kumarrishav/dockerlabs/blob/patch-2/images/multi-stage-img2.png)

* `Dockerfile`:
  
  * On stage 0 (alias: `builder`), we have a `alpine-node` OS which has `node` and `npm` built in it. Its size is `~70Mb`. This stage will create binary (named as `nasa` : _Line 6_) in the current `WORKDIR` i.e `app/`.  
  * On stage 1, we have `alpine` OS. After that, we install some necessary dependencies. In `Line 14`, we copied `nasa` binary from previous stage (`builder`) to current stage. So, we just copied binary and leaving all heavy `alpine-node` OS and other dependencies like `npm` ([node package manager](https://www.npmjs.com/)) etc as binary already have required dependecies (like nodejs) built in it.
  
* `app/` : It's just a simple node application. It does a `https` call and fetches data using nasa api. It has `index.js` and `package.json`. I have used `pkg` to build the node binary.


#### After: docker images

![After docker images list](https://github.com/kumarrishav/dockerlabs/blob/patch-2/images/multi-stage-img3.png)

 **multistage:1.0.0** (`56b102754f6d`) is the final required image which we built. Its size is `~45Mb`. Almost **1/4th** of the intermediate image(`13bac50ebc1a`) built on stage 0. And almost **half** of `alpine-node` image.
 
So, this was a simple example to showcase multi-stage builds feature. For images having multi step (like 10-15 FROM statement), you will find this feature very useful.
