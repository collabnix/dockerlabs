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
  
  # Verifying Docker packages
  
Please Note: The client and container runtime are now in separate packages from the daemon in Docker Engine 18.09. Users should install and update all three packages at the same time to get the latest patch releases. For example, on Ubuntu: sudo apt install docker-ce docker-ce-cli containerd.io. See the install instructions for the corresponding linux distro for details
  
  ```
  $ sudo dpkg --list | grep container
ii  containerd.io                  1.2.2-3                             amd64        An open and reliable container runtime
ii  docker-ce                      5:18.09.2~3-0~ubuntu-cosmic         amd64        Docker: the open-source application container engine
ii  docker-ce-cli                  5:18.09.2~3-0~ubuntu-cosmic         amd64        Docker CLI: the open-source application container engine
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



```
systemctl status docker.service
● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: enabled)
   Active: active (running) since Wed 2019-02-13 14:28:00 UTC; 17min ago
     Docs: https://docs.docker.com
 Main PID: 4743 (dockerd)
    Tasks: 8
   Memory: 30.5M
   CGroup: /system.slice/docker.service
           └─4743 /usr/bin/dockerd -H fd://

Feb 13 14:27:58 node2 dockerd[4743]: time="2019-02-13T14:27:58.450228348Z" level=warning msg="Your kernel does not support swa
Feb 13 14:27:58 node2 dockerd[4743]: time="2019-02-13T14:27:58.450475526Z" level=warning msg="Your kernel does not support cgr
Feb 13 14:27:58 node2 dockerd[4743]: time="2019-02-13T14:27:58.450589830Z" level=warning msg="Your kernel does not support cgr
Feb 13 14:27:58 node2 dockerd[4743]: time="2019-02-13T14:27:58.451457667Z" level=info msg="Loading containers: start."
Feb 13 14:27:59 node2 dockerd[4743]: time="2019-02-13T14:27:59.005085922Z" level=info msg="Default bridge (docker0) is assigne
Feb 13 14:27:59 node2 dockerd[4743]: time="2019-02-13T14:27:59.104795847Z" level=info msg="Loading containers: done."
Feb 13 14:28:00 node2 dockerd[4743]: time="2019-02-13T14:28:00.549086174Z" level=info msg="Docker daemon" commit=6247962 graph
Feb 13 14:28:00 node2 dockerd[4743]: time="2019-02-13T14:28:00.550147741Z" level=info msg="Daemon has completed initialization
Feb 13 14:28:00 node2 systemd[1]: Started Docker Application Container Engine.
Feb 13 14:28:00 node2 dockerd[4743]: time="2019-02-13T14:28:00.592676303Z" level=info msg="API listen on /var/run/docker.sock"
```

# Comparing `docker build` VS Buildkit

```
$ git clone https://github.com/ajeetraina/hellowhale
Cloning into 'hellowhale'...
remote: Enumerating objects: 28, done.
remote: Total 28 (delta 0), reused 0 (delta 0), pack-reused 28
Unpacking objects: 100% (28/28), done.
```
```
~$ cd hellowhale/
~$ ls
Dockerfile  README.md  html  wrapper.sh
```

```
:~/hellowhale$ time docker build -t ajeetraina/hellowhale .
Sending build context to Docker daemon  153.1kB
Step 1/4 : FROM nginx:latest
latest: Pulling from library/nginx
6ae821421a7d: Pull complete 
da4474e5966c: Pull complete 
eb2aec2b9c9f: Pull complete 
Digest: sha256:dd2d0ac3fff2f007d99e033b64854be0941e19a2ad51f174d9240dda20d9f534
Status: Downloaded newer image for nginx:latest
 ---> f09fe80eb0e7
Step 2/4 : COPY wrapper.sh /
 ---> 10d671c6cf08
Step 3/4 : COPY html /usr/share/nginx/html
 ---> 3e8a09f56168
Step 4/4 : CMD ["./wrapper.sh"]
 ---> Running in b1f24992f9e5
Removing intermediate container b1f24992f9e5
 ---> 9dae85ca0867
Successfully built 9dae85ca0867
Successfully tagged ajeetraina/hellowhale:latest
real    0m6.359s
user    0m0.035s
sys     0m0.022s

```

Let's build it with buildkit

```
 time docker build -t ajeetraina/hellowhale .
[+] Building 1.7s (9/9) FINISHED                                                                                                                                                 
 => [internal] load build definition from Dockerfile                                                                                                                        0.1s
 => => transferring dockerfile: 135B                                                                                                                                        0.0s
 => [internal] load .dockerignore                                                                                                                                           0.0s
 => => transferring context: 2B                                                                                                                                             0.0s
 => [internal] load metadata for docker.io/library/nginx:latest                                                                                                             0.0s
 => [internal] helper image for file operations                                                                                                                             0.4s
 => => resolve docker.io/docker/dockerfile-copy:v0.1.9@sha256:e8f159d3f00786604b93c675ee2783f8dc194bb565e61ca5788f6a6e9d304061                                              0.7s
 => => sha256:e8f159d3f00786604b93c675ee2783f8dc194bb565e61ca5788f6a6e9d304061 2.03kB / 2.03kB                                                                              0.0s
 => => sha256:a546a4352bcaa6512f885d24fef3d9819e70551b98535ed1995e4b567ac6d05b 736B / 736B                                                                                  0.0s
 => => sha256:494e63343c3f0d392e7af8d718979262baec9496a23e97ad110d62b9c90d6182 766B / 766B                                                                                  0.0s
 => => sha256:df3b4bed1f63b36992540a09e0d10bd3f9d0b082d50810313841d745d7cce368 898.21kB / 898.21kB                                                                          0.2s
 => => sha256:f7b6696c3fee7264ec4486cebe146a6a98aa8d1e46747843107ff473aada8d56 861.00kB / 861.00kB                                                                          0.2s
 => => extracting sha256:df3b4bed1f63b36992540a09e0d10bd3f9d0b082d50810313841d745d7cce368                                                                                   0.1s
 => => extracting sha256:f7b6696c3fee7264ec4486cebe146a6a98aa8d1e46747843107ff473aada8d56                                                                                   0.1s
 => [1/3] FROM docker.io/library/nginx:latest                                                                                                                               0.0s
 => => resolve docker.io/library/nginx:latest                                                                                                                               0.0s
 => [internal] load build context                                                                                                                                           0.0s
 => => transferring context: 34.39kB                                                                                                                                        0.0s
 => [2/3] COPY wrapper.sh /                                                                                                                                                 0.2s
 => [3/3] COPY html /usr/share/nginx/html                                                                                                                                   0.2s
 => exporting to image                                                                                                                                                      0.1s
 => => exporting layers                                                                                                                                                     0.0s
 => => writing image sha256:db60ac4c90d7412b8c9f9382711f0d97a9ad9d4a33c05200aa36dc4c935c8cb3                                                                                0.0s
 => => naming to docker.io/ajeetraina/hellowhale                                                                                                                            0.0s
real    0m1.732s
user    0m0.042s
sys     0m0.019s
~/hellowhale$
```

```
FROM debian
EXPOSE 80
RUN apt update && apt install git

```

```
Added support for build-time secrets using a --secret flag when using BuildKit docker/cli#1288
Added builder prune subcommand to prune BuildKit build cache docker/cli#1295docker/cli#1334
BuildKit: Adds configurable garbage collection policy for the BuildKit build cache docker/engine#59 / moby/moby#37846
BuildKit: Adds support for docker build --pull ... when using BuildKit moby/moby#37613
BuildKit: Adds support or “registry-mirrors” and “insecure-registries” when using BuildKit docker/engine#59 / moby/moby#37852
BuildKit: Enables net modes and bridge. moby/moby#37620
BuildKit: Changes --console=[auto,false,true] to --progress=[auto,plain,tty]docker/cli#1276
BuildKit: Sets BuildKit’s ExportedProduct variable to show useful errors in the future. moby/moby#37439﻿
```

```
docker run --isolation=process mcr.microsoft.com/windows/nanoserver:1809 cmd.exe /c ping 127.0.0.1 -t
```

```
$ docker -H ssh://ajeetraina@10.94.26.28 run -ti ubuntu echo “hello”
Unable to find image 'ubuntu:latest' locally
latest: Pulling from library/ubuntu
6cf436f81810: Pull complete 
987088a85b96: Pull complete 
b4624b3efe06: Pull complete 
d42beb8ded59: Pull complete 
Digest: sha256:7a47ccc3bbe8a451b500d2b53104868b46d60ee8f5b35a24b41a86077c650210
```

