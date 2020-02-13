# Building Web Frontend/UI for Local Docker Registry using Portus

Portus is an authorization server and a user interface for the next generation of the Docker registry. Portus targets version 2 of the Docker Registry API. The minimum required version of Registry is 2.1, 
which is the first version supporting soft deletes of blobs.

If you are looking out for Web UI for your private Docker Registry, I would recommend to test-drive a tool called “Portus” powered by SUSE Team. Portus provides a useful and powerful UI on top of your registry. It is an open source authorization service and a user interface for the next generation of the Docker registry.
Portus targets version 2 of the Docker Registry API.

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Ubuntu 18.04 </b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Install Docker

```
curl -sSL https://get.docker.com/ | sh
```

## Installing Docker Compose

```
curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

```

## Create Docker Registry

```
docker run -d \
  -p 2000:2000 \
  --restart=always \
  --name registry \
  -v /mnt/registry:/var/lib/registry \
  registry:2
```

## Cloning the Repository

```
git clone https://github.com/SUSE/Portus
```

## Bring up Portus Application

```
docker-compose up -d
```

## Verifying the Portus services


```
 docker-compose ps
       Name                     Command             State              Ports
---------------------------------------------------------------------------------------
portus_background_1   bundle exec rails runner /    Up      3000/tcp
                      ...
portus_clair_1        /clair -config /clair.yml     Up      0.0.0.0:6060->6060/tcp,
                                                            0.0.0.0:6061->6061/tcp
portus_db_1           /docker-entrypoint.sh mysq    Up      3306/tcp
                      ...
portus_portus_1       bundle exec rails runner /    Up      0.0.0.0:3000->3000/tcp
                      ...
portus_postgres_1     docker-entrypoint.sh          Up      5432/tcp
                      postgres
portus_registry_1     /entrypoint.sh /etc/docker    Up      0.0.0.0:5000->5000/tcp,
                      ...                                   0.0.0.0:5001->5001/tcp
portus_webpack_1      bash /srv/Portus/examples/    Up
                  ...

```

![My image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/portus/Portus_11.png)

![My image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/portus/Portus_2.png)


## Provide Docker Registry Details

Once you login to Portus, you will need to provide Docker Registry details:

```
- Name
- <Your Host IP or Hostname>: 2000
```

**Please remember that Portus is designed to handle only a single private Registry.**

![My image](https://raw.githubusercontent.com/collabnix/dockerlabs/master/beginners/portus/Portus_3.png)

## Creating Users & Team
 
 Say, you have 4-5 teams inside your organization namely,
 
 - DB Team
 - HPC Team
 - Solutions Team
 - Advisor Team
 - Virtualization Team
 
 First, create user who would be point of contact for each of these teams who will be pushing their Docker Image.
 Then, create team names accordingly.
 
 
 
## Contributor
 
 - [Ajeet Singh Raina](mailto:ajeetraina@gmail.com)
 
 Next >> [Managing volumes through Docker CLI](https://collabnix.github.io/dockerlabs/beginners/volume/managing-volumes-via-docker-cli.html)
