## What is a Dockerfile?

A Dockerfile is a text file which contains a series of commands or instructions. These instructions are executed in the order in which they are written.
Execution of these instructions takes place on a base image. Hence, on building the Dockerfile, the successive actions form a new image from the base parent image.

We will go through each of instructions under Dockerfile and see how it is used.

[Lab #1: Create an image with nodejs installed]()<br>
[Lab #2: Create an image with ADD instruction]()<br>
[Lab #3: Create an image with COPY instruction]()<br>
[Lab #4: Create an image with CMD instruction]()<br>
[Lab #5: Create an image with ENTRYPOINT instruction]()<br>
[Lab #6: Create an image with WORKDIR instruction]()<br>
[Lab #7: Create an image with RUN instruction]()<br>
[Lab #8: Create an image with EXPOSE instruction]()<br>
[Lab #9: Create an image with VOLUME instruction]()<br>
[Lab #10: Create an image with EXPOSE instruction]()<br>
[Lab #11: Create an image with LABEL instruction]()<br>
[Lab #12: Create an image with ONBUILD instruction]()<br>
[Lab #13: Create an image with HEALTHCHECK instruction]()<br>
[Lab #14: Create an image with SHELL instruction]()<br>
[Lab #15: Create an image with Python Script]()<br>

# Lab #1: Create an image with nodejs and npm installed

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




# Lab #1: Create an image with nodejs and npm installed

To begin, we will create a new directory.


