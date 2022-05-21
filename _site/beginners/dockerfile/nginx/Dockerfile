FROM alpine:3.6

RUN apk add --update nginx && rm -fr /var/cache/apk/*

COPY nginx.conf /etc/nginx/nginx.conf
COPY index.html /usr/share/nginx/html/index.html

CMD ["nginx", "-g", "daemon off;"]
