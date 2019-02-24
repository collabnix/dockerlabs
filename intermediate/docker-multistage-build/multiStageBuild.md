
# Leveraging docker multi-stage build feature to optimize Dockerfiles


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


Multi-stage build is a new feature requiring Docker 17.05 or higher on the daemon and client. It's useful in building complex/multi step image while keeping them easy to read and maintain.

Keeping the image size down is one of the challenging task while building image. Each instruction in Dockerfile adds a layer to the image.
Also, you need to remember to clean up any dependency/artifactory you don't need later. Earlier you might have used shell scripts
to keep layers light as much as possible. Using shell tricks to write a really efficient Dockerfile is a painful task.

## Try multi-stage builds

With multi-stage builds, you can have multiple `FROM` statement in a single Dockerfile. Each `FROM` statement make one stage.
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

Let's see an example to demonstrate multi-stage builds.



