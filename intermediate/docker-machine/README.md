#Introduction to the Docker Machine

#Docke-machine 

Docker machine is a tool which lets you to install docker engine in remote hosts. It can be used to provision docker in different operating system or even in the different cloud providers like aws, azure, digitaloceans, etc. ``` docker-machine ``` command handles all the activities of remote hosts. Visit [docker-machine](https://docs.docker.com/machine/overview/) for the official documentation.

##Installation 

You can install docker-machine in various flavours of linux operating system and since I am using fedora so this file contain installation steps required to install in it.  

 Install [Docker](https://docs.docker.com/install/)

Execute the following command which download the docker-machine binary and put it into your $PATH. 
	```base=https://github.com/docker/machine/releases/download/v0.16.0 &&
	   curl -L $base/docker-machine-$(uname -s)-$(uname -m) >/tmp/docker-machine &&
	   sudo mv /tmp/docker-machine /usr/local/bin/docker-machine &&
	   chmod +x /usr/local/bin/docker-machine```

Verify the installation. 
	```docker-machine version``` 

For installation of docker-machine in other operating systems, kindly follow the [Official Documentation](https://docs.docker.com/machine/install-machine/).

##Driver dependency. 

For using docker-machine to create, use and manage the docker host locally, you should have virtualization driver installed in your system. There are different drivers availabe which supports docker-machine depending upon the type of virtualizaiton technology you use. For KVM, docker-machine use docker-machine-driver-kvm where as for Virtualbox it uses virtualbox driver. 

KVM driver. 

	Configuring in RHEL/CentOS based system.  

	```  curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-centos7 \
	> /usr/local/bin/docker-machine-driver-kvm \ 
	chmod +x /usr/local/bin/docker-machine-driver-kvm  ```

	Configuring in Debian based system. 

	```  curl -L https://github.com/dhiltgen/docker-machine-kvm/releases/download/v0.10.0/docker-machine-driver-kvm-ubuntu14.04 \
	> /usr/local/bin/docker-machine-driver-kvm \ 
	chmod +x /usr/local/bin/docker-machine-driver-kvm   ```

VritualBox

	Virtualbox uses vboxdrv driver and installation is quite simple than that of KVM. Install virtualbox and you are all set to use docker-machine. 

##Provision of docker host locally. 

To create docker host locally you can simply execute ```docker-machine create docker-vm-name```. This command go forward to create docker virtual machine locally on top of your hypervisor. You can also specify the particular driver for instantiating vm depending upon your requirements i.e.

	```docker-machine create -d virtualbox docker_vm_name```

You can create as many docker vm as per your requirements. You can use ``` docker-machine ls ``` command to list all the docker machines installed locally. This command also provides information of vm like name, status, driver, state, ip, etc.

To start the stoped docker machine enter ```docker-machine start docker_machine_name```

##Running containers on docker machine. 

After creating docker machine you can execute command from the host system to the docker_machine_name. For this you need to connect your shell to the docker machine.i.e.  
	```eval $(docker-machine env docker_vm_name)```

Now you can simply execute the commands in newly created docker_docker_vm from your local system. i.e. 

	```docker run -it --security-opt seccomp:unconfined ubuntu /bin/bash```

This command pull the ubuntu image in docker_machine_name from the docker reigistry and invoke bash terminal from it. 

You can switch between different docker_machine_vm with the help of ```eval``` command. 



## Contributor - [Yadav Lamichhane](https://www.linkedin.com/in/omegazyadav1/)
