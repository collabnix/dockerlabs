# RedisInsight Docker Extension


[![Docker Extension for RedisInsight](https://user-images.githubusercontent.com/313480/190151293-edd0432e-b168-47ec-8e65-ed20216b079d.png)](https://www.youtube.com/watch?v=12VXlRTFDWw)  |


RedisInsight is an intuitive and efficient GUI for Redis. It allows developers to interact with your databases and manage your data—with built-in support for most popular Redis modules. 

It is an open source Redis GUI tool that allows you to visualise, monitor, and optimize while developing your applications with Redis.

This repository show how to run Redis GUI as a single-click installation using RedisInsight Docker Extension.





> This is Work-in-progress
- [x] Building Compose File
- [x] Constructing UI
- [ ] Final Testing


RedisInsight is an intuitive and efficient GUI for Redis, allowing you to interact with your databases and manage your data—with built-in support for most popular Redis modules. It is an open source Redis GUI tool that allows you to visualise, monitor, and optimize while developing your applications with Redis.

<img width="834" alt="image" src="https://user-images.githubusercontent.com/313480/190139325-e93ac88f-2028-40ee-b947-e8dc6ac1657e.png">

## Getting Started

You can try it now! [![Install RedisInsight extension](https://img.shields.io/badge/-Install%20RedisInsight%20extension-white?logo=docker)](https://open.docker.com/extensions/marketplace?extensionId=ajeetraina/redisinsight-docker-extension&tag=1.13.0)

### Pre-requisite

- Docker Desktop 4.12


## 1. Clone the repository


```shell
 git clone https://github.com/collabnix/redisinsight-docker-extension
```

## 2. Build the Extension

```shell
 make build-extension
```
#### If you run into error: Failed to solve with frontend dockerfile.v0: failed to create LLB definition
```
export DOCKER_BUILDKIT=0
export COMPOSE_DOCKER_CLI_BUILD=0
```


## 3. Install the Extension

```shell
 docker extension install <name-of-extension>
 ```
 
 
 Open Docker Dashboard to see RedisInsight Extension already up and running.
 
 ## Connecting to the Local Redis Database
 
 ### Step 1. Toggle to agree to the license terms and click "Confirm"
 
 <img width="1157" alt="image" src="https://user-images.githubusercontent.com/313480/188198634-c51317d3-2379-4b64-953f-2e315861503d.png">

### Step 2. Select "I already have database"
 
 <img width="1029" alt="image" src="https://user-images.githubusercontent.com/313480/188198988-b558c249-fa76-4de5-871c-c905bb5a3af3.png">


### Step 3. Enter the local database details to connect to Redis Database

This extensions runs local Redis database too. It is included for testing purpose.
Click "Connect to Redis Database" and enter the values

<img width="1015" alt="image" src="https://user-images.githubusercontent.com/313480/188199135-23fe66a6-a6b6-46e3-be5c-b6bb5fe7a680.png">

## Step 4. Enter your host details. 

Please replace the host address with your local IP address. Click "Add Database".

 
 <img width="952" alt="image" src="https://user-images.githubusercontent.com/313480/188199352-98c13515-7869-44eb-ae0c-dbec6ab9a052.png">


### Step 5. Select the right database to view the dashboard UI.
 
 <img width="1055" alt="image" src="https://user-images.githubusercontent.com/313480/188199604-69dd8f2d-7de3-4a6f-b35b-96635d9cfd05.png">
 
 
 ### Step 6. View the Keys
 
 <img width="1173" alt="image" src="https://user-images.githubusercontent.com/313480/188200043-e49f0bbb-3abd-4b81-bb9a-1a307485636c.png">

 

 
## Connecting to the Remote Database (Redis Enterprise Cloud)

 
 ## Step 1. Connect to the remote Redis Cloud
 
 
 <img width="1398" alt="image" src="https://user-images.githubusercontent.com/313480/188183023-3513bc60-a0aa-425b-b7ba-0b44f074a876.png">
 
 
 ## Step 2. Access the Database
 
 <img width="1306" alt="image" src="https://user-images.githubusercontent.com/313480/188183102-1d6bab60-f8e4-4e39-9d31-4023883fc649.png">



 
 ## Step 3. Viewing the Keys
 
 <img width="1257" alt="image" src="https://user-images.githubusercontent.com/313480/188184985-2c4d24fa-ad39-4827-9eaa-2e6407ac8c6f.png">
