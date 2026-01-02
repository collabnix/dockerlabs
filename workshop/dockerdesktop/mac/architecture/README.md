![Untitled-2022-07-04-2005](https://user-images.githubusercontent.com/313480/212122319-d6cbd117-35e3-4ee6-a452-f9d7d5b2c702.png)


- Docker uses containerd under the hood to run containers
- Containerd is a container runtime that manages the lifecycle of a container on a physical or virtual machine (a host)
- It manages the complete container lifecycle of its host system! 
- This includes pulling and pushing images as well as handling the starting and stopping of containers. 


```
$ docker run --name web -p 80:80 -d nginx
```

- Docker CLI understands what we want to do, and then sends instructions to containerd.
- containerd does its magic, downloads the nginx image if it's not available.
- Next, containerd tells runc to start this container
- And we finally get our result: nginx running in a little isolated container box.

