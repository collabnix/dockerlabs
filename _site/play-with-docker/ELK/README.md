
# Setting up Elasticsearch, Logstash , Kibana & Filebeat on a Docker Host



## Step 1: Setting up Elasticsearch container

```
docker run -d -p 9200:9200 -p 9300:9300 -it -h elasticsearch --name elasticsearch elasticsearch
```

Verify the functionality:

```
curl http://localhost:9200/
```

## Step 2: Setting up Kibana container

```
docker run -d  -p 5601:5601 -h kibana --name kibana --link elasticsearch:elasticsearch kibana
```

Verifying the functionality

```
curl http://localhost:9200/_cat/indices
```

Open up Kibana. As of now, you will not see any timestamp entry.

## Step 3: Createing a sample logstash config file 


```
$mkdir /config-dir
```
Add the below entry:

```
$ cat logstash.conf
input {
stdin {}
}

output {
   elasticsearch { hosts => ["elasticsearch:9200"] }

}
```

Now use it to setup Logstash container as shown below:

```
docker run -h logstash --name logstash --link elasticsearch:elasticsearch -it --rm -v "$PWD":/config-dir logstash -f /config-dir/logstash.conf
curl http://localhost:9200/_cat/indices
```

Try out random inputs like try1, try2 try3

Open up Kibana console and refresh. You will see a timestamp get added. Click on Discover to see the log entry try1,2,3

## Testing Logging using Port specific examples


Create a logstash2.conf with the below entry:

```
input {tcp{
   port => 8500   }
}
output {   elasticsearch { hosts => ["elasticsearch:9200"] }

}
```

Run the below command:

```
docker run -d -p 8500:8500  -h logstash2 --name logstash2 --link elasticsearch:elasticsearch --rm -v "$PWD":/config-dir logstash -f /config-dir/logstash2.conf
```

Now use telnet command:

```
telnet hostname 8500

ehlo

```

Soon you will see the below logs under Kibana UI:
```
September 14th 2017, 08:45:37.510	@timestamp:September 14th 2017, 08:45:37.510 port:55144 @version:1 host:10.0.43.3 message:ehlo _id:AV5-Yn2vR2tqeamsYNY_ _type:logs _index:logstash-2017.09.14 _score: -
	September 14th 2017, 08:45:33.955	@timestamp:September 14th 2017, 08:45:33.955 port:55144 @version:1 host:10.0.43.3 message: _id:AV5-Ym_TR2tqeamsYNY- _type:logs _index:logstash-2017.09.14 _score: -
	September 14th 2017, 08:45:14.530	@timestamp:September 14th 2017, 08:45:14.530 port:60360 @version:1 host:10.0.43.2 message: _id:AV5-YiP0R2tqeamsYNY9 _type:logs _index:logstash-2017.09.14 _score: -
	September 14th 2017, 08:45:14.529	@timestamp:September 14th 2017, 08:45:14.529 port:60360 @version:1 host:10.0.43.2 message:Referer: http://host4.labs.play-with-docker.com/p/abf1ba23-7fb8-49c0-98e8-e414f52d1b6d _id:AV5-YiP0R2tqeamsYNY8 _type:logs _index:logstash-2017.09.14 _score: -
  </pre>
```

## Setting up FileBeat

Say, you want to collect logs from /var/log/nginx/access.log to logstash.
First run the below command:


```
$docker run -d -p 80:80 nginx -v /var/log:/var/log --name mynginx
```

Now run the below command to collect logs from mynginx container as shown below:

```
$docker run -d --volumes-from mynginx -v /config-dir/filebeat.yml:/usr/share/filebeat/filebeat.yml --name myfilebeat docker.elastic.co/beats/filebeat:5.6.0
```

This will use volume from mynginx container and then push it to filebeat container to push it to elasticsearch to be displayed under Kibana.


