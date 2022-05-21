FROM tensorflow/tensorflow:latest
RUN apt-get update
RUN apt-get install python-opencv -y
ENV APP_HOME /app
WORKDIR $APP_HOME
ADD . $APP_HOME
