# Kubernetes & Jenkins on Docker for Mac 18.02 CE

Select "Minikube' under whale icon > kubernetes & run the below command:

## Start the Minikube

```
minikube start --memory 8000 --cpus 2
```

## Checking the Cluster Information

```
kubectl cluster-info
Kubernetes master is running at https://192.168.99.100:8443

To further debug and diagnose cluster problems, use 'kubectl cluster-info dump'.
[Captains-Bay]🚩 >
```



## Displaying Namespaces

```
kubectl get pods --all-namespaces
kubectl get pods --all-namespaces
NAMESPACE     NAME                                    READY     STATUS    RESTARTS   AGE

default       jenkins-774bf687f9-kwg2f                1/1       Running   0          40m

```
## Installing Jenkins using jenkins.yml, which we’ll use to create our automated CI/CD pipeline. It will take the pod a minute or two to roll out.

```
kubectl apply -f jenkins.yml
```

```
kubectl rollout status deployment/jenkins
deployment "jenkins" successfully rolled out
```

## Verify the Namespaces

```
kubectl get pods --all-namespaces
```

## Accessing the Jenkins UI in a web browser.

```
minikube service jenkins
```

## Setting up Jenkins


![Alt Text](https://github.com/ajeetraina/docker101/blob/master/play-with-kubernetes/images/jenkins1.png)

![Alt Text](https://github.com/ajeetraina/docker101/blob/master/play-with-kubernetes/images/jenkins3.png)
![Alt Text](https://github.com/ajeetraina/docker101/blob/master/play-with-kubernetes/images/jenkins4.png)


## 


```
Started by user anonymous
Building in workspace /root/.jenkins/workspace/fresht
Cloning the remote Git repository
Cloning repository https://github.com/openusm/openusm
 > git init /root/.jenkins/workspace/fresht # timeout=10
Fetching upstream changes from https://github.com/openusm/openusm
 > git --version # timeout=10
 > git fetch --tags --progress https://github.com/openusm/openusm +refs/heads/*:refs/remotes/origin/*
 > git config remote.origin.url https://github.com/openusm/openusm # timeout=10
 > git config --add remote.origin.fetch +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git config remote.origin.url https://github.com/openusm/openusm # timeout=10
Fetching upstream changes from https://github.com/openusm/openusm
 > git fetch --tags --progress https://github.com/openusm/openusm +refs/heads/*:refs/remotes/origin/*
 > git rev-parse refs/remotes/origin/master^{commit} # timeout=10
 > git rev-parse refs/remotes/origin/origin/master^{commit} # timeout=10
Checking out Revision 2fb9e3cec2610e9bed76b7ecf410e8cf3987ee59 (refs/remotes/origin/master)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 2fb9e3cec2610e9bed76b7ecf410e8cf3987ee59
Commit message: "Update README.md"
First time build. Skipping changelog.
[fresht] $ /bin/sh -xe /tmp/jenkins1576663666920900283.sh
+ DOCKER_IMAGE=ajeetraina/openusm1:1
+ docker build -t openusm1 .
Sending build context to Docker daemon 17.69 MB

Step 1/6 : FROM python:2.7
2.7: Pulling from library/python
4176fe04cefe: Pulling fs layer
851356ecf618: Pulling fs layer
6115379c7b49: Pulling fs layer
aaf7d781d601: Pulling fs layer
40cf661a3cc4: Pulling fs layer
c582f0b73e63: Pulling fs layer
6c1ea8f72a0d: Pulling fs layer
7051a41ae6b7: Pulling fs layer
aaf7d781d601: Waiting
40cf661a3cc4: Waiting
c582f0b73e63: Waiting
6c1ea8f72a0d: Waiting
7051a41ae6b7: Waiting
851356ecf618: Verifying Checksum
851356ecf618: Download complete
6115379c7b49: Verifying Checksum
6115379c7b49: Download complete
40cf661a3cc4: Download complete
4176fe04cefe: Verifying Checksum
4176fe04cefe: Download complete
6c1ea8f72a0d: Verifying Checksum
6c1ea8f72a0d: Download complete
c582f0b73e63: Verifying Checksum
c582f0b73e63: Download complete
7051a41ae6b7: Verifying Checksum
7051a41ae6b7: Download complete
4176fe04cefe: Pull complete
851356ecf618: Pull complete
6115379c7b49: Pull complete
aaf7d781d601: Verifying Checksum
aaf7d781d601: Download complete
aaf7d781d601: Pull complete
40cf661a3cc4: Pull complete
c582f0b73e63: Pull complete
6c1ea8f72a0d: Pull complete
7051a41ae6b7: Pull complete
Digest: sha256:d52278db7a8a4608e2b3c4b7a1a1eff76849542481144603bb9072512395a6d9
Status: Downloaded newer image for python:2.7
 ---> d8690ef56706
Step 2/6 : MAINTAINER "Ajeet S Raina" <Ajeet_Raina@dell.com>
 ---> Running in baf2672f3f12
 ---> 69a678ec9d7b
Removing intermediate container baf2672f3f12
Step 3/6 : RUN apt-get update -y &&     apt-get install -y git python-pip
 ---> Running in 5e8d4e3c1d60
Get:1 http://security.debian.org jessie/updates InRelease [63.1 kB]
Ign http://deb.debian.org jessie InRelease
Get:2 http://security.debian.org jessie/updates/main amd64 Packages [629 kB]
Get:3 http://deb.debian.org jessie-updates InRelease [145 kB]
Get:4 http://deb.debian.org jessie Release.gpg [2434 B]
Get:5 http://deb.debian.org jessie Release [148 kB]
Get:6 http://deb.debian.org jessie-updates/main amd64 Packages [23.1 kB]
Get:7 http://deb.debian.org jessie/main amd64 Packages [9064 kB]
Fetched 10.1 MB in 14s (685 kB/s)
Reading package lists...
Reading package lists...
Building dependency tree...
Reading state information...
git is already the newest version.
The following extra packages will be installed:
  build-essential dpkg-dev fakeroot libalgorithm-diff-perl
  libalgorithm-diff-xs-perl libalgorithm-merge-perl libdpkg-perl libfakeroot
  libfile-fcntllock-perl libtimedate-perl python-cffi python-chardet
  python-colorama python-cryptography python-distlib python-html5lib
  python-ndg-httpsclient python-openssl python-pkg-resources python-ply
  python-pyasn1 python-pycparser python-requests python-setuptools
  python-support python-urllib3 python-wheel
Suggested packages:
  debian-keyring python-dev python-cryptography-doc
  python-cryptography-vectors python-genshi python-lxml python-openssl-doc
  python-openssl-dbg python-distribute python-distribute-doc python-ply-doc
  doc-base
Recommended packages:
  python-dev-all
The following NEW packages will be installed:
  build-essential dpkg-dev fakeroot libalgorithm-diff-perl
  libalgorithm-diff-xs-perl libalgorithm-merge-perl libdpkg-perl libfakeroot
  libfile-fcntllock-perl libtimedate-perl python-cffi python-chardet
  python-colorama python-cryptography python-distlib python-html5lib
  python-ndg-httpsclient python-openssl python-pip python-pkg-resources
  python-ply python-pyasn1 python-pycparser python-requests python-setuptools
  python-support python-urllib3 python-wheel
0 upgraded, 28 newly installed, 0 to remove and 17 not upgraded.
Need to get 4495 kB of archives.
After this operation, 12.3 MB of additional disk space will be used.
Get:1 http://deb.debian.org/debian/ jessie/main python-support all 1.0.15 [33.6 kB]
Get:2 http://deb.debian.org/debian/ jessie/main libtimedate-perl all 2.3000-2 [42.2 kB]
Get:3 http://deb.debian.org/debian/ jessie/main libdpkg-perl all 1.17.27 [1075 kB]
Get:4 http://deb.debian.org/debian/ jessie/main dpkg-dev all 1.17.27 [1548 kB]
Get:5 http://deb.debian.org/debian/ jessie/main build-essential amd64 11.7 [7114 B]
Get:6 http://deb.debian.org/debian/ jessie/main libfakeroot amd64 1.20.2-1 [44.7 kB]
Get:7 http://deb.debian.org/debian/ jessie/main fakeroot amd64 1.20.2-1 [84.7 kB]
Get:8 http://deb.debian.org/debian/ jessie/main libalgorithm-diff-perl all 1.19.02-3 [51.7 kB]
Get:9 http://deb.debian.org/debian/ jessie/main libalgorithm-diff-xs-perl amd64 0.04-3+b1 [12.2 kB]
Get:10 http://deb.debian.org/debian/ jessie/main libalgorithm-merge-perl all 0.08-2 [13.5 kB]
Get:11 http://deb.debian.org/debian/ jessie/main libfile-fcntllock-perl amd64 0.22-1+b1 [36.4 kB]
Get:12 http://deb.debian.org/debian/ jessie/main python-ply all 3.4-5 [62.9 kB]
Get:13 http://deb.debian.org/debian/ jessie/main python-pycparser all 2.10+dfsg-3 [58.8 kB]
Get:14 http://deb.debian.org/debian/ jessie/main python-cffi amd64 0.8.6-1 [67.2 kB]
Get:15 http://deb.debian.org/debian/ jessie/main python-pkg-resources all 5.5.1-1 [64.4 kB]
Get:16 http://deb.debian.org/debian/ jessie/main python-chardet all 2.3.0-1 [96.2 kB]
Get:17 http://deb.debian.org/debian/ jessie/main python-colorama all 0.3.2-1 [20.3 kB]
Get:18 http://deb.debian.org/debian/ jessie/main python-cryptography amd64 0.6.1-1+deb8u1 [164 kB]
Get:19 http://deb.debian.org/debian/ jessie/main python-distlib all 0.1.9-1 [113 kB]
Get:20 http://deb.debian.org/debian/ jessie/main python-html5lib all 0.999-3 [84.0 kB]
Get:21 http://deb.debian.org/debian/ jessie/main python-openssl all 0.14-1 [81.1 kB]
Get:22 http://deb.debian.org/debian/ jessie/main python-ndg-httpsclient all 0.3.2-1 [20.5 kB]
Get:23 http://deb.debian.org/debian/ jessie/main python-urllib3 all 1.9.1-3 [55.4 kB]
Get:24 http://deb.debian.org/debian/ jessie/main python-requests all 2.4.3-6 [204 kB]
Get:25 http://deb.debian.org/debian/ jessie/main python-setuptools all 5.5.1-1 [242 kB]
Get:26 http://deb.debian.org/debian/ jessie/main python-pip all 1.5.6-5 [114 kB]
Get:27 http://deb.debian.org/debian/ jessie/main python-pyasn1 all 0.1.7-1 [49.3 kB]
Get:28 http://deb.debian.org/debian/ jessie/main python-wheel all 0.24.0-1 [47.5 kB]
[91mdebconf: delaying package configuration, since apt-utils is not installed
[0mFetched 4495 kB in 7s (565 kB/s)
Selecting previously unselected package python-support.
(Reading database ... 
(Reading database ... 5%
(Reading database ... 10%
(Reading database ... 15%
(Reading database ... 20%
(Reading database ... 25%
(Reading database ... 30%
(Reading database ... 35%
(Reading database ... 40%
(Reading database ... 45%
(Reading database ... 50%
(Reading database ... 55%
(Reading database ... 60%
(Reading database ... 65%
(Reading database ... 70%
(Reading database ... 75%
(Reading database ... 80%
(Reading database ... 85%
(Reading database ... 90%
(Reading database ... 95%
(Reading database ... 100%
(Reading database ... 21636 files and directories currently installed.)
Preparing to unpack .../python-support_1.0.15_all.deb ...
Unpacking python-support (1.0.15) ...
Selecting previously unselected package libtimedate-perl.
Preparing to unpack .../libtimedate-perl_2.3000-2_all.deb ...
Unpacking libtimedate-perl (2.3000-2) ...
Selecting previously unselected package libdpkg-perl.
Preparing to unpack .../libdpkg-perl_1.17.27_all.deb ...
Unpacking libdpkg-perl (1.17.27) ...
Selecting previously unselected package dpkg-dev.
Preparing to unpack .../dpkg-dev_1.17.27_all.deb ...
Unpacking dpkg-dev (1.17.27) ...
Selecting previously unselected package build-essential.
Preparing to unpack .../build-essential_11.7_amd64.deb ...
Unpacking build-essential (11.7) ...
Selecting previously unselected package libfakeroot:amd64.
Preparing to unpack .../libfakeroot_1.20.2-1_amd64.deb ...
Unpacking libfakeroot:amd64 (1.20.2-1) ...
Selecting previously unselected package fakeroot.
Preparing to unpack .../fakeroot_1.20.2-1_amd64.deb ...
Unpacking fakeroot (1.20.2-1) ...
Selecting previously unselected package libalgorithm-diff-perl.
Preparing to unpack .../libalgorithm-diff-perl_1.19.02-3_all.deb ...
Unpacking libalgorithm-diff-perl (1.19.02-3) ...
Selecting previously unselected package libalgorithm-diff-xs-perl.
Preparing to unpack .../libalgorithm-diff-xs-perl_0.04-3+b1_amd64.deb ...
Unpacking libalgorithm-diff-xs-perl (0.04-3+b1) ...
Selecting previously unselected package libalgorithm-merge-perl.
Preparing to unpack .../libalgorithm-merge-perl_0.08-2_all.deb ...
Unpacking libalgorithm-merge-perl (0.08-2) ...
Selecting previously unselected package libfile-fcntllock-perl.
Preparing to unpack .../libfile-fcntllock-perl_0.22-1+b1_amd64.deb ...
Unpacking libfile-fcntllock-perl (0.22-1+b1) ...
Selecting previously unselected package python-ply.
Preparing to unpack .../python-ply_3.4-5_all.deb ...
Unpacking python-ply (3.4-5) ...
Selecting previously unselected package python-pycparser.
Preparing to unpack .../python-pycparser_2.10+dfsg-3_all.deb ...
Unpacking python-pycparser (2.10+dfsg-3) ...
Selecting previously unselected package python-cffi.
Preparing to unpack .../python-cffi_0.8.6-1_amd64.deb ...
Unpacking python-cffi (0.8.6-1) ...
Selecting previously unselected package python-pkg-resources.
Preparing to unpack .../python-pkg-resources_5.5.1-1_all.deb ...
Unpacking python-pkg-resources (5.5.1-1) ...
Selecting previously unselected package python-chardet.
Preparing to unpack .../python-chardet_2.3.0-1_all.deb ...
Unpacking python-chardet (2.3.0-1) ...
Selecting previously unselected package python-colorama.
Preparing to unpack .../python-colorama_0.3.2-1_all.deb ...
Unpacking python-colorama (0.3.2-1) ...
Selecting previously unselected package python-cryptography.
Preparing to unpack .../python-cryptography_0.6.1-1+deb8u1_amd64.deb ...
Unpacking python-cryptography (0.6.1-1+deb8u1) ...
Selecting previously unselected package python-distlib.
Preparing to unpack .../python-distlib_0.1.9-1_all.deb ...
Unpacking python-distlib (0.1.9-1) ...
Selecting previously unselected package python-html5lib.
Preparing to unpack .../python-html5lib_0.999-3_all.deb ...
Unpacking python-html5lib (0.999-3) ...
Selecting previously unselected package python-openssl.
Preparing to unpack .../python-openssl_0.14-1_all.deb ...
Unpacking python-openssl (0.14-1) ...
Selecting previously unselected package python-ndg-httpsclient.
Preparing to unpack .../python-ndg-httpsclient_0.3.2-1_all.deb ...
Unpacking python-ndg-httpsclient (0.3.2-1) ...
Selecting previously unselected package python-urllib3.
Preparing to unpack .../python-urllib3_1.9.1-3_all.deb ...
Unpacking python-urllib3 (1.9.1-3) ...
Selecting previously unselected package python-requests.
Preparing to unpack .../python-requests_2.4.3-6_all.deb ...
Unpacking python-requests (2.4.3-6) ...
Selecting previously unselected package python-setuptools.
Preparing to unpack .../python-setuptools_5.5.1-1_all.deb ...
Unpacking python-setuptools (5.5.1-1) ...
Selecting previously unselected package python-pip.
Preparing to unpack .../python-pip_1.5.6-5_all.deb ...
Unpacking python-pip (1.5.6-5) ...
Selecting previously unselected package python-pyasn1.
Preparing to unpack .../python-pyasn1_0.1.7-1_all.deb ...
Unpacking python-pyasn1 (0.1.7-1) ...
Selecting previously unselected package python-wheel.
Preparing to unpack .../python-wheel_0.24.0-1_all.deb ...
Unpacking python-wheel (0.24.0-1) ...
Setting up python-support (1.0.15) ...
Setting up libtimedate-perl (2.3000-2) ...
Setting up libdpkg-perl (1.17.27) ...
Setting up dpkg-dev (1.17.27) ...
Setting up build-essential (11.7) ...
Setting up libfakeroot:amd64 (1.20.2-1) ...
Setting up fakeroot (1.20.2-1) ...
update-alternatives: using /usr/bin/fakeroot-sysv to provide /usr/bin/fakeroot (fakeroot) in auto mode
Setting up libalgorithm-diff-perl (1.19.02-3) ...
Setting up libalgorithm-diff-xs-perl (0.04-3+b1) ...
Setting up libalgorithm-merge-perl (0.08-2) ...
Setting up libfile-fcntllock-perl (0.22-1+b1) ...
Setting up python-ply (3.4-5) ...
Setting up python-pycparser (2.10+dfsg-3) ...
Setting up python-cffi (0.8.6-1) ...
Setting up python-pkg-resources (5.5.1-1) ...
Setting up python-chardet (2.3.0-1) ...
Setting up python-colorama (0.3.2-1) ...
Setting up python-cryptography (0.6.1-1+deb8u1) ...
Setting up python-distlib (0.1.9-1) ...
Setting up python-html5lib (0.999-3) ...
Setting up python-openssl (0.14-1) ...
Setting up python-ndg-httpsclient (0.3.2-1) ...
Setting up python-urllib3 (1.9.1-3) ...
Setting up python-requests (2.4.3-6) ...
Setting up python-setuptools (5.5.1-1) ...
Setting up python-pip (1.5.6-5) ...
Setting up python-pyasn1 (0.1.7-1) ...
Setting up python-wheel (0.24.0-1) ...
Processing triggers for python-support (1.0.15) ...
 ---> fb1d61b7a2b7
Removing intermediate container 5e8d4e3c1d60
Step 4/6 : RUN pip install requests
 ---> Running in fdda82dee355
Collecting requests
  Downloading requests-2.18.4-py2.py3-none-any.whl (88kB)
Collecting idna<2.7,>=2.5 (from requests)
  Downloading idna-2.6-py2.py3-none-any.whl (56kB)
Collecting urllib3<1.23,>=1.21.1 (from requests)
  Downloading urllib3-1.22-py2.py3-none-any.whl (132kB)
Collecting certifi>=2017.4.17 (from requests)
  Downloading certifi-2018.1.18-py2.py3-none-any.whl (151kB)
Collecting chardet<3.1.0,>=3.0.2 (from requests)
  Downloading chardet-3.0.4-py2.py3-none-any.whl (133kB)
Installing collected packages: idna, urllib3, certifi, chardet, requests
Successfully installed certifi-2018.1.18 chardet-3.0.4 idna-2.6 requests-2.18.4 urllib3-1.22
 ---> b2cf38a37ceb
Removing intermediate container fdda82dee355
Step 5/6 : ADD . /redfish
 ---> 573ec48688ca
Step 6/6 : WORKDIR /redfish
 ---> 287f29d0e5b6
Removing intermediate container a59411874c24
Successfully built 287f29d0e5b6
Successfully tagged openusm1:latest
+ docker tag openusm1 ajeetraina/openusm1:1
+ docker push ajeetraina/openusm1:1
```
