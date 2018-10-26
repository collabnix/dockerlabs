

# <TOPIC NAME>

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b> Google Cloud Platform</b></td>
    <td class="tg-yw4l"><b>3</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>

## Pre-requisite

- Create an account on Google Cloud Platform
- Create 3 Ubuntu VMs
- Install Docker Enterprise Edition 2.0


## Resetting the Admin Password

The first option is to attempt a reset of the admin password.The passwd command on enzi requires the value for --db-addr pointing to the RethinkDB host and port. This information can be found in the process table on the eNZi container. First, connect to the controller node:

```
openusm@master01:~$ docker ps | grep ucp-auth
acecf9799c9b        docker/ucp-auth:3.0.5                "/usr/local/bin/en..."   3 minutes ago       Up 3 minutes (healthy)  
                                                                                   ucp-auth-worker.slsvy00m1khejbo5itmupk034.s
nbsssuzuyegfio3sjltcjt0m
baa8b0f865a2        docker/ucp-auth:3.0.5                "/usr/local/bin/en..."   3 minutes ago       Up 3 minutes (healthy)  
                                                                                   ucp-auth-api.slsvy00m1khejbo5itmupk034.hzcn
sn03njtuuuqnfloo8sibp
1d382b34e9d9        docker/ucp-auth-store:3.0.5          "rethinkdb --bind ..."   2 weeks ago         Up 4 minutes (healthy)  
 0.0.0.0:12383-12384->12383-12384/tcp                                              ucp-auth-store
```

At the prompt for the controller node, use the following command to view the enzi processes:

```
openusm@master01:~$ docker exec -it acec sh
~ $ ps -eaf | grep enzi
    1 nobody     0:00 /usr/local/bin/enzi --db-addr=127.0.0.1:12383 --jsonlog --config-decryption-key-file=/run/secrets/ucp-au
th-key worker --listen-addr=:12386
   87 nobody     0:00 grep enzi
   
```
Use the db-addr in the running process to specify the same value to the enzi command to change the admin password:

```
~ $ enzi --db-addr=127.0.0.1:12383 passwd --interactive
Admin Username: openusm
Admin Password: 
Confirm Admin Password: 
FATA[0006] unable to get user: no such account          
~ $ enzi --db-addr=127.0.0.1:12383 passwd --interactive
Admin Username: collabnix
Admin Password: 
Confirm Admin Password: 
INFO[0008] successfully set user account password: collabnix 
```

If successful, you will see the above messages.
