# Lab6 - Drain a node and reschedule the containers

Your sleep-app has been doing amazing after hitting Reddit and HN. It’s now number 1 on the App Store! You have scaled up during the holidays and down during the slow season. Now you are doing maintenance on one of your servers so you will need to gracefully take a server out of the swarm without interrupting service to your customers.

Take a look at the status of your nodes again by running docker node ls on node1.

```
$ docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
swfk8vsyfe4z2zbtianz5gh2p *   manager1            Ready               Active              Leader              18.09.3
sgyr3vxu1n99vyce9al67alwt     manager2            Ready               Active              Reachable           18.09.3
ud3ghz1zlrmn3fbv9j930ldja     manager3            Ready               Active              Reachable           18.09.3
v57fk367d1lw4e1ufis3jwa2h     worker1             Ready               Active               18.09.3
uinkvr56fq7zb711ycbifhf4f     worker2             Ready               Active               18.09.3
```

You will be taking worker2 out of service for maintenance.

Let’s see the containers that you have running on worker2.

We are going to take the ID for worker2 and run docker node update --availability drain worker2. 
We are using the worker2 host ID as input into our drain command. Replace yournodeid with the id of worker2.

```
$ docker node update --availability drain worker2
worker2
```

```
$ docker node ls
ID                            HOSTNAME            STATUS              AVAILABILITY        MANAGER STATUS      ENGINE VERSION
swfk8vsyfe4z2zbtianz5gh2p *   manager1            Ready               Active              Leader              18.09.3
sgyr3vxu1n99vyce9al67alwt     manager2            Ready               Active              Reachable           18.09.3
ud3ghz1zlrmn3fbv9j930ldja     manager3            Ready               Active              Reachable           18.09.3
v57fk367d1lw4e1ufis3jwa2h     worker1             Ready               Active               18.09.3
uinkvr56fq7zb711ycbifhf4f     worker2             Ready               Drain
```


Node worker2 is now in the Drain state.

Switch back to node2 and see what is running there by running docker ps.

```
$ docker ps
CONTAINER ID        IMAGE               COMMAND             CREATED             STATUS     PORTS               NAMES
```

worker2 does not have any containers running on it.

Lastly, check the service again on node1 to make sure that the container were rescheduled. 
You should see all four containers running on the remaining two nodes.

```
$ docker service ps sleep-app
ID                  NAME                IMAGE               NODE                DESIRED STATE     CURRENT STATE            ERROR               PORTS
bv6ofc6x6moq        sleep-app.1         ubuntu:latest       manager1            Running     Running 18 minutes ago
5gj1ql7sjt14        sleep-app.2         ubuntu:latest       manager2            Running     Running 12 minutes ago
5aqy7jv9ojmn        sleep-app.3         ubuntu:latest       worker1             Running     Running 3 minutes ago
p01z0tchepwa         \_ sleep-app.3     ubuntu:latest       worker2             Shutdown     Shutdown 3 minutes ago
kwmey288bkhp        sleep-app.6         ubuntu:latest       manager3            Running     Running 12 minutes ago
```

```
[manager1] (local) root@192.168.0.9 ~/dockerlabs/intermediate/swarm
$ docker node inspect --pretty worker2
ID:                     uinkvr56fq7zb711ycbifhf4f
Hostname:               worker2
Joined at:              2019-03-08 15:12:03.102015148 +0000 utc
Status:
 State:                 Ready
 Availability:          Drain
 Address:               192.168.0.10
Platform:
 Operating System:      linux
 Architecture:          x86_64
Resources:
 CPUs:                  8
 Memory:                31.4GiB
Plugins:
 Log:           awslogs, fluentd, gcplogs, gelf, journald, json-file, local, logentries, splunk
, syslog
 Network:               bridge, host, ipvlan, macvlan, null, overlay
 Volume:                local
Engine Version:         18.09.3
TLS Info:
 TrustRoot:
-----BEGIN CERTIFICATE-----
MIIBajCCARCgAwIBAgIUcfR/4dysEv9qsbuPTFuIn00WbmowCgYIKoZIzj0EAwIw
EzERMA8GA1UEAxMIc3dhcm0tY2EwHhcNMTkwMzA4MTUwNzAwWhcNMzkwMzAzMTUw
NzAwWjATMREwDwYDVQQDEwhzd2FybS1jYTBZMBMGByqGSM49AgEGCCqGSM49AwEH
A0IABPo7tm+Vxk+CIw9AJEGTlyW/JPotQuVqrbvi34fuK6Ak4cWYU6T1WSiJMHI0
nEGS/1zFIWQzJY0WQbT8eMaqX4ijQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMB
Af8EBTADAQH/MB0GA1UdDgQWBBQ6OEYmo8HUfpFnSxJDHWkjf/wWmTAKBggqhkjO
PQQDAgNIADBFAiBy39e7JLpHBH0bONWU8rQZPmY2dtkfHjPOUQNLFBdlkAIhAIpD
Lb6ZrhbEJDcIhlnozKRcPSJi7RWy4/16THIUJdpM
-----END CERTIFICATE-----

 Issuer Subject:        MBMxETAPBgNVBAMTCHN3YXJtLWNh
 Issuer Public Key:     MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE+ju2b5XGT4IjD0AkQZOXJb8k+i1C5Wqtu+Lfh+4roCThxZhTpPVZKIkwcjScQZL/XMUhZDMljRZBtPx4xqpfiA==
 ```
 
 Run docker node update --availability active <NODE-ID> to return the drained node to an active state:
 
 ```
 $ docker node update --availability active worker2
worker2
[manager1] (local) root@192.168.0.9 ~/dockerlabs/intermediate/swarm
$ docker node inspect --pretty worker2
ID:                     uinkvr56fq7zb711ycbifhf4f
Hostname:               worker2
Joined at:              2019-03-08 15:12:03.102015148 +0000 utc
Status:
 State:                 Ready
 Availability:          Active
 Address:               192.168.0.10
Platform:
 Operating System:      linux
 Architecture:          x86_64
Resources:
 CPUs:                  8
 Memory:                31.4GiB
Plugins:
 Log:           awslogs, fluentd, gcplogs, gelf, journald, json-file, local, logentries, splunk, syslog
 Network:               bridge, host, ipvlan, macvlan, null, overlay
 Volume:                local
Engine Version:         18.09.3
TLS Info:
 TrustRoot:
-----BEGIN CERTIFICATE-----
MIIBajCCARCgAwIBAgIUcfR/4dysEv9qsbuPTFuIn00WbmowCgYIKoZIzj0EAwIw
EzERMA8GA1UEAxMIc3dhcm0tY2EwHhcNMTkwMzA4MTUwNzAwWhcNMzkwMzAzMTUw
NzAwWjATMREwDwYDVQQDEwhzd2FybS1jYTBZMBMGByqGSM49AgEGCCqGSM49AwEH
A0IABPo7tm+Vxk+CIw9AJEGTlyW/JPotQuVqrbvi34fuK6Ak4cWYU6T1WSiJMHI0
nEGS/1zFIWQzJY0WQbT8eMaqX4ijQjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMB
Af8EBTADAQH/MB0GA1UdDgQWBBQ6OEYmo8HUfpFnSxJDHWkjf/wWmTAKBggqhkjO
PQQDAgNIADBFAiBy39e7JLpHBH0bONWU8rQZPmY2dtkfHjPOUQNLFBdlkAIhAIpD
Lb6ZrhbEJDcIhlnozKRcPSJi7RWy4/16THIUJdpM
-----END CERTIFICATE-----

 Issuer Subject:        MBMxETAPBgNVBAMTCHN3YXJtLWNh
 Issuer Public Key:     MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE+ju2b5XGT4IjD0AkQZOXJb8k+i1C5Wqtu+Lfh+4roCThxZhTpPVZKIkwcjScQZL/XMUhZDMljRZBtPx4xqpfiA==
 ```

[Lab7 - Cleaning Up](lab7-cleaning-up.md)
