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
 sudo apt update -y
 sudo apt install -y docker-ee
 apt-cache madison docker-ee
 
EOF
  ## Start docker service
  sudo systemctl enable docker
  sudo systemctl start docker
  ## Add current user to docker group
  sudo usermod -aG docker $USER

  ## show information
  docker version
  docker info
  
  # Docker Compose
  sudo curl -L https://github.com/docker/compose/releases/download/1.19/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  ## show docker-compose version
  docker-compose version
}

provision_dockeree() {
  echo "Provisioning ..."
  prepare_ubuntu
  install_dockeree
  # Download the Dockerfile and docker-compose.yml

}

provision_ucp() {
  # Install JRE (Only needed for running PSI locally)
  sudo docker container run --rm -it --name ucp   -v /var/run/docker.sock:/var/run/docker.sock   docker/ucp:3
.0.5 install   --host-address `hostname -i` --interactive
}

install_kubectl() {
  AUTHTOKEN=$(curl -sk -d '{"username":"collabnix","password":"password"}' https://`hostname -i`/auth/login | jq -r .auth_token)
  sudo curl -k -H "Authorization: Bearer $AUTHTOKEN" https://`hostname -i`/api/clientbundle -o bundle.zip
  unzip bundle.zip
  eval "$(<env.sh)"
}




command=$1
shift
case "$command" in
  build)          build ;;
  up)             up $@ ;;
  down)           down $@ ;;
  logs)           logs $@ ;;
  provision_dockeree)      provision_dockeree $@ ;;
  provision_ucp) provision_ucp ;;
  *)        echo "Usage: <build|up|down|logs|psi|provision_dockeree|provision_ucp>" ;;
esac
