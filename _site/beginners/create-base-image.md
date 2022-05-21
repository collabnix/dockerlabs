
# Creating Base Docker Image


## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Play with Docker</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account with [DockerHub](https://hub.docker.com)
- Open [PWD](https://labs.play-with-docker.com/) Platform on your browser 
- Click on **Add New Instance** on the left side of the screen to bring up Alpine OS instance on the right side

## Create base Docker image using debootstrap utility.

Install debootstrap package to create minimal Debian base system.

```
$ sudo apt-get install debootstrap

Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following NEW packages will be installed:
  debootstrap
0 upgraded, 1 newly installed, 0 to remove and 1 not upgraded.
Need to get 66.5 kB of archives.
After this operation, 264 kB of additional disk space will be used.
Get:1 http://ftp.task.gda.pl/debian stretch/main amd64 debootstrap all 1.0.89 [66.5 kB]
Fetched 66.5 kB in 0s (216 kB/s) 
Selecting previously unselected package debootstrap.
(Reading database ... 47906 files and directories currently installed.)
Preparing to unpack .../debootstrap_1.0.89_all.deb ...
Unpacking debootstrap (1.0.89) ...
Processing triggers for man-db (2.7.6.1-2) ...
Setting up debootstrap (1.0.89) ...
```

## Install dirmngr to enable network operations for managing and downloading certificates.

```
$ sudo apt-get install dirmngr

Reading package lists... Done
Building dependency tree       
Reading state information... Done
Suggested packages:
  dbus-user-session pinentry-gnome3 tor
The following NEW packages will be installed:
  dirmngr
0 upgraded, 1 newly installed, 0 to remove and 1 not upgraded.
Need to get 595 kB of archives.
After this operation, 1,110 kB of additional disk space will be used.
Get:1 http://ftp.task.gda.pl/debian stretch/main amd64 dirmngr amd64 2.1.18-8~deb9u1 [595 kB]
Fetched 595 kB in 0s (1,599 kB/s)
Selecting previously unselected package dirmngr.
(Reading database ... 47969 files and directories currently installed.)
Preparing to unpack .../dirmngr_2.1.18-8~deb9u1_amd64.deb ...
Unpacking dirmngr (2.1.18-8~deb9u1) ...
Processing triggers for man-db (2.7.6.1-2) ...
Setting up dirmngr (2.1.18-8~deb9u1) ...
```

## Download and store Debian signing key in case you use different Debian-based Linux distribution.

```
$ sudo apt-key --keyring /etc/apt/trusted.gpg.d/debian-archive-stretch-stable.gpg adv --keyserver pgpkeys.mit.edu --recv-keys EF0F382A1A7B6500

Executing: /tmp/apt-key-gpghome.8RuwguajVm/gpg.1.sh --keyserver pgpkeys.mit.edu --recv-keys EF0F382A1A7B6500
gpg: key EF0F382A1A7B6500: public key "Debian Stable Release Key (9/stretch) <debian-release@lists.debian.org>" imported
gpg: Total number processed: 1
gpg:               imported: 1
```

## Create base Debian system with enabled main, contrib and non-free components. Install dirmngr and apt-transport-https packages during this process.

```
$ sudo debootstrap --keyring /etc/apt/trusted.gpg.d/debian-archive-stretch-stable.gpg --force-check-gpg --variant=minbase --components=main,contrib,non-free --include=dirmngr,apt-transport-https --arch=amd64 stretch debian-stretch http://deb.debian.org/debian/

I: Retrieving InRelease 
I: Retrieving Release 
I: Retrieving Release.gpg 
I: Checking Release signature
I: Valid Release signature (key id 067E3C456BAE240ACEE88F6FEF0F382A1A7B6500)
I: Retrieving Packages 
I: Validating Packages 
I: Retrieving Packages 
I: Validating Packages 
I: Retrieving Packages 
I: Validating Packages 
I: Resolving dependencies of required packages...
I: Resolving dependencies of base packages...
I: Found additional required dependencies: libaudit-common libaudit1 libbz2-1.0 libcap-ng0 libdb5.3 libdebconfclient0 libgcrypt20 libgpg-error0 liblz4-1 libncursesw5 libsemanage-common libsemanage1 libsystemd0 libudev1 libustr-1.0-1 
I: Found additional base dependencies: adduser debian-archive-keyring gpgv libapt-pkg5.0 libassuan0 libcurl3-gnutls libffi6 libgmp10 libgnutls30 libgssapi-krb5-2 libhogweed4 libidn11 libidn2-0 libk5crypto3 libkeyutils1 libkrb5-3 libkrb5support0 libksba8 libldap-2.4-2 libldap-common libnettle6 libnghttp2-14 libnpth0 libp11-kit0 libpsl5 librtmp1 libsasl2-2 libsasl2-modules-db libssh2-1 libstdc++6 libtasn1-6 libunistring0 
I: Checking component main on http://deb.debian.org/debian...
I: Retrieving libacl1 2.2.52-3+b1
I: Validating libacl1 2.2.52-3+b1
I: Retrieving adduser 3.115
I: Validating adduser 3.115
I: Retrieving apt 1.4.8
I: Validating apt 1.4.8
I: Retrieving apt-transport-https 1.4.8
I: Validating apt-transport-https 1.4.8
[...]
I: Chosen extractor for .deb packages: dpkg-deb
I: Extracting libacl1...
I: Extracting libattr1...
I: Extracting libaudit-common...
I: Extracting libaudit1...
[...]
I: Installing core packages...
I: Unpacking required packages...
I: Unpacking libacl1:amd64...
I: Unpacking libattr1:amd64...
I: Unpacking libaudit-common...
I: Unpacking libaudit1:amd64...
[...]
I: Configuring required packages...
I: Configuring gcc-6-base:amd64...
I: Configuring lsb-base...
I: Configuring sensible-utils...
I: Configuring ncurses-base...
[...]
I: Unpacking the base system...
I: Unpacking adduser...
I: Unpacking apt...
I: Unpacking apt-transport-https...
I: Unpacking libapt-pkg5.0:amd64...
[...]
I: Configuring the base system...
I: Configuring libnpth0:amd64...
I: Configuring libnettle6:amd64...
I: Configuring libnghttp2-14:amd64...
I: Configuring libldap-common...
[...]
I: Base system installed successfully.
```

## Initial base system size.

```
$ sudo du --human-readable --summarize debian-stretch

189M	debian-stretch
```

## Mount udev, devpts, proc and sysfs filesystems inside created base system. You can skip this step for basic operations like these performed here.

```
$ sudo mount --bind /dev     debian-stretch/dev
$ sudo mount --bind /dev/pts debian-stretch/dev/pts
$ sudo mount --bind /proc    debian-stretch/proc
$ sudo mount --bind /sys     debian-stretch/sys
```

## Change root directory.

```
$ sudo chroot debian-stretch
```

Assume yes answer for apt operations.

```
root@debian:/# echo "APT::Get::Assume-Yes \"true\";" | tee /etc/apt/apt.conf.d/10-assume_yes

APT::Get::Assume-Yes "true";
```

## Install git utility inside the base system.

```
root@debian:/# apt-get install --no-install-recommends git
```

## Remove non-essiential packages from the created base system.

```
root@debian:/# apt-get remove --allow-remove-essential e2fsprogs e2fslibs nano pinentry-curses whiptail kmod iptables iproute2 dmidecode
```

## Remove downloaded packages from local repository.

```
root@debian:/# apt-get clean
```

## Remove downloaded package lists.

```
root@debian:/# find /var/lib/apt/lists/ -maxdepth 2 -type f -delete
```

## Exit chroot environment.

```
root@debian:/# exit
```

## Detach filesystems mounted earlier inside created base system.

```
$ sudo umount debian-stretch/dev/pts
$ sudo umount debian-stretch/dev
$ sudo umount debian-stretch/proc
$ sudo umount debian-stretch/sys
```

## Base system size after performed operations.

```
$ sudo du --human-readable --summarize debian-stretch
```
188M	debian-stretch

## Create archive with Debian base system.

```
$ sudo tar --verbose --create --file debian-stretch.tar --directory debian-stretch .
```

## Archive size.

```
$ sudo du --human-readable debian-stretch.tar
```
173M	debian-stretch.tar

## Use docker to import image.

```
$ cat debian-stretch.tar | docker import - debian-stretch
```

## Create simplest possible dockerfile using nginx to test created base image.

```
$ mkdir nginx
```

```
$ cat << EOF | tee nginx/Dockerfile
FROM "debian-stretch"

RUN \\
  apt-get update && \\
  apt-get install nginx

WORKDIR /etc/nginx

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
EOF
```

```
FROM "debian-stretch"

RUN \
  apt-get update && \
  apt-get install nginx

WORKDIR /etc/nginx

CMD ["nginx", "-g", "daemon off;"]

EXPOSE 80
```

## Build an image from created dockerfile.

```
$ docker build -t nginx-test nginx

Sending build context to Docker daemon  2.048kB
Step 1/5 : FROM "debian-stretch"
 ---> aa30c1dd3f7b
Step 2/5 : RUN   apt-get update &&   apt-get install nginx
 ---> Running in 6633f8d4b8ad
Ign:1 http://cdn-fastly.deb.debian.org/debian stretch InRelease
Get:2 http://cdn-fastly.deb.debian.org/debian stretch Release [118 kB]
Get:3 http://cdn-fastly.deb.debian.org/debian stretch Release.gpg [2434 B]
Get:4 http://cdn-fastly.deb.debian.org/debian stretch/main amd64 Packages [7123 kB]
Get:5 http://cdn-fastly.deb.debian.org/debian stretch/main Translation-en [5393 kB]
Get:6 http://cdn-fastly.deb.debian.org/debian stretch/contrib amd64 Packages [50.9 kB]
Get:7 http://cdn-fastly.deb.debian.org/debian stretch/contrib Translation-en [45.9 kB]
Get:8 http://cdn-fastly.deb.debian.org/debian stretch/non-free amd64 Packages [78.0 kB]
Get:9 http://cdn-fastly.deb.debian.org/debian stretch/non-free Translation-en [79.2 kB]
Fetched 12.9 MB in 4s (2767 kB/s)
Reading package lists...
Reading package lists...
Building dependency tree...
Reading state information...
The following additional packages will be installed:
  fontconfig-config fonts-dejavu-core geoip-database libbsd0 libfontconfig1
  libfreetype6 libgd3 libgeoip1 libicu57 libjbig0 libjpeg62-turbo
  libnginx-mod-http-auth-pam libnginx-mod-http-dav-ext libnginx-mod-http-echo
  libnginx-mod-http-geoip libnginx-mod-http-image-filter
  libnginx-mod-http-subs-filter libnginx-mod-http-upstream-fair
  libnginx-mod-http-xslt-filter libnginx-mod-mail libnginx-mod-stream
  libpng16-16 libssl1.1 libtiff5 libwebp6 libx11-6 libx11-data libxau6 libxcb1
  libxdmcp6 libxml2 libxpm4 libxslt1.1 nginx-common nginx-full sgml-base ucf
  xml-core
Suggested packages:
  libgd-tools geoip-bin fcgiwrap nginx-doc ssl-cert sgml-base-doc debhelper
The following NEW packages will be installed:
  fontconfig-config fonts-dejavu-core geoip-database libbsd0 libfontconfig1
  libfreetype6 libgd3 libgeoip1 libicu57 libjbig0 libjpeg62-turbo
  libnginx-mod-http-auth-pam libnginx-mod-http-dav-ext libnginx-mod-http-echo
  libnginx-mod-http-geoip libnginx-mod-http-image-filter
  libnginx-mod-http-subs-filter libnginx-mod-http-upstream-fair
  libnginx-mod-http-xslt-filter libnginx-mod-mail libnginx-mod-stream
  libpng16-16 libssl1.1 libtiff5 libwebp6 libx11-6 libx11-data libxau6 libxcb1
  libxdmcp6 libxml2 libxpm4 libxslt1.1 nginx nginx-common nginx-full sgml-base
  ucf xml-core
0 upgraded, 39 newly installed, 0 to remove and 0 not upgraded.
Need to get 18.6 MB of archives.
After this operation, 58.9 MB of additional disk space will be used.
Get:1 http://cdn-fastly.deb.debian.org/debian stretch/main amd64 libxau6 amd64 1:1.0.8-1 [20.7 kB]
Get:2 http://cdn-fastly.deb.debian.org/debian stretch/main amd64 sgml-base all 1.29 [14.8 kB]
Get:3 http://cdn-fastly.deb.debian.org/debian stretch/main amd64 libssl1.1 amd64 1.1.0f-3+deb9u1 [1342 kB]
[...]
Fetched 18.6 MB in 4s (3877 kB/s)
Selecting previously unselected package libxau6:amd64.
(Reading database ... 9191 files and directories currently installed.)
Preparing to unpack .../00-libxau6_1%3a1.0.8-1_amd64.deb ...
Unpacking libxau6:amd64 (1:1.0.8-1) ...
Selecting previously unselected package sgml-base.
Preparing to unpack .../01-sgml-base_1.29_all.deb ...
Unpacking sgml-base (1.29) ...
Selecting previously unselected package libssl1.1:amd64.
Preparing to unpack .../02-libssl1.1_1.1.0f-3+deb9u1_amd64.deb ...
[...]
Removing intermediate container 6633f8d4b8ad
 ---> 70f98486d676
Step 3/5 : WORKDIR /etc/nginx
Removing intermediate container a6a39756a14f
 ---> be74e0f6e790
Step 4/5 : CMD ["nginx", "-g", "daemon off;"]
 ---> Running in 6cd6d572d594
Removing intermediate container 6cd6d572d594
 ---> 6d4869b43380
Step 5/5 : EXPOSE 80
 ---> Running in a60697b44e55
Removing intermediate container a60697b44e55
 ---> f565d7bbf5ba
Successfully built f565d7bbf5ba
Successfully tagged nginx-test:latest
```

## Run nginx process inside container (in foreground) using port 8080.

```
$ docker run -p 8080:80 --name nginx-test nginx-test
```

## Request and display initial welcome web-page to test it.

```
$ wget --quiet --output-document - http://$(hostname):8080

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
```

You can use different terminal to verify redirected port.

```
$ docker ps

CONTAINER ID        IMAGE               COMMAND                  CREATED              STATUS              PORTS                  NAMES
84f17e2b8467        nginx-test          "nginx -g 'daemon of…"   About a minute ago   Up About a minute   0.0.0.0:8080->80/tcp   nginx-test
```

