# Mongo Express Extension for Docker Desktop

Mongo Express is a web-based MongoDB admin interface written with Node.js, Express and Bootstrap3.
With Mongo Express Docker Extension, now you can setup Mongo Express along with MongoDB with few clicks.

> This is Work-in-progress
- [x] Building Compose File
- [x] Constructing UI
- [ ] Final Testing

<img width="1372" alt="image" src="https://user-images.githubusercontent.com/313480/200106477-172ed89e-f1b5-402a-b45d-56dc9c4d724d.png">



## Getting Started


```
 git clone https://github.com/collabnix/mongoexpress-docker-extension
```

## Build the Extension

```
 make build-extension
```

## Install the Extension

```
 docker extension install ajeetraina/mongodb-express-docker-extension:1.0
```


Accessing Mongo Express using Extensions Dashboard

<img width="1373" alt="image" src="https://user-images.githubusercontent.com/313480/200106485-91a8516b-ec16-48f2-b37f-f8c57ed9966c.png">


## Connecting to Remote MongoDB Server

To connect to a MongoDB instance running on a remote host on port 27017 with authentication in place, you can directly open the container terminal via Docker Dashboard:

<img width="1227" alt="image" src="https://user-images.githubusercontent.com/34368930/203964086-001e7a83-8ca7-4e39-840c-bd0133ea844b.png">




```
mongosh "mongodb://localhost:27017" --username root -p
```

Add "example" as the password.


## Add a collection

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
    "name": "Docker Developer Meetup",
    "city": "Bangalore",
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

## Copy the content and paste it in the terminal:

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

<img width="1189" alt="image" src="https://user-images.githubusercontent.com/34368930/203964684-b729ff5f-43a4-4330-a020-a84765fa3e3e.png">

## Viewing the Document


<img width="1511" alt="image" src="https://user-images.githubusercontent.com/34368930/203964742-b4ddf862-6d7d-4a1b-8729-5fdd973bed21.png">

1
