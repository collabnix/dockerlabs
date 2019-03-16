FROM alpine:3.6

RUN apk add --update nginx && rm -fr /var/cache/apk/*

CMD["nginx", "-g", "daemon off;"]
