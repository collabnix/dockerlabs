# Is Docker technology the same as traditional Linux containers?

No. Docker technology was initially built on top of the LXC technology—what most people associate with "traditional” Linux containers—though it’s since moved away from that dependency. LXC was useful as lightweight virtualization, but it didn’t have a great developer or user experience. The Docker technology brings more than the ability to run containers—it also eases the process of creating and building containers, shipping images, and versioning of images (among other things).

![MyImage](https://github.com/collabnix/dockerlabs/blob/master/beginners/docker/images/traditional-linux-containers-vs-docker_0.png)

Traditional Linux containers use an init system that can manage multiple processes. This means entire applications can run as one. The Docker technology encourages applications to be broken down into their separate processes and provides the tools to do that. This granular approach has its advantages.

[Proceed > What are Containers? ](https://github.com/collabnix/dockerlabs/blob/master/beginners/linux-containers.md)
