# What is RethinkDB?

RethinkDB is a free and open-source, distributed document-oriented database originally created by the company of the same name. The database stores JSON documents with dynamic schemas, and is designed to facilitate pushing real-time updates for query results to applications. Initially seed funded by Y Combinator in June 2009,[2] the company announced in October 2016 that it had been unable to build a sustainable business and its products would in future be entirely open-sourced without commercial support.[3]


## RethinkDB Dockerfile


This repository contains **Dockerfile** of [RethinkDB](http://www.rethinkdb.com/) for [Docker](https://www.docker.com/)'s [automated build](https://hub.docker.com/_/rethinkdb/) published to the public [Docker Hub Registry](https://registry.hub.docker.com/).


### Installation

- Install [Docker](https://www.docker.com/).



### Usage

    docker run -d -p 8080:8080 -p 28015:28015 -p 29015:29015 dockerfile/rethinkdb

#### Run the first host of cluster

    docker run -d -h `hostname` -p 8080:8080 -p 28015:28015 -p 29015:29015 -v <data-dir>:/data dockerfile/rethinkdb rethinkdb -d /data --bind all --canonical-address `curl icanhazip.com`

#### Run subsequent hosts joining to cluster

    docker run -d -h `hostname` -p 8080:8080 -p 28015:28015 -p 29015:29015 -v <data-dir>:/data dockerfile/rethinkdb rethinkdb -d /data --bind all --canonical-address `curl icanhazip.com` -j <first-host-ip>:29015

After few seconds, Open `http://<host>:8080`.

