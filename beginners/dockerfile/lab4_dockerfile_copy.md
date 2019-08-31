# Lab #2: Create an image with COPY instruction

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


## Create a Dockerfile_1 under the same directory.

If you want to store a multiple Dockerfile, you can just rename them as Dockerfile_1 or Dockerfile_ADD and pass -f while you build Docker Image using ```docker build``` command.

Let us download GIT Tar file with the below command under the root directory:

```
wget https://mirrors.edge.kernel.org/pub/software/scm/git/git-1.8.3.1.tar.gz
```

Now copy the content from the below Dockerfile and save it under a file named "DockerFile_COPY"

```
$ cat Dockerfile_copy
FROM alpine:3.6
MAINTAINER ajeetraina@gmail.com
COPY git-1.8.3.1.tar.gz /home/
#ADD https://mirrors.edge.kernel.org/pub/software/scm/git/git-1.8.3.1.tar.gz /
```

## Building Docker Image

```
docker build -t ajeetraina/lab2_dockerfile_lab2 . -f Dockerfile_copy
```
[Lab #4: CMD instruction](https://dockerlabs.collabnix.com//beginners/dockerfile/lab4_cmd.html)
