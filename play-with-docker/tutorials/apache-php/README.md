## Command to setup Apache Web Server using Docker

Step-1: Create a index.html page anywhere on your system

cat index.html

<html><body> Hello</body> </html>

Step-2: Run the below to run Docker container with index.html mounted directly into the container from outside

```
docker run -d -p 80:80 -v /root/index.html:/var/www/html/index.html eboraas/apache-php
9f9fd19580badd21e98259e597d74106ad9edbfd7d95fb37a1554b8f1ba5f944
```
