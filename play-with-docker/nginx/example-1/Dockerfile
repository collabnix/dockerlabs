#Build with Dockerfiles

FROM ubuntu:14.04
MAINTAINER "Ajeet Raina" <ajeetraina@docker.com>
RUN apt-get update
RUN apt-get install -y nginx
RUN echo 'Hi, I am inside your container' \
>/usr/share/nginx/html/index.html
CMD [ "nginx", "-g", "daemon off;" ]
EXPOSE 80
