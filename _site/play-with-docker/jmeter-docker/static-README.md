# Generating Load using Static IP Address

In case you want to generate enough load so that the System Under test is stressed from different multiple IPs, follow the below procedure:

<b> Pre-requisite </b>

1. Setting up Docker Host-1 and Docker Host-2
2. Setting up macvlan:

<b> On Docker Host-1:</b>

                root@ubuntu4:~#ip link add virtual0 link eno1 type macvlan mode bridge

                
                 
                root@ubuntu4:~# docker network create -d macvlan --subnet=10.91.15.0/24 --gateway=10.91.15.1 -o parent=virtual0 macvlan0
                 26bc952662e118fa855add784b65b53f4ca24c44a3b36af32819e89a62bc5f09
                  
                  root@ubuntu4:~# docker network ls
                  NETWORK ID          NAME                DRIVER              SCOPE
                  26bc952662e1        macvlan0            macvlan             local
    
<b> Run the below command to start the container which uses Macvlan:</b>

                 $docker run -dit --net=macvlan0  --name slave01 ajeetraina/jmeter-master /bin/bash
                 
<b> On Docker Host-2:</b>

                root@ubuntu4:~#ip link add virtual0 link eno1 type macvlan mode bridge

                
                 
                root@ubuntu4:~# docker network create -d macvlan --subnet=10.91.15.0/24 --gateway=10.91.15.1 -o parent=virtual0 macvlan0
                 26bc952662e118fa855add784b65b53f4ca24c44a3b36af32819e89a62bc5f09
                  
                  root@ubuntu4:~# docker network ls
                  NETWORK ID          NAME                DRIVER              SCOPE
                  26bc952662e1        macvlan0            macvlan             local
    
<b> Run the below command to start the container which uses Macvlan:</b>

                 $docker run -dit --net=macvlan0  --name slave01 ajeetraina/jmeter-server /bin/bash              

                  
