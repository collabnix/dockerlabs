# Portainer Docker Management User Interface 

Portainer is a lightweight management UI which allows you to easily manage you  different Docker environments (Docker hosts or Swarm clusters)


Installation:
           Linux:
1. Create volume for portainer
                               docker volume create <name_of_volume>


2. Check volume
                               docker volume ls  


3. Run portainer container with volume
                               docker run -d -p 8080:8080 -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v <name_of_volume>:/data portainer/portainer


4. Access user interface 
        curl http://localhost:9000
