




# Installing UCP on Docker Enterprise 18.09

Ensure that you authenticate your DockerHub ID

```
docker login
```

Now installing UCP containers

```
sudo docker container run --rm -it --name ucp   -v /var/run/docker.sock:/var/run/docker.sock   docker/ucp:3.0.5 install   --host-address 10.140.0.2 --interactive
INFO[0000] Your engine version 18.09.0, build 33a45cd (4.18.0-1003-gcp) is compatible with UCP 3.0.5 (f588f8a) 
Admin Username: ajeetraina
Admin Password: 
Confirm Admin Password: 
INFO[0010] Pulling required images... (this may take a while) 
INFO[0010] Pulling docker/ucp-calico-node:3.0.5         
INFO[0027] Pulling docker/ucp-kube-compose:3.0.5        
INFO[0034] Pulling docker/ucp-kube-dns:3.0.5            
INFO[0041] Pulling docker/ucp-interlock:3.0.5           
INFO[0047] Pulling docker/ucp-auth-store:3.0.5          
INFO[0055] Pulling docker/ucp-calico-cni:3.0.5          
INFO[0069] Pulling docker/ucp-swarm:3.0.5               
INFO[0075] Pulling docker/ucp-kube-dns-dnsmasq-nanny:3.0.5 
INFO[0083] Pulling docker/ucp-dsinfo:3.0.5              
INFO[0094] Pulling docker/ucp-interlock-extension:3.0.5 
INFO[0100] Pulling docker/ucp-metrics:3.0.5             
INFO[0111] Pulling docker/ucp-interlock-proxy:3.0.5     
INFO[0115] Pulling docker/ucp-compose:3.0.5             
INFO[0119] Pulling docker/ucp-kube-dns-sidecar:3.0.5    
WARN[0126] None of the hostnames we'll be using in the UCP certificates [master1 127.0.0.1 172.17.0.1 10.140.0.2] contain a domain component.  Your generated certs may fail TLS validation unless you only use one of these shortnames or IPs to connect.  You can use the --san flag to add more aliases 

You may enter additional aliases (SANs) now or press enter to proceed with the above list.
Additional aliases: 
INFO[0000] Initializing a new swarm at 10.140.0.2       
INFO[0012] Installing UCP with host address 10.140.0.2 - If this is incorrect, please specify an alternative address with the '--host-address' flag 
INFO[0012] Deploying UCP Service...                                            
```
