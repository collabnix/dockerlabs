---
title: "Prerequisites"
---

## 1. Docker Desktop

[Download and Install Docker Desktop](https://www.docker.com/products/docker-desktop/) on your system. Make sure you are using Docker Desktop v4.27.2 and above.

 - [Apple Chip](https://desktop.docker.com/mac/main/arm64/Docker.dmg)
 - [Intel Chip](https://desktop.docker.com/mac/main/amd64/Docker.dmg)
 - [Windows](https://desktop.docker.com/win/main/amd64/Docker%20Desktop%20Installer.exe)
 - [Linux](https://docs.docker.com/desktop/linux/install/)

### Enabling WSL 2 based engine on Docker Desktop for Windows

In case you're using Windows 11, you will need to enable WSL 2 by opening Docker Desktop > Settings > Resources > WSL Integration

![wsl2](https://github.com/ajeetraina/docker-workshop/tree/main/docs/product-catalog/images/wsl2.png)

## 2. Install Nodejs

To demonstrate the Product Catalog sample app, you will require Node 22+ version installed on your system.

> Note: You must download and install the Node pre-built installer on your local system to get the npm install command to work seamlessly. [Click here to download](https://nodejs.org/en/download/)

## 3. Access to the repositories

- [https://github.com/dockersamples/catalog-service-node](https://github.com/dockersamples/catalog-service-node) 

## 4. Access to the list of Packages

If you're behind the firewall, these are the list of packages required for this workshop:

### Docker Init Demo

```
alpine-baselayout-3.6.5-r0
alpine-baselayout-data-3.6.5-r0
alpine-keys-2.4-r1
apk-tools-2.14.4-r0
busybox-1.36.1-r29
busybox-binsh-1.36.1-r29
ca-certificates-bundle-20240705-r0
libcrypto3-3.3.2-r0
libgcc-13.2.1_git20240309-r0
libssl3-3.3.2-r0
libstdc++-13.2.1_git20240309-r0
musl-1.2.5-r0
musl-utils-1.2.5-r0
scanelf-1.3.7-r2
ssl_client-1.36.1-r29
zlib-1.3.1-r1
```

## Install Testcontainers Desktop App

[Click here](https://testcontainers.com/desktop/) to download Testcontainers Desktop app and install it on your machine.

