sudo apt-get -y remove docker docker-engine docker-ce docker.io
sudo apt autoremove
sudo apt update -y
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    software-properties-common
DOCKER_EE_URL=https://storebits.docker.com/ee/ubuntu/<>   ## ADD URL from store.docker.com
DOCKER_EE_VERSION=stable-17.06
sudo curl -fsSL "${DOCKER_EE_URL}/ubuntu/gpg" | sudo apt-key add -
sudo apt-key fingerprint 6D085F96
sudo add-apt-repository \
  "deb [arch=amd64] $DOCKER_EE_URL/ubuntu \
  $(lsb_release -cs) \
  $DOCKER_EE_VERSION"
sudo apt update
sudo apt install docker-ee
