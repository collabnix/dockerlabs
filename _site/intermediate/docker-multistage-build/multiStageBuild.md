
# Leveraging Docker Multi-Stage Builds Feature to optimize Dockerfiles/Images


Multi-stage builds are a new feature requiring **Docker 17.05** or higher on the daemon and client. It's useful in building complex/multi step image while keeping them easy to read and maintain.

Keeping the image size down is one of the challenging task while building image. Each instruction in Dockerfile adds a layer to the image.
Also, you need to remember to clean up any dependency/artifactory you don't need later. Earlier you might have used shell scripts
to keep layers light as much as possible. Using shell scripts, tricks to write a really efficient Dockerfile is a painful task.


## What exactly is Multi-Stage Builds? 

In simple terms: you can use end result (for ex: binary/executable file) of one stage into another stage without worrying about dependencies used to build that binary/executable file. 

## How does it work?

With Multi-stage builds, you can have multiple `FROM` statement in a single Dockerfile. Each `FROM` statement contributes to one stage.
First stage starts from number `0`.

```
FROM mhart/alpine-node:10  #stage 0

....
...

FROM alpine:3.7 #stage 1
```

Here order of stage matters as the first stage will always be `0`. Another way is to give name to the `stage` by using `AS`.
In that case you don't have to worry about order.


```
FROM mhart/alpine-node:10 AS nodebuilder

....
...

FROM alpine:3.7 AS builder
```

# Demonstrating Multi-Stage Builds

## Tested Infrastructure

<table class="tg">
  <tr>
    <th class="tg-yw4l"><b>Platform</b></th>
    <th class="tg-yw4l"><b>Number of Instance</b></th>
    <th class="tg-yw4l"><b>Reading Time</b></th>
    
  </tr>
  <tr>
    <td class="tg-yw4l"><b>Play with Docker</b></td>
    <td class="tg-yw4l"><b>1</b></td>
    <td class="tg-yw4l"><b>5 min</b></td>
    
  </tr>
  
</table>



For demonstration, Let us consider a nodejs project and build a binary out of it. When you execute this binary, it will call a [NASA api](https://api.nasa.gov/api.html) which returns some interesting facts about today's date.

#### Before: docker images

![Before docker images list](https://github.com/kumarrishav/dockerlabs/blob/patch-2/images/multi-stage-img1.png)

Currently we have two images which I pulled from [dockerhub](https://hub.docker.com/): 
* `alpine (~4Mb)` - Lightest version of linux os
* `alpine-node (~70Mb)` - alpine + Node/Npm and other dependency.

#### File structure

![file structure](https://github.com/kumarrishav/dockerlabs/blob/patch-2/images/multi-stage-img2.png)

* `Dockerfile`:
  
  * On stage 0 (alias: `builder`), we have a `alpine-node` OS which has `node` and `npm` built in it. Its size is `~70Mb`. This stage will create binary (named as `nasa` : _Line 6_) in the current `WORKDIR` i.e `app/`.  
  * On stage 1, we have `alpine` OS. After that, we install some necessary dependencies. In `Line 14`, we copied `nasa` binary from previous stage (`builder`) to current stage. So, we just copied binary and leaving all heavy `alpine-node` OS and other dependencies like `npm` ([node package manager](https://www.npmjs.com/)) etc as binary already have required dependecies (like nodejs) built in it.
  
* `app/` : It's just a simple node application. It does a `https` call and fetches data using nasa api. It has `index.js` and `package.json`. I have used `pkg` to build the node binary.


#### After: docker images

![After docker images list](https://github.com/kumarrishav/dockerlabs/blob/patch-2/images/multi-stage-img3.png)

 **multistage:1.0.0** (`56b102754f6d`) is the final required image which we built. Its size is `~45Mb`. Almost **1/4th** of the intermediate image(`13bac50ebc1a`) built on stage 0. And almost **half** of `alpine-node` image.
 
 
 So, this was a simple example to showcase multi-stage builds feature. For images having multi step (like 10-15 FROM statement), you will find this feature very useful. 
 
### Use an external image as a "stage"
When using multi-stage builds, you are not limited to copying from stages you created earlier in your Dockerfile. You can use the `COPY --from` instruction to copy from a separate image, either using the local image name, a tag available locally or on a Docker registry, or a tag ID. The Docker client pulls the image if necessary and copies the artifact from there. The syntax is:

`COPY --from=sampleapp:latest home/user/app/config.json app/config.json`

------------------------------------------------------------------------------------------------------------------------------


 
 # Contributor
 
[Kumar Rishav](https://www.linkedin.com/in/rishav006/)


