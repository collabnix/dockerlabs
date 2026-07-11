

## What is a Docker Image? 

Docker image is the one that is shipped with code and can be run on any platform where docker Engine is installed. Lets take an example:
Think a developer writes code and then he packages all the code, dependencies , installables etc in one file called Dockerfile and create an image out of it .
Now this Image if give to any developer across any platform will run on Docker Engine as a container . 
Docker images is the core of the whole Docker as a platform. Docker Image followed a layered architecture which helps to rebuild
the image faster. 
![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/images/layer.png)

If you see above, it is a 4 layered docker image formed by below instruction:

```
FROM ubuntu
COPY . /app
RUN make /app
CMD python /app/test.py
```
Since this is layered architecture now if you change only the last layer and rebuild the image then the only the last layer is pushed 
and other layers are used as is.

# Dockerhub
hub.docker.com is the official DockerHub image repository store where all the official as well as community public images can be found.

![My Image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/images/dockerhub.png)

If you see above nginx has official image and other community image with some customization. Official image are docker verified and other Images 
are free to use as per need from the community.

This is what docker image is at its core.

## Contributor - [Saiyam Pathak](https://www.linkedin.com/in/saiyam-pathak-97685a64/)

