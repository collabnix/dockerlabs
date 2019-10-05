What you will learn:

This reference architecture describes a standard production-level Docker EE deployment. It also details the various components of Docker EE, including how they work, how to automate deployment, how to manage users and teams, how to provide high availability for the platform, and how to manage the infrastructure and please look for the new updates and respective article for more info.

please note : some Enviroment specific details will not be provided as things may differ from different cloud providers and on-premises infrastructures as well.



In a production environment, minimizing downtime for critical services is critical. It is important to understand how to achieve high availability (HA) in UCP and DTR, and what to do if a failure occurs. UCP and DTR use the same principle to provide HA, but UCP has a more direct correlation with Swarm's functionality. The general principle is to replicate core services in a cluster, so that when one node fails, the other nodes can take over. The load balancer provides the user with a stable hostname that is independent of the actual node that handles the request, making the service transparent to the user. This is the basic clustering mechanism that provides HA.

UCP
UCP runs a global service called all cluster nodes ucp-agent. This agent installs one UCP controller on each of the Swarm management nodes. There is a one-to-one correspondence between the Swarm management node and the UCP controller, but they assume different roles. UCPs that use this agent rely on Swarm to implement Ha, but also include some replicated data stores that rely on their own raft consistency set different from Swarm: ucp-auth-store (a replicate database for identity management data) and ucp- Kv (copy key-value storage for UCP configuration data).
