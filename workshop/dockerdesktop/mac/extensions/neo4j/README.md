# neo4j-docker-extension



Neo4j is a highly scalable, robust native graph database. It is more suitable for certain big data and analytics applications than row and column databases or free-form JSON document databases for many use cases. 
A graph database is used to represent relationships.

<img width="1507" alt="image" src="https://user-images.githubusercontent.com/34368930/203765682-2e391676-ce54-4424-8594-382a172329f0.png">

With this Docker Extension, once can setup the Neo4j with just a few commands/clicks.

> This is Work-in-progress
- [x] Building Compose File
- [] Constructing UI
- [] Final Testing


## Getting Started

- Docker Desktop 4.8+

## Clone the repo

```shell
 git clone https://github.com/collabnix/neo4j-docker-extension
 ```
 
 ## Building the Extension
 
 ```
  make install-extension
 ```
 
 ## Install the Extension
 
 ```shell
  docker extension install ajeetraina/neo4j-docker-extension:1.0         
  ```
 
 Open Docker Dashboard to see Neo4j Docker Extension already up and running.
 
 ## Connecting to the local database
 
 Use neo4j/neo4j as username/password.
 
 <img width="1495" alt="image" src="https://user-images.githubusercontent.com/34368930/203767042-3b017a73-ea9c-46cd-b068-73f4e697c517.png">




