
## How to troubleshooting APKINDEX error while building Dockerfile for Alpine Linux

Scenerio:

You might encounter the below error message while you build Docker container using Alpine Linux OS.


```
ERROR: http://dl-cdn.alpinelinux.org/alpine/v3.8/main: temporary error (try again later)
WARNING: Ignoring APKINDEX.adfa7ceb.tar.gz: No such file or directory
ERROR: http://dl-cdn.alpinelinux.org/alpine/v3.8/community: temporary error (try again later)
WARNING: Ignoring APKINDEX.efaa1f73.tar.gz: No such file or directory
```

## How to fix it?

You need to add DNS entry for your Docker containers to fetch theb packages:

```
create/edit file/etc/docker/daemon.json
And add in it text:
{
"dns": ["8.8.8.8", "8.8.8.4"]
}

```
