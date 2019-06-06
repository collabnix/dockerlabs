# Dockerfile
FROM ubuntu:16.04
# Install jdk 
RUN apt-get update && apt-get install openjdk-8-jre -y 
# Unzip kafka zip and rename at kafka
ENV kafka_version=2.11-1.1.0 
ADD ./kafka_${kafka_version}.tgz ./ 
RUN mv kafka_${kafka_version} kafka
