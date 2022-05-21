FROM ubuntu:18.04

ENV pip_packages "ansible"

RUN apt update -y
RUN apt install -y coreutils python python-pip curl
RUN pip install $pip_packages


RUN echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" > /etc/apt/sources.list.d/azure-cli.list

RUN curl -L https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

RUN apt-get install -y apt-transport-https
RUN apt-get update && sudo apt-get install azure-cli


