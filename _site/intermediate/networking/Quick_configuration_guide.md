#  Docker Quick Networking Guide 

Below is a list of commands related to the Docker network.

Some of these command options are only configurable when the Docker service is started and will not take effect immediately.

 - `-b BRIDGE` or` --bridge=BRIDGE` specifies the bridge to which the container is mounted
 - `--bip=CIDR `custom masker0 mask
 - `-H SOCKET... `or `--host=SOCKET...` Channel for the Docker server to receive commands
 - `--icc=true|false` Whether communication between containers is supported
 - `--ip-forward=true|false `Please see the communication between the containers below
 - `--iptables=true|false `you allow Docker to add iptables rules?
 - `--mtu=BYTES MTU `in the --mtu=BYTES container network <br>
 
The following two command options can be specified either when starting the service or when starting the container. Specifying the Docker service when it is started will become the default value, and the default value of the setting can be overwritten when the docker run is executed later.

 - `--dns=IP_ADDRESS...` Use the specified DNS server
 - `--dns-search=DOMAIN...` Specify the DNS search domain <br>
 
 Finally, these options are only used when the docker run executed because it is specific to the container's properties.

 - `-h HOSTNAME `or `--hostname=HOSTNAME `configuration container hostname
 - `--link=CONTAINER_NAME:ALIAS `adds a connection to another container
 - `--net=bridge|none|container:NAME_or_ID|host `configures the bridge mode of the container
 - `-p SPEC or --publish=SPEC` maps the container port to the host host
 - `-P or --publish-all=true|false` maps all ports of the container to the host
 
 
 ## Contributor - [Sangam Biradar](https://www.linkedin.com/in/sangambiradar14/)
