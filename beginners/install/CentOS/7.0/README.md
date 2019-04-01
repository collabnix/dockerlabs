# Installing Docker 18.09 on CentOS 7

## Verifying the OS

```
[root@wiki ~]# cat /etc/os-release
NAME="CentOS Linux"
VERSION="7 (Core)"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="7"
PRETTY_NAME="CentOS Linux 7 (Core)"
ANSI_COLOR="0;31"
CPE_NAME="cpe:/o:centos:centos:7"
HOME_URL="https://www.centos.org/"
BUG_REPORT_URL="https://bugs.centos.org/"

CENTOS_MANTISBT_PROJECT="CentOS-7"
CENTOS_MANTISBT_PROJECT_VERSION="7"
REDHAT_SUPPORT_PRODUCT="centos"
REDHAT_SUPPORT_PRODUCT_VERSION="7"

```

While you try to install Docker 18.09 packages using the below command:

```
curl -sSL https://get.docker.com/ | sh
```

It will throw the below error messages:


```
Error: Package: docker-ce-17.06.0.ce-1.el7.centos.x86_64 (docker-ce-stable)
           Requires: container-selinux >= 2.9
 You could try using --skip-broken to work around the problem
 You could try running: rpm -Va --nofiles --nodigest
 ```
 
 # How to troubleshoot this?
 
 Install container-selinux package from the below link:
 
```
yum install -y http://mirror.centos.org/centos/7/extras/x86_64/Packages/container-selinux-2.74-1.el7.noarch.rpm

```

```
Installed:
  container-selinux.noarch 2:2.74-1.el7        docker-ce.x86_64 3:18.09.4-3.el7

Dependency Installed:
  containerd.io.x86_64 0:1.2.5-3.1.el7       docker-ce-cli.x86_64 1:18.09.4-3.el7

Dependency Updated:
  libseccomp.x86_64 0:2.3.1-3.el7
  libselinux.x86_64 0:2.5-14.1.el7
  libselinux-python.x86_64 0:2.5-14.1.el7
  libselinux-utils.x86_64 0:2.5-14.1.el7
  libsemanage.x86_64 0:2.5-14.el7
  libsemanage-python.x86_64 0:2.5-14.el7
  libsepol.x86_64 0:2.5-10.el7
  policycoreutils.x86_64 0:2.5-29.el7
  policycoreutils-python.x86_64 0:2.5-29.el7
  selinux-policy.noarch 0:3.13.1-229.el7
  selinux-policy-targeted.noarch 0:3.13.1-229.el7
  setools-libs.x86_64 0:3.3.8-4.el7

Replaced:
  docker-engine.x86_64 0:1.13.0-1.el7.centos
  docker-engine-selinux.noarch 0:1.13.0-1.el7.centos

Complete!
[root@wiki ~]#
```

```
[root@wiki ~]# docker version
Client:
 Version:           18.09.4
 API version:       1.39
 Go version:        go1.10.8
 Git commit:        d14af54266
 Built:             Wed Mar 27 18:34:51 2019
 OS/Arch:           linux/amd64
 Experimental:      false
Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?
```

```
[root@wiki ~]# systemctl enable docker
Created symlink from /etc/systemd/system/multi-user.target.wants/docker.service to /usr/lib/systemd/system/docker.service.
```

