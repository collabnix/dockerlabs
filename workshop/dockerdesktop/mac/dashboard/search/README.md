In the latest [Docker Desktop v4.14.x release](https://docs.docker.com/desktop/release-notes/#docker-desktop-4141), Docker announced the "Search" feature in the Desktop dashboard for the first time. This feature allows you to search containers, local images and Docker Hub images directly from the dashboard. Not only this, it allows you to pull and spin up Docker containers right from the search option. Interesting, isn't it?

![Image0](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/07pqv187t8j1f97wqtls.png)

In my [last blog post](https://dev.to/docker/running-mongodb-in-a-docker-container-in-5-minutes-33c5), I talked about how one can run MongoDB in a Docker container using a CLI terminal. If you’re using Docker Desktop, you can set up the same MongoDB server without even accessing CLI. Curious to know how? Keep reading…Let us try to search MongoDB Docker Image and spin up a document database container with additional required settings using this search feature. 


## Getting Started


- [Download and Install Docker Desktop](https://desktop.docker.com/mac/main/amd64/Docker.dmg?utm_source=docker&utm_medium=webreferral&utm_campaign=dd-smartbutton&utm_location=module) 

Once you have installed Docker Desktop in your preferred operating system, open the Dashboard option as shown in the screenshot.

![Image11](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/47u2im3j9pawu4oqryce.png)



You will see a search-bar on the top right of the Dashboard.


![Image1](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/1hcoez9wbspba0fb0g60.png)

Start typing "Mongo". You will see search results appearing on the screen. It shows local as well as Docker Hub images. Look like I already pulled Mongo Docker image from the Docker Hub earlier and hence it shows it under Local Images section.


![Image2](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/gb81b7kt9j0kxjx5gexo.png)


## Configuring the settings & environment variable

You can setup environment variables like username and password as shown in the following way:



![Image5](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ksbbtk6zprj10c0xaod5.png)


## Click "Run" the MongoDB container

![Image4](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/t435z81pvc3n60k3igjv.png)

## Viewing the logs


![Image6](https://dev-to-uploads.s3.amazonaws.com/uploads/articles/ukv9xu4vhchtbfk8cv3p.png)


## Accessing MogoDB Server via Mac Terminal


To achieve this, you will need to install Mongosh(Mongo Shell) software on your Mac system:

```
brew install mongosh          
```

Next, Run mongosh without any command-line options to connect to a MongoDB instance running on your localhost with default port 27017:



```
mongosh 
Current Mongosh Log ID:	637857e4560a50a9c0df827c
Connecting to:		mongodb://127.0.0.1:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.6.0
Using MongoDB:		6.0.3
Using Mongosh:		1.6.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/


To help improve our products, anonymous usage data is collected and sent to MongoDB periodically (https://www.mongodb.com/legal/privacy-policy).
You can opt-out by running the disableTelemetry() command.

test> 
```

## Connecting to Remote MongoDB Server

To connect to a MongoDB instance running on a remote host on port 27017 with authentication in place:

```
mongosh "mongodb://localhost:27017" --username root -p

Enter password: ********
Current Mongosh Log ID:	6378743da440589326e2c8a2
Connecting to:		mongodb://<credentials>@localhost:27017/?directConnection=true&serverSelectionTimeoutMS=2000&appName=mongosh+1.6.0
Using MongoDB:		6.0.3
Using Mongosh:		1.6.0

For mongosh info see: https://docs.mongodb.com/mongodb-shell/

------
   The server generated these startup warnings when booting
   2022-11-19T05:05:35.135+00:00: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine. See http://dochub.mongodb.org/core/prodnotes-filesystem
   2022-11-19T05:05:36.020+00:00: vm.max_map_count is too low
------

------
   Enable MongoDB's free cloud-based monitoring service, which will then receive and display
   metrics about your deployment (disk utilization, CPU, operation statistics, etc).
   
   The monitoring data will be available on a MongoDB website with a unique URL accessible to you
   and anyone you share the URL with. MongoDB may use this information to make product
   improvements and to suggest MongoDB products and deployment options to you.
   
   To enable free monitoring, run the following command: db.enableFreeMonitoring()
   To permanently disable this reminder, run the following command: db.disableFreeMonitoring()
------

test> 
```

## Switch to a new database

On a fresh connection, the MongoDB shell will automatically connect to the test database by default. You can safely use this database to experiment with MongoDB and the MongoDB shell.

Alternatively, you could also switch to another database to run all of the example commands given in this tutorial. To switch to another database, run the use command followed by the name of your database:

```
test> use collabnix
switched to db collabnix
collabnix> 
```

## Performing CRUD operation

Let's assume that we have the following document in the form of JSON:

```
{
    "name": "Docker Meetup",
    "city": "Singapore",
    "country": "India",
    "gps": {
        "lat": 12.9716,
        "lng": 77.5946
    }
}
```

Insert this document into a new collection called collabnix using the insertOne method. As its name implies, insertOne is used to create individual documents, as opposed to creating multiple documents at once.

In the MongoDB shell, run the following operation:

```
db.meetup.insertOne(
  {
    "name": "Docker Meetup",
    "city": "Singapore",
    "country": "India",
    "gps": {
        "lat": 12.9716,
        "lng": 77.5946
    }
}
)
```

Copy the content and paste it in the terminal:

```
collabnix> db.meetup.insertOne(
 {
 "name": "Docker Developer Meetup",
    "city": "Bangalore",
    "country": "India",
     "gps": {
        "lat": 12.9716,
         "lng": 77.5946
    }
 }
 )
```

```
{
  acknowledged: true,
  insertedId: ObjectId("637875b9a440589326e2c8a4")
}
collabnix>
```

The operation’s output will inform you that it executed successfully, and also provides the ObjectId which it generated automatically for the new document.

## Verifying the document 

```
collabnix> db.meetup.countDocuments()
1
collabnix> 
```

You can verify that the document was inserted by checking the object count in the `Meetup` collection

## Inserting Multiple Documents

Inserting documents one by one like this would quickly become tedious if you wanted to create multiple documents. MongoDB provides the `insertMany` method which you can use to insert multiple documents in a single operation.

```
collabnix> db.meetup.insertMany([
   {"name": "Docker Developer Meetup", "city": "Bangalore", "country": "India", "gps": { "lat": 12.9716, "lng": 77.5946 }},
   {"name": "Docker Developer Meetup", "city": "Hyd", "country": "India", "gps": { "lat": 17.3850, "lng": 17.4867 }},
 {"name": "Docker Developer Meetup", "city": "Chennai", "country": "India", "gps": { "lat": 13.0710, "lng": 18.2946 }},
 {"name": "Docker Developer Meetup", "city": "Pune", "country": "India", "gps": { "lat": 18.5688, "lng": 73.8946 }},
 ])
```

```
{
  acknowledged: true,
  insertedIds: {
    '0': ObjectId("6378779ea440589326e2c8a5"),
    '1': ObjectId("6378779ea440589326e2c8a6"),
    '2': ObjectId("6378779ea440589326e2c8a7"),
    '3': ObjectId("6378779ea440589326e2c8a8")
  }
}
collabnix>
```

## Verifying the documents inserted 

```
collabnix> db.meetup.countDocuments()
5
collabnix>
```

## Finding the Documents

```
collabnix> db.meetup.find()
[
  {
    _id: ObjectId("637875b9a440589326e2c8a4"),
    name: 'Docker Developer Meetup',
    city: 'Bangalore',
    country: 'India',
    gps: { lat: 12.9716, lng: 77.5946 }
  },
  {
    _id: ObjectId("6378779ea440589326e2c8a5"),
    name: 'Docker Developer Meetup',
    city: 'Bangalore',
    country: 'India',
    gps: { lat: 12.9716, lng: 77.5946 }
  },
  {
    _id: ObjectId("6378779ea440589326e2c8a6"),
    name: 'Docker Developer Meetup',
    city: 'Hyd',
    country: 'India',
    gps: { lat: 17.385, lng: 17.4867 }
  },
  {
    _id: ObjectId("6378779ea440589326e2c8a7"),
    name: 'Docker Developer Meetup',
    city: 'Chennai',
    country: 'India',
    gps: { lat: 13.071, lng: 18.2946 }
  },
  {
    _id: ObjectId("6378779ea440589326e2c8a8"),
    name: 'Docker Developer Meetup',
    city: 'Pune',
    country: 'India',
    gps: { lat: 18.5688, lng: 73.8946 }
  }
]
collabnix>
```

