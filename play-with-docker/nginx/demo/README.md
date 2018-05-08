# Quick 10 Examples with Nginx

## #1: Bringing up a simple Nginx Page

```
docker run -d -p 80:80 nginx
```

## #2: Bringing up another Nginx Instance

```
docker run -d -p 81:80 nginx
```

## #3: Bringing up Hello Whale Page

```
docker run -d -p 82:80 ajeetraina/hellowhale
```

## #4: How to customize your Webpage using Nginx container

- Create a directory called mysite1
- Under this direcotry, create a file called index.html

```
<html>
<body>
<h1> Hello World ! I am running inside Docker Container
</h1>
</body>
</html>
```

Now run the below command:

```
$ docker run -d -p 86:80 -v /root/mysite1/:/usr/share/nginx/html/ nginx
```

Go ahead change the font and refresh the page at 86 to see how font gets changed.

## #5: 
