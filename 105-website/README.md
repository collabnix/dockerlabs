Under 105-website, let us look at how to create a Dockerfile which set up a simple webpage for us.

First, we will build a Docker Image shown below:


master==>cd 105-website/
master==>ls
Dockerfile  html  wrapper.sh
master==>vi Dockerfile 
master==>docker build -t ajeetraina/nginx_105_demo .
Sending build context to Docker daemon 30.21 kB
Step 1/4 : FROM nginx
latest: Pulling from library/nginx
693502eb7dfb: Already exists 
6decb850d2bc: Pull complete 
c3e19f087ed6: Pull complete 
Digest: sha256:52a189e49c0c797cfc5cbfe578c68c225d160fb13a42954144b29af3fe4fe335
Status: Downloaded newer image for nginx:latest
 ---> 6b914bbcb89e
Step 2/4 : COPY wrapper.sh /
 ---> 70297381661d
Removing intermediate container 4e5d9e435617
Step 3/4 : COPY html /usr/share/nginx/html
 ---> 25adcbc67425
Removing intermediate container 8eb8ee64131f
Step 4/4 : CMD ./wrapper.sh
Step 4/4 : CMD ./wrapper.sh
 ---> Running in f4721b3f6421
 ---> c6c187264fad
Removing intermediate container f4721b3f6421
Successfully built c6c187264fad


Let us verify if Docker Image is built or NOT:

master==>docker images
REPOSITORY                        TAG                 IMAGE ID            CREATED             SIZE
ajeetraina/nginx_105_demo         latest              c6c187264fad        7 seconds ago       182 MB

