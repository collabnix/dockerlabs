<h1> Apache Web Server using Docker</h1>

<h2>Step-1: Create a index.html page anywhere on your system</h2>

```
cat index.html

<html><body> Hello</body> </html>
```

<h2>Step-2: Run the below to run Docker container with index.html mounted directly into the container from outside</h2>

```
docker run -d -p 80:80 -v /root/index.html:/var/www/html/index.html eboraas/apache-php

```

Access the page with port 80 and you will see Hello Page.
