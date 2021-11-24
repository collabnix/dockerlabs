# Lab #4: Build Command
In this lab we are going to look into <b>docker-compose build</b> command.Docker build used to create a new image using the instructions in the Dockerfile. The <b>build</b> can be specified either as a string containing a path to the build context. The newly built image will be used to create the container for the service.

## Command instructions

#### build

The format is docker-compose build [options] [SERVICE...] .

Build (rebuild) the service container in the project.

Once the service container is built, it will be tagged with a tagname, such as a db container in a web project, possibly web_db.

You can rebuild the service at any time by running the docker-compose build in the project directory.

Options include:

`--force-rm` removes the temporary container during the build process.

`--no-cache` does not use cache during the build image process (this will lengthen the build process).

`--pull always` tries to get a mirror of the updated version by `--pull` .



## Pre-requisite:

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Docker</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side

We are going to build an nginx image with custome page 

#### Setup environment:
```
$ mkdir docker-compose/build
$ cd docker-compose/build
```

#### Now lets create the Dockerfile
```
FROM nginx:alpine
RUN echo "Welcome to Docker Workshop!" >/usr/share/nginx/html/index.html
CMD ["nginx", "-g", "daemon off;"]
```

#### Create a docker-compose.yml file
```
version: "3.7"
services:
  webapp:
    build:
      context: .
      dockerfile: Dockerfile
    image: webapp:v1
```
<b>context:</b> To specify the build context directory that is sent to the Docker daemon.<br>
<b>dockerfile:</b> use to specify Alternate Dockerfile or path to Dockerfile.
#### Build the image using docker-compose
```
$ docker-compose build
```
Since we specified <b>image:</b> as well as <b>build:</b>, then the Compose built the image with name <b>webapp</b> and tag <b>v1</b>.<br>
If we didnt specify the <b>image:</b> option the image name will be <b>buid_<service_name>:latest</b>.

#### Check the image have created
```
$ docker image ls webapp:v1
```

### Quick Notes:

#### build

Specifies the path to the folder where the Dockerfile is located (either an absolute path or a path relative to the docker-compose.yml file). Compose will use it to automatically build this image and then use this image.
```
 version: '3' services:  webapp:  build: ./dir 
```  
You can also use the context directive to specify the path to the folder where the Dockerfile is located.

Use the dockerfile directive to specify the Dockerfile filename.

Use the arg directive to specify the variables when the image is built.
```
 version: '3' services:  webapp:  build:  context: ./dir  dockerfile: Dockerfile-alternate  args:  buildno: 1 
 ```
Use cache_from specify the cache to build the image
```
 build:  context: .  cache_from:  - alpine: latest  - corp/web_app: 3.14 
```
## Contributor
[Sangam Biradar](https://www.linkedin.com/in/sangambiradar14/)<br>
[Savio Mathew](https://www.linkedin.com/in/saviovettoor)

[Lab #5: Pull Command](http://dockerlabs.collabnix.com/intermediate/workshop/DockerCompose/pull_command.html)<br>
