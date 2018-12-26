# Installing Docker Community Edition on RHEL 7.x
sudo yum install -y yum-utils
sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo yum makecache fast

Note:Before install docker we need to install container-selinux .container-selinux package is available from the rhel-7-server-extras-rpms .So we need to enable that in 7.
sudo yum-config-manager --enable rhui-REGION-rhel-server-extras

Install the latest version of Docker CE on RHEL:
sudo yum -y install docker-ce

Alternatively, you can specify a specific version of Docker CE:
sudo yum -y install docker-ce-<version>-<release>

Start Docker:
sudo systemctl start docker

Test your Docker CE installation:
sudo docker run hello-world



