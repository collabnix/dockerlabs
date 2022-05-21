# How to install Docker 18.09.0 on Raspberry Pi 3



## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Raspberry Pi 3</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite


- Flash Raspbian OS on SD card

If you are in Mac, you might need to install Etcher tool. If on Windows, install SDFormatter to format SD card as well as Win32installer to flash Raspbian ISO image onto the SD card. You will need SD card reader to achieve this.


## Booting up Raspbian OS

Just use the same charger which you use for your mobile to power on Raspberry Pi box. Connect HDMI port to your TV or display. Let it boot up.


The default username is pi and password is raspberry.


### Enable SSH to perform remote login

To login via your laptop, you need to allow SSH service running. You can verify IP address command via ifconfig command.

```
[Captains-Bay]🚩 >  ssh pi@192.168.1.5
pi@192.168.1.5's password:
Linux raspberrypi 4.14.98-v7+ #1200 SMP Tue Feb 12 20:27:48 GMT 2019 armv7l

The programs included with the Debian GNU/Linux system are free software;
the exact distribution terms for each program are described in the
individual files in /usr/share/doc/*/copyright.

Debian GNU/Linux comes with ABSOLUTELY NO WARRANTY, to the extent
permitted by applicable law.
Last login: Tue Feb 26 12:30:00 2019 from 192.168.1.4
pi@raspberrypi:~ $ sudo su
root@raspberrypi:/home/pi# cd
```

## Verifying Raspbian OS Version


```
root@raspberrypi:~# cat /etc/os-release
PRETTY_NAME="Raspbian GNU/Linux 9 (stretch)"
NAME="Raspbian GNU/Linux"
VERSION_ID="9"
VERSION="9 (stretch)"
ID=raspbian
ID_LIKE=debian
HOME_URL="http://www.raspbian.org/"
SUPPORT_URL="http://www.raspbian.org/RaspbianForums"
BUG_REPORT_URL="http://www.raspbian.org/RaspbianBugs"
root@raspberrypi:~#
```

## Installing Docker 18.09

Its a single liner command. -L means location, -s means silent and -S means show error.

```
root@raspberrypi:~# curl -sSL https://get.docker.com/ | sh
# Executing docker install script, commit: 40b1b76
+ sh -c apt-get update -qq >/dev/null
+ sh -c apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
+ sh -c curl -fsSL "https://download.docker.com/linux/raspbian/gpg" | apt-key add -qq - >/dev/null
Warning: apt-key output should not be parsed (stdout is not a terminal)
+ sh -c echo "deb [arch=armhf] https://download.docker.com/linux/raspbian stretch edge" > /etc/apt/sources.list.d/docker.list
+ sh -c apt-get update -qq >/dev/null
+ sh -c apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
+ sh -c docker version
Client:
 Version:           18.09.0
 API version:       1.39
 Go version:        go1.10.4
 Git commit:        4d60db4
 Built:             Wed Nov  7 00:57:21 2018
 OS/Arch:           linux/arm
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.0
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       4d60db4
  Built:            Wed Nov  7 00:17:57 2018
  OS/Arch:          linux/arm
  Experimental:     false
If you would like to use Docker as a non-root user, you should now consider
adding your user to the "docker" group with something like:

  sudo usermod -aG docker your-user

Remember that you will have to log out and back in for this to take effect!

WARNING: Adding a user to the "docker" group will grant the ability to run
         containers which can be used to obtain root privileges on the
         docker host.
         Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
         for more information.

** DOCKER ENGINE - ENTERPRISE **

If you’re ready for production workloads, Docker Engine - Enterprise also includes:

  * SLA-backed technical support
  * Extended lifecycle maintenance policy for patches and hotfixes
  * Access to certified ecosystem content

** Learn more at https://dockr.ly/engine2 **

ACTIVATE your own engine to Docker Engine - Enterprise using:

  sudo docker engine activate

```

## Verifying Docker Version

```
root@raspberrypi:~# docker version
Client:
 Version:           18.09.0
 API version:       1.39
 Go version:        go1.10.4
 Git commit:        4d60db4
 Built:             Wed Nov  7 00:57:21 2018
 OS/Arch:           linux/arm
 Experimental:      false

Server: Docker Engine - Community
 Engine:
  Version:          18.09.0
  API version:      1.39 (minimum version 1.12)
  Go version:       go1.10.4
  Git commit:       4d60db4
  Built:            Wed Nov  7 00:17:57 2018
  OS/Arch:          linux/arm
  Experimental:     false
root@raspberrypi:~#
```


## Deploying Nginx App

```
root@raspberrypi:~# docker run -d -p 80:80 nginx
Unable to find image 'nginx:latest' locally
latest: Pulling from library/nginx
9c38b5a8a4d5: Pull complete
1c9b1b3e1e0d: Pull complete
258951b5612f: Pull complete
Digest: sha256:dd2d0ac3fff2f007d99e033b64854be0941e19a2ad51f174d9240dda20d9f534
Status: Downloaded newer image for nginx:latest
d812bf50d136b0f78353f0a0c763b6b08ecc5e7ce706bac8bd660cdd723e0fcd
root@raspberrypi:~#
```

## 

```
root@raspberrypi:~# curl localhost:80
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
<style>
    body {
        width: 35em;
        margin: 0 auto;
        font-family: Tahoma, Verdana, Arial, sans-serif;
    }
</style>
</head>
<body>
<h1>Welcome to nginx!</h1>
<p>If you see this page, the nginx web server is successfully installed and
working. Further configuration is required.</p>

<p>For online documentation and support please refer to
<a href="http://nginx.org/">nginx.org</a>.<br/>
Commercial support is available at
<a href="http://nginx.com/">nginx.com</a>.</p>

<p><em>Thank you for using nginx.</em></p>
</body>
</html>
root@raspberrypi:~#
```

## 

```
root@raspberrypi:~# docker info
Containers: 1
 Running: 1
 Paused: 0
 Stopped: 0
Images: 1
Server Version: 18.09.0
Storage Driver: overlay2
 Backing Filesystem: extfs
 Supports d_type: true
 Native Overlay Diff: true
Logging Driver: json-file
Cgroup Driver: cgroupfs
Plugins:
 Volume: local
 Network: bridge host macvlan null overlay
 Log: awslogs fluentd gcplogs gelf journald json-file local logentries splunk syslog
Swarm: inactive
Runtimes: runc
Default Runtime: runc
Init Binary: docker-init
containerd version: 9754871865f7fe2f4e74d43e2fc7ccd237edcbce
runc version: 09c8266bf2fcf9519a651b04ae54c967b9ab86ec
init version: fec3683
Security Options:
 seccomp
  Profile: default
Kernel Version: 4.14.98-v7+
Operating System: Raspbian GNU/Linux 9 (stretch)
OSType: linux
Architecture: armv7l
CPUs: 4
Total Memory: 927.2MiB
Name: raspberrypi
ID: FEUI:RVU6:AWPZ:6P22:TSLT:FDJC:CBIB:D2NU:AQEQ:IHVH:HFRY:HYWF
Docker Root Dir: /var/lib/docker
Debug Mode (client): false
Debug Mode (server): false
Registry: https://index.docker.io/v1/
Labels:
Experimental: false
Insecure Registries:
 127.0.0.0/8
Live Restore Enabled: false
Product License: Community Engine

WARNING: No memory limit support
WARNING: No swap limit support
WARNING: No kernel memory limit support
WARNING: No oom kill disable support
WARNING: No cpu cfs quota support
WARNING: No cpu cfs period support
```

## Building up Nginx App



## BuildKit on Raspberry Pi

```
root@raspberrypi:~# export DOCKER_BUILDKIT=1
root@raspberrypi:~# git clone https://github.com/ajeetraina/hellowhale
Cloning into 'hellowhale'...
remote: Enumerating objects: 28, done.
remote: Total 28 (delta 0), reused 0 (delta 0), pack-reused 28
Unpacking objects: 100% (28/28), done.
root@raspberrypi:~# cd hellowhale/
root@raspberrypi:~/hellowhale# ls
Dockerfile  html  README.md  wrapper.sh
root@raspberrypi:~/hellowhale# docker build -t ajeetraina/hellowhalecom .
[+] Building 7.9s (5/8)                                                         
 => [internal] load build definition from Dockerfile                       0.1s
 => => transferring dockerfile: 129B                                       0.0s
 => [internal] load .dockerignore                                          0.2s
 => => transferring context: 2B                                            0.0s
 => [internal] load metadata for docker.io/library/nginx:latest            0.0s
 => [1/3] FROM docker.io/library/nginx:latest                              0.0s
 => => resolve docker.io/library/nginx:latest                              0.0s
 => [internal] helper image for file operations                            0.1s
 => => resolve docker.io/docker/dockerfile-copy:v0.1.9@sha256:e8f159d3f00  7.5s
 => => sha256:b13ecc473b58ad8d80fba73ae6de690f6fcbe341bdaca42 736B / 736B  0.0s
 => => sha256:fabe16b757ee155dfd7210795199962d1b35e22b3437d06 767B / 767B  0.0s
 => [internal] load build context                                          0.1s
 => => transferring context: 34.39kB                                       0.0s

```

```
root@raspberrypi:~/hellowhale# time docker build -t ajeetraina/hellowhale .
[+] Building 0.4s (9/9) FINISHED                                                
 => [internal] load build definition from Dockerfile                       0.1s
 => => transferring dockerfile: 31B                                        0.0s
 => [internal] load .dockerignore                                          0.1s
 => => transferring context: 2B                                            0.0s
 => [internal] load metadata for docker.io/library/nginx:latest            0.0s
 => [internal] helper image for file operations                            0.0s
 => [1/3] FROM docker.io/library/nginx:latest                              0.0s
 => [internal] load build context                                          0.0s
 => => transferring context: 317B                                          0.0s
 => CACHED [2/3] COPY wrapper.sh /                                         0.0s
 => CACHED [3/3] COPY html /usr/share/nginx/html                           0.0s
 => exporting to image                                                     0.1s
 => => exporting layers                                                    0.0s
 => => writing image sha256:5aee990f7e24e7c0f486ed01b4c1f8696ff307f836af1  0.0s
 => => naming to docker.io/ajeetraina/hellowhale                           0.0s

real	0m0.615s
user	0m0.204s
sys	0m0.082s
```

## Verifying Dockerd


```
root@raspberrypi:~/hellowhale# systemctl status docker
● docker.service - Docker Application Container Engine
   Loaded: loaded (/lib/systemd/system/docker.service; enabled; vendor preset: e
   Active: active (running) since Tue 2019-02-26 13:01:04 IST; 38min ago
     Docs: https://docs.docker.com
 Main PID: 2437 (dockerd)
      CPU: 1min 46.174s
   CGroup: /system.slice/docker.service
           ├─2437 /usr/bin/dockerd -H unix://
           ├─2705 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 8
           └─4186 /usr/bin/docker-proxy -proto tcp -host-ip 0.0.0.0 -host-port 8

Feb 26 13:37:06 raspberrypi dockerd[2437]: time="2019-02-26T13:37:06.400368104+0
Feb 26 13:37:06 raspberrypi dockerd[2437]: time="2019-02-26T13:37:06.402012958+0
Feb 26 13:37:06 raspberrypi dockerd[2437]: time="2019-02-26T13:37:06.402634316+0
Feb 26 13:37:06 raspberrypi dockerd[2437]: time="2019-02-26T13:37:06.403005881+0
Feb 26 13:37:06 raspberrypi dockerd[2437]: time="2019-02-26T13:37:06.408358205+0
Feb 26 13:37:06 raspberrypi dockerd[2437]: time="2019-02-26T13:37:06.810154786+0
Feb 26 13:37:06 raspberrypi dockerd[2437]: time="2019-02-26T13:37:06.810334839+0
Feb 26 13:37:06 raspberrypi dockerd[2437]: time="2019-02-26T13:37:06.811462659+0
Feb 26 13:37:06 raspberrypi dockerd[2437]: time="2019-02-26T13:37:06.811768546+0
Feb 26 13:37:07 raspberrypi dockerd[2437]: time="2019-02-26T13:37:07.402282796+0
```


## Verifying if armv7 hello-world image is available or not

```
docker run --rm mplatform/mquery hello-world
Unable to find image 'mplatform/mquery:latest' locally
latest: Pulling from mplatform/mquery
db6020507de3: Pull complete
5107afd39b7f: Pull complete
Digest: sha256:e15189e3d6fbcee8a6ad2ef04c1ec80420ab0fdcf0d70408c0e914af80dfb107
Status: Downloaded newer image for mplatform/mquery:latest
Image: hello-world
 * Manifest List: Yes
 * Supported platforms:
   - linux/amd64
   - linux/arm/v5
   - linux/arm/v7
   - linux/arm64
   - linux/386
   - linux/ppc64le
   - linux/s390x
   - windows/amd64:10.0.14393.2551
   - windows/amd64:10.0.16299.846
   - windows/amd64:10.0.17134.469
   - windows/amd64:10.0.17763.194
```


## Verifying hellowhale Image 

```
root@raspberrypi:~# docker run --rm mplatform/mquery ajeetraina/hellowhale
Image: ajeetraina/hellowhale
 * Manifest List: No
 * Supports: amd64/linux
````

## Verifying Random Images

```
root@raspberrypi:~# docker run --rm mplatform/mquery rycus86/prometheus
Image: rycus86/prometheus
 * Manifest List: Yes
 * Supported platforms:
   - linux/amd64
   - linux/arm/v7
   - linux/arm64
```

[Next >> Setting up Docker Swarm Cluster on Rasperry Pi](https://github.com/collabnix/dockerlabs/blob/master/beginners/install/raspberrypi3/setting-up-swarm-cluster.md)

