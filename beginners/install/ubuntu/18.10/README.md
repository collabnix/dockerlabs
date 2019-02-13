# How to Install Docker Engine 18.09.2 on Ubuntu 18.10

```
sudo curl -sSL https://get.docker.com/ | sh
# Executing docker install script, commit: 26dda3d
+ sudo -E sh -c apt-get update -qq >/dev/null
+ sudo -E sh -c apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
+ sudo -E sh -c curl -fsSL "https://download.docker.com/linux/ubuntu/gpg" | apt-key add -qq - >/dev/null
Warning: apt-key output should not be parsed (stdout is not a terminal)
+ sudo -E sh -c echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu cosmic edge" > /etc/apt/sources.list.d/docker.list
+ sudo -E sh -c apt-get update -qq >/dev/null
+ sudo -E sh -c apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
+ sudo -E sh -c docker version
Client:
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.6
 Git commit:        6247962
 Built:             Sun Feb 10 04:13:46 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.2
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       6247962
  Built:            Sun Feb 10 03:42:13 2019
  OS/Arch:          linux/amd64
  Experimental:     false
If you would like to use Docker as a non-root user, you should now consider
adding your user to the "docker" group with something like:

  sudo usermod -aG docker robertsingh181

Remember that you will have to log out and back in for this to take effect!

WARNING: Adding a user to the "docker" group will grant the ability to run
         containers which can be used to obtain root privileges on the
         docker host.
         Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
         for more information.
@collabnix:~$ sudo usermod -aG docker robertsingh181
```

# Verifying Docker Version

```
$sudo docker version
Client:
 Version:           18.09.2
 API version:       1.39
 Go version:        go1.10.6
 Git commit:        6247962
 Built:             Sun Feb 10 04:13:46 2019
 OS/Arch:           linux/amd64
 Experimental:      false
Server: Docker Engine - Community
 Engine:
  Version:          18.09.2
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.6
  Git commit:       6247962
  Built:            Sun Feb 10 03:42:13 2019
  OS/Arch:          linux/amd64
  Experimental:     false
  ```
  
  # Verifying Containerd Version
  
  ```
  $ sudo containerd --help
NAME:
   containerd - 
                    __        _                     __
  _________  ____  / /_____ _(_)___  ___  _________/ /
 / ___/ __ \/ __ \/ __/ __ `/ / __ \/ _ \/ ___/ __  /
/ /__/ /_/ / / / / /_/ /_/ / / / / /  __/ /  / /_/ /
\___/\____/_/ /_/\__/\__,_/_/_/ /_/\___/_/   \__,_/
high performance container runtime
USAGE:
   containerd [global options] command [command options] [arguments...]
VERSION:
   1.2.2
COMMANDS:
     config    information on the containerd config
     publish   binary to publish events to containerd
     oci-hook  provides a base for OCI runtime hooks to allow arguments to be injected.
     help, h   Shows a list of commands or help for one command
GLOBAL OPTIONS:
   --config value, -c value     path to the configuration file (default: "/etc/containerd/config.toml")
   --log-level value, -l value  set the logging level [trace, debug, info, warn, error, fatal, panic]
   --address value, -a value    address for containerd's GRPC server
   --root value                 containerd root directory
   --state value                containerd state directory
   --help, -h                   show help
   --version, -v                print the version
  ```
  
  # Verifying Containerd Version
  
  ```
  $ sudo ctr version
Client:
  Version:  1.2.2
  Revision: 9754871865f7fe2f4e74d43e2fc7ccd237edcbce
Server:
  Version:  1.2.2
  Revision: 9754871865f7fe2f4e74d43e2fc7ccd237edcbce
  ```
  
  ```
  / /__/ /_/ /
\___/\__/_/
containerd CLI
USAGE:
   ctr [global options] command [command options] [arguments...]
VERSION:
   1.2.2
COMMANDS:
     plugins, plugin           provides information about containerd plugins
     version                   print the client and server versions
     containers, c, container  manage containers
     content                   manage content
     events, event             display containerd events
     images, image, i          manage images
     leases                    manage leases
     namespaces, namespace     manage namespaces
     pprof                     provide golang pprof outputs for containerd
     run                       run a container
     snapshots, snapshot       manage snapshots
     tasks, t, task            manage tasks
     install                   install a new package
     shim                      interact with a shim directly
     cri                       interact with cri plugin
     help, h                   Shows a list of commands or help for one command
GLOBAL OPTIONS:
   --debug                      enable debug output in logs
   --address value, -a value    address for containerd's GRPC server (default: "/run/containerd/containerd.sock")
   --timeout value              total timeout for ctr commands (default: 0s)
   --connect-timeout value      timeout for connecting to containerd (default: 0s)
   --namespace value, -n value  namespace to use with commands (default: "default") [$CONTAINERD_NAMESPACE]
   --help, -h                   show help
   --version, -v                print the version
  
  ```
