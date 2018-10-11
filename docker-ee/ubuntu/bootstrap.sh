#!/bin/bash

prepare_ubuntu() {
  sudo apt-get -y remove docker docker-engine docker-ce docker.io
  sudo apt-get autoremove
  sudo apt-get update -y
  sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
}

install_dockeree() {
  # Docker
  DOCKER_EE_URL=https://storebits.docker.com/ee/ubuntu/$eeid
  export DOCKER_EE_VERSION=stable-17.06
  sudo curl -fsSL "${DOCKER_EE_URL}/ubuntu/gpg" | sudo apt-key add -
  sudo apt-key fingerprint 6D085F96
  sudo add-apt-repository \
   "deb [arch=amd64] $DOCKER_EE_URL/ubuntu \
   $(lsb_release -cs) \
   $DOCKER_EE_VERSION"
 sudo apt update
 sudo apt install -y docker-ee
 apt-cache madison docker-ee
 
EOF
  ## Start docker service
  sudo systemctl enable docker
  sudo systemctl start docker
  ## Add current user to docker group
  sudo usermod -aG docker $USER
  ## show information
  sudo docker version
  sudo docker info
}
  
provision_dockeree() {
  echo "Provisioning ..."
  prepare_ubuntu
  install_dockeree
  # Download the Dockerfile and docker-compose.yml
}

provision_ucp() {
  # Install JRE (Only needed for running PSI locally)
  sudo docker container run --rm -it --name ucp   -v /var/run/docker.sock:/var/run/docker.sock   docker/ucp:3.0.5 install   --host-address `hostname -i` --interactive
}

install_kubectl() {
  # Set the Kubernetes version as found in the UCP Dashboard or API
  k8sversion=v1.8.11
  # Get the kubectl binary.
  curl -LO https://storage.googleapis.com/kubernetes-release/release/$k8sversion/bin/linux/amd64/kubectl
  # Make the kubectl binary executable.
  chmod +x ./kubectl
  # Move the kubectl executable to /usr/local/bin.
  sudo mv ./kubectl /usr/local/bin/kubectl
}

command=$1
#shift
case "$command" in
  build)          build ;;
  up)             up $@ ;;
  down)           down $@ ;;
  logs)           logs $@ ;;
  provision_dockeree)      provision_dockeree $@ ;;
  provision_ucp) provision_ucp ;;
  install_kubectl) install_kubectl ;;
  *)        echo "Usage: <build|up|down|logs|psi|provision_dockeree|provision_ucp|install_kubectl>" ;;
esac
