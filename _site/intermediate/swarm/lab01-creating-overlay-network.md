# Lab01 - Create Overlay Network

Swarm Mode also introduces an improved networking model. 
In previous versions, Docker required the use of an external key-value store, such as Consul, to ensure consistency across the network. 
The need for consensus and KV has now been incorporated internally into Docker and no longer depends on external services.

The improved networking approach follows the same syntax as previously. The overlay network is used to enable containers on 
different hosts to communicate. Under the covers, this is a Virtual Extensible LAN (VXLAN), designed for large scale cloud based 
deployments.

## Task

The following command will create a new overlay network called skynet. All containers registered to this network can communicate with 
each other, regardless of which node they are deployed onto.

```
docker network create -d overlay collabnet
```

[Next >> Lab02- Deploy Services](lab02-deploy-services.md)
