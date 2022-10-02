
# Building Dockerfiles in Multistage Build

### Before Multistage Build

Keeping the image size small is one of the most difficult aspects of creating images.Every Dockerfile command adds a layer to the image, therefore before adding the next layer, remember to remove any artefacts you don't need.Traditionally, writing an extremely effective Dockerfile required using shell tricks and other logic to keep the layers as compact as possible and to make sure that each layer only included the items it required from the previous layer and nothing else.

In reality, it was rather typical to use one Dockerfile for development (which included everything required to build your application) and a slimmed-down one for production (which only included your application and precisely what was required to run it).The "builder pattern" has been applied to this.It is not ideal to keep two Dockerfiles up to date.

The example that follows uses a simple React application that is first developed and then has its static content served by a Nginx virtual server.The two Dockerfiles that were utilized to produce the optimized image are listed below.You'll also see a shell script that illustrates the Docker CLI instructions that must be executed to achieve this result.

Here’s an example of a `Dockerfile.build`, `Dockerfile.main` and `Dockerfile` which adhere to the builder pattern above:

`Dockerfile.build`

```
FROM node:12.13.0-alpine
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

You use numerous `FROM` statements in your Dockerfile while performing multi-stage builds.Each `FROM` command can start a new stage of the build and may use a different base.Artifacts can be copied selectively from one stage to another, allowing you to remove anything unwanted from the final image.Let's modify the `Dockerfile` from the preceding section to use multi-stage builds to demonstrate how this works. 

`Dockerfile`

```
FROM node:12.13.0-alpine as build
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







