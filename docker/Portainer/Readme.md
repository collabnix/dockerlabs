# Portainer Docker Management User Interface 

Portainer is a lightweight management UI which allows you to easily manage you  different Docker environments (Docker hosts or Swarm clusters)


## Installation:
           
## Create volume for portainer
                               
```
docker volume create <name_of_volume>
```


## Check volume
                              
```
docker volume ls  
```


## Run portainer container with volume
                               
```
docker run -d -p 8080:8080 -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v <name_of_volume>:/data portainer/portainer
```


## Access user interface 
        
```
curl http://localhost:9000
```

# Contributor

[AliAbbask08]() 
