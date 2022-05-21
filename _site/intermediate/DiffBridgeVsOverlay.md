

## Bridge networks 
 The Bridge network connect two networks while creating a single aggregate network from multiple communication networks or network segments, hence the name bridge.

The bridge driver creates a private network internal to the host so containers on this network can communicate. External access is granted by exposing ports to containers. Docker secures the network by managing rules that block connectivity between different Docker networks.

Behind the scenes, the Docker Engine creates the necessary Linux bridges, internal interfaces, iptables rules, and host routes to make this connectivity possible. In the example highlighted below, a Docker bridge network is created and two containers are attached to it. With no extra configuration the Docker Engine does the necessary wiring, provides service discovery for the containers, and configures security rules to prevent communication to other networks. A built-in IPAM driver provides the container interfaces with private IP addresses from the subnet of the bridge network.

![alt text](https://raw.githubusercontent.com/amitatha82/dockerlabs/master/beginners/images/bridge.png)

The above application is now being served on our host at port 8000. The Docker bridge is allowing web to communicate with db by its container name. The bridge driver does the service discovery for us automatically because they are on the same network. All of the port mappings, security rules, and pipework between Linux bridges is handled for us by the networking driver as containers are scheduled and rescheduled across a cluster.

The bridge driver is a local scope driver, which means it only provides service discovery, IPAM, and connectivity on a single host. Multi-host service discovery requires an external solution that can map containers to their host location. This is exactly what makes the overlay driver so great.

## Overlay networks 

The Overlay Network are usually used to create a virtual network between two separate hosts. Virtual, since the network is build over an existing network.

The built-in Docker overlay network driver radically simplifies many of the complexities in multi-host networking. It is a swarm scope driver, which means that it operates across an entire Swarm or UCP cluster rather than individual hosts. With the overlay driver, multi-host networks are first-class citizens inside Docker without external provisioning or components. IPAM, service discovery, multi-host connectivity, encryption, and load balancing are built right in. For control, the overlay driver uses the encrypted Swarm control plane to manage large scale clusters at low convergence times.

The overlay driver utilizes an industry-standard VXLAN data plane that decouples the container network from the underlying physical network (the underlay). This has the advantage of providing maximum portability across various cloud and on-premises networks. Network policy, visibility, and security is controlled centrally through the Docker Universal Control Plane (UCP).

![alt text](https://raw.githubusercontent.com/amitatha82/dockerlabs/master/beginners/images/overlay.png)

In the above example we are still serving our web app on port 8000 but now we have deployed our application across different hosts. If we wanted to scale our web containers, Swarm & UCP networking would load balance the traffic for us automatically.

The overlay driver is a feature-rich driver that handles much of the complexity and integration that organizations struggle with when crafting piecemeal solutions. It provides an out-of-the-box solution for many networking challenges and does so at scale.


