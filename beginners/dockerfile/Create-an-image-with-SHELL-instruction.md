 ## Create an image with SHELL instruction
1- Install Docker latest version.<br>

2- Create a directory for the Dockerfile. <br>

3- Go to the path. <br>

4- Create the Dockerfile with instruction. <br>
```
vi Dockerfile
FROM alpine:3.4

RUN apk update && \
    apk add curl && \
    apk add vim && \
    apk add git
```

5- Build the Docker Image for Dockerfile from Shell with <br>
```
#docker build  -t image_name .
```
if you want to remove intermediate containers then use;
```
#docker build --force-rm  -t image_name .
```
if you want to build without existing cache then;
```
#docker build  --no-cache -t image_name .
```
here in above commands '.' represents the current directory where Dockerfile kept. If you want to build the Image from remote or different directory then paste the path of dockerfile <br>

If the name of the Dockerfile is different than 'Dockerfile' then need to give file name in command line as ```-f Dockerfile_name```
