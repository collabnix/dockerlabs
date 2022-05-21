
# Running Docker Compose

```

$ docker-compose up -d
Creating network "test_default" with the default driver
Creating volume "test_db-data" with default driver
Pulling db (postgres:9.6.6-alpine)...
9.6.6-alpine: Pulling from library/postgres
b1f00a6a160c: Pull complete
25a88a2feda9: Pull complete
bcd866a92fb7: Pull complete
4f5111752440: Pull complete
5ebed1cae086: Pull complete
dfba8057a354: Pull complete
d0eb338c9df5: Pull complete
4aa7632b4dad: Pull complete
20560a78883f: Pull complete
Digest: sha256:f90f0beba0b453dae3940a96cf8a433510c5b2109888bb62f7b2d8b1a3c9324b
Status: Downloaded newer image for postgres:9.6.6-alpine
Creating test_db_1 ...
Creating test_db_1 ... done
```

# Verifying the running Docker Container

```
[node1] (local) root@192.168.0.48 ~/test
$ docker ps
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS                    NAMES
bbe04e98fb2c        postgres:9.6.6-alpine   "docker-entrypoint..."   5 seconds ago       Up 4 seconds        0.0.0.0:5432->5432/tcp   test_db_1
[node1] (local) root@192.168.0.48 ~/test

```

```
$ docker logs -f bbe
The files belonging to this database system will be owned by user "postgres".
This user must also own the server process.

The database cluster will be initialized with locale "en_US.utf8".
The default database encoding has accordingly been set to "UTF8".
The default text search configuration will be set to "english".

Data page checksums are disabled.

fixing permissions on existing directory /var/lib/postgresql/data ... ok
creating subdirectories ... ok
selecting default max_connections ... 100
selecting default shared_buffers ... 128MB
selecting dynamic shared memory implementation ... posix
creating configuration files ... ok
running bootstrap script ... ok
sh: locale: not found
performing post-bootstrap initialization ... No usable system locales were found.
Use the option "--debug" to see details.
ok

WARNING: enabling "trust" authentication for local connections
You can change this by editing pg_hba.conf or using the option -A, or
--auth-local and --auth-host, the next time you run initdb.
syncing data to disk ... ok

Success. You can now start the database server using:

    pg_ctl -D /var/lib/postgresql/data -l logfile start

waiting for server to start....LOG:  could not bind IPv6 socket: Address not available
HINT:  Is another postmaster already running on port 5432? If not, wait a few seconds and retry.
LOG:  database system was shut down at 2017-12-02 13:05:07 UTC
LOG:  MultiXact member wraparound protections are now enabled
LOG:  database system is ready to accept connections
LOG:  autovacuum launcher started
 done
server started
CREATE DATABASE

CREATE ROLE


/usr/local/bin/docker-entrypoint.sh: ignoring /docker-entrypoint-initdb.d/*

waiting for server to shut down....LOG:  received fast shutdown request
LOG:  aborting any active transactions
LOG:  autovacuum launcher shutting down
LOG:  shutting down
LOG:  database system is shut down
 done
server stopped

PostgreSQL init process complete; ready for start up.

LOG:  database system was shut down at 2017-12-02 13:05:08 UTC
LOG:  MultiXact member wraparound protections are now enabled
LOG:  database system is ready to accept connections
LOG:  autovacuum launcher started

```

```
[node1] (local) root@192.168.0.48 ~/test
$ docker ps
CONTAINER ID        IMAGE                   COMMAND                  CREATED             STATUS              PORTS                    NAMES
bbe04e98fb2c        postgres:9.6.6-alpine   "docker-entrypoint..."   24 seconds ago      Up 23 seconds       0.0.0.0:5432->5432/tcp   test_db_1
[node1] (local) root@192.168.0.48 ~/test
```
```
$ docker volume ls
DRIVER              VOLUME NAME
local               test_db-data
[node1] (local) root@192.168.0.48 ~/test
$ docker volume inspect test_db-data
[
    {
        "CreatedAt": "2017-12-02T13:05:09Z",
        "Driver": "local",
        "Labels": {
            "com.docker.compose.project": "test",
            "com.docker.compose.volume": "db-data"
        },
        "Mountpoint": "/var/lib/docker/volumes/test_db-data/_data",
        "Name": "test_db-data",
        "Options": {},
        "Scope": "local"
    }
]
[node1] (local) root@192.168.0.48 ~/test
$ cd /var/lib/docker/volumes/test_db-data/_data
[node1] (local) root@192.168.0.48 /var/lib/docker/volumes/test_db-data/_data
$ ls
PG_VERSION            pg_dynshmem           pg_notify             pg_stat_tmp           postgresql.auto.conf
base                  pg_hba.conf           pg_replslot           pg_subtrans           postgresql.conf
global                pg_ident.conf         pg_serial             pg_tblspc             postmaster.opts
pg_clog               pg_logical            pg_snapshots          pg_twophase           postmaster.pid
pg_commit_ts          pg_multixact          pg_stat               pg_xlog
[node1] (local) root@192.168.0.48 /var/lib/docker/volumes/test_db-data/_data

```
