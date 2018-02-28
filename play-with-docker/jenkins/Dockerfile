FROM jenkins/jenkins:alpine
USER root

# set version label
LABEL maintainer="Ajeet Raina"

# Install the latest Docker CE binaries
RUN \
echo "**** install runtime packages ****" && \
apk add --no-cache \
    docker && \
echo "**** cleanup ****" && \
rm -rf \
    /tmp/*

# set default user
USER jenkins
