# How to Connect to a Remote Docker Daemon


Most of the time we connect to Docker running on our local machine, but you can also connect to Docker on a different machine too.
A great use case for this would be if you’re running Windows 10 Home edition and can’t run Hyper-V which means you can’t run Docker for Windows.

Normally you would reach for using the Docker Toolbox and the Docker QuickStart Terminal which runs Git Bash, but you can bypass all of that and use WSL instead.

If you’re only interested in connecting to a remote daemon and already have a VM or host running Docker you can jump straight to steps 4 and 5.

## Pick a way to create your own VM:

To create your own VM to run Docker, I personally think the best choice is to use VMware Player for Windows since it’s free and its file mount performance is just as fast as Hyper-V.

The file mount performance is another main reason why I much prefer this set up over using Docker Toolbox. That’s because Docker Toolbox uses VirtualBox under the hood which is quite slow and has all sorts of file syncing bugs.

##  Install Ubuntu 18.04 in your VM:

I have a few year old video that goes over how to set up xubuntu 14.x with VMware Player, but you can download and use Ubuntu 18.04 server edition instead.

The installation instructions should be about the same when it gets to installing the OS. You’ll want to watch from 1:57 to 11:28 in the video (everything else can be skipped).

##  Install Docker in your VM:

After you’ve installed Ubuntu 18.04 and logged into your server, you can copy / paste the Ubuntu 18.04 installation steps from my WSL guide directly into your VM’s prompt.

##  Configure the Docker daemon in the VM to allow remote connections:

Keep in mind this is only meant to be used for local connections between your newly minted VM and your dev box with WSL. This is not meant to be used to connect from external networks because we’re going to connect unencrypted.

The reason we’re doing it over an unencrypted channel is because otherwise you’ll need to set up SSL certificates. You could always create self-signed certs and use those if you’re paranoid about local network traffic not being encrypted.

# These commands get run inside of your VM.

# Create the directory to store the configuration file.

```
sudo mkdir -p /etc/systemd/system/docker.service.d
```

# Create a new file to store the daemon options.

```
sudo nano /etc/systemd/system/docker.service.d/options.conf
```

# Now make it look like this and save the file when you're done:
```
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H unix:// -H tcp://0.0.0.0:2375

# Reload the systemd daemon.
sudo systemctl daemon-reload

# Restart Docker.
sudo systemctl restart docker
```

That’s going to let you continue to connect to the Docker daemon from within the VM thanks to -H unix://, but it also exposes the Docker Daemon with -H tcp://0.0.0.0:2375 so that anyone can connect to it over the non-encrypted port.


When I say “anyone”, that would be anyone on your local network, assuming you have a router / firewall that is blocking port 2375 from the outside world.

##  Configuring your dev box to connect to the remote Docker daemon:

Let’s say you were inside of WSL. You could run DOCKER_HOST=tcp://X.X.X.X:2375 docker info where you’ll want to replace X.X.X.X with your VM’s IP address (or hostname).

If you want to set DOCKER_HOST by default so it always connects remotely you can export it in your ~/.bashrc file. Here’s an example of that as a 1 liner:

```
echo "export DOCKER_HOST=tcp://X.X.X.X:2375" >> ~/.bashrc && source ~/.bashrc
```

That just adds the export line to your .bashrc file so it’s available every time you open your terminal. The source command reloads your bash configuration so it takes effect now.

Congratulations, you’re now able to connect to a remote Docker daemon.

Here’s a follow up guide on how to configure WSL to run Docker if you’re interested. You can jump straight to the installing Docker and Docker Compose section.
