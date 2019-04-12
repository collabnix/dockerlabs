# Context Switching Made Simple for Swarm & Kubernetes under Docker 19.03.0 Beta1

Test Infrastructure:

- A Node with Docker 19.03.0 Beta1 installed
- 2 Docker Swarm Node Cluster(swarm-node1 and swarm-node2)
- Create 2 Node Kubernetes Cluster(GKE Cluster)


## Installing a Node with Docker 19.03.0 Beta 1 Test Build 

```

root@DebianBuster:~# curl https://get.docker.com | CHANNEL=test sh
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
100 13063  100 13063    0     0   2305      0  0:00:05  0:00:05 --:--:--  2971
# Executing docker install script, commit: 2f4ae48
+ sh -c apt-get update -qq >/dev/null
+ sh -c apt-get install -y -qq apt-transport-https ca-certificates curl >/dev/null
+ sh -c curl -fsSL "https://download.docker.com/linux/debian/gpg" | apt-key add -qq - >/dev/null
Warning: apt-key output should not be parsed (stdout is not a terminal)
+ sh -c echo "deb [arch=amd64] https://download.docker.com/linux/debian buster test" > /etc/apt/sources.list.d/docker.list
+ sh -c apt-get update -qq >/dev/null
+ [ -n  ]
+ sh -c apt-get install -y -qq --no-install-recommends docker-ce >/dev/null
+ sh -c docker version
Client:
 Version:           19.03.0-beta1
 API version:       1.40
 Go version:        go1.11.5
 Git commit:        62240a9
 Built:             Thu Apr  4 19:18:53 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          19.03.0-beta1
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.11.5
  Git commit:       62240a9
  Built:            Thu Apr  4 19:17:35 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.5
  GitCommit:        bb71b10fd8f58240ca47fbb579b9d1028eea7c84
 runc:
  Version:          1.0.0-rc6+dev
  GitCommit:        2b18fe1d885ee5083ef9f0838fee39b62d653e30
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
If you would like to use Docker as a non-root user, you should now consider
adding your user to the "docker" group with something like:

  sudo usermod -aG docker your-user

Remember that you will have to log out and back in for this to take effect!

WARNING: Adding a user to the "docker" group will grant the ability to run
         containers which can be used to obtain root privileges on the
         docker host.
         Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
         for more information.
root@DebianBuster:~#

```

## Verifying Docker version

```
root@DebianBuster:~# docker version
Client:
 Version:           19.03.0-beta1
 API version:       1.40
 Go version:        go1.11.5
 Git commit:        62240a9
 Built:             Thu Apr  4 19:18:53 2019
 OS/Arch:           linux/amd64
 Experimental:      false

Server:
 Engine:
  Version:          19.03.0-beta1
  API version:      1.40 (minimum version 1.12)
  Go version:       go1.11.5
  Git commit:       62240a9
  Built:            Thu Apr  4 19:17:35 2019
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.2.5
  GitCommit:        bb71b10fd8f58240ca47fbb579b9d1028eea7c84
 runc:
  Version:          1.0.0-rc6+dev
  GitCommit:        2b18fe1d885ee5083ef9f0838fee39b62d653e30
 docker-init:
  Version:          0.18.0
  GitCommit:        fec3683
root@DebianBuster:~#
```


