FROM openjdk:8

WORKDIR /app

COPY . /app/

RUN javac helloworld.java

ENTRYPOINT [ "java","helloworld" ]
