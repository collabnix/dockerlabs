# Top Reasons why to run Docker containers on Bare Metal System

Containers on bare-metal hosts get many of the advantages VMs offer but without the drawbacks of virtualization:

- Gain access to bare-metal hardware in apps without relying on pass-through techniques, because the app processes run on the same OS as 
the host server.
- Have optimal use of system resources. Although you can set limits on how much compute, storage and networking containers can use, they generally don't require these resources to be dedicated to a single container. A host can, therefore, distribute use of shared system resources as needed.
- Get bare-metal performance to apps, because there is no hardware emulation layer separating them from a host server.

In addition, by hosting containers on bare metal, you get the benefits that have traditionally been possible only with VMs:

- Gain the ability to deploy apps inside portable environments that can move easily between host servers.
- Get app isolation. Although containers arguably don't provide the same level of isolation as VMs, containers do enable admins to prevent apps from interacting with one another and to set strict limits on the privileges and resource accessibility associated with each container.

In short, run containers on bare metal to square the circle -- do what seems impossible. Reap all the benefits of bare-metal servers' performance and hardware accessibility, and take advantage of the portability and isolation features seen with VMs.
