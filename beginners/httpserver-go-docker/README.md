
<<<<<<< HEAD
=======

```
git clone https://github.com/sangam14/httpserver-go-docker
```
As you may know Go 1.11 includes opt-in feature for versioned modules. Before go modules Gophers used dependency managers like `dep` or `glide`, but with go modules you don't need a 3rd-party manager as they are included into standard `go` toolchain.

Also modules allow for the deprecation of the GOPATH, which was a blocker for some newcomers in Go.

I am going to demonstrate how to enable go modules for your program and then package it with Docker. And you will see how easy it is.

## Create a project

Let's create simple http server which will use logrus package for logging.

As I said before go modules is an opt-in feature, which can be enabled by setting environment variable `GO111MODULE=on`.

```bash
export GO111MODULE=on
mkdir httpserver && cd httpserver
go mod init
go get github.com/sirupsen/logrus
```

2 new files have been created in our folder: go.mod and go.sum.

```go
package main

import (
	"fmt"
	"net/http"

	log "github.com/sirupsen/logrus"
)

func main() {
	http.Handle("/", loggingMiddleware(http.HandlerFunc(handler)))
	http.ListenAndServe(":8080", nil)
}

func handler(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "package main #14")
}

func loggingMiddleware(next http.Handler) http.Handler {
	return http.HandlerFunc(func(w http.ResponseWriter, req *http.Request) {
		log.Infof("uri: %s", req.RequestURI)
		next.ServeHTTP(w, req)
	})
}
```

Now if we run `go build` it will download deoendencies and build a binary:

```bash
go build
./httpserver
```

## Package with Docker

Let's create a simple Dockerfile for our server.

```
FROM golang

ENV GO111MODULE=on

WORKDIR /app

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

EXPOSE 8080
ENTRYPOINT ["/app/httpserver"]
```

```bash
docker build -t httpserver .
docker run -p 8080:8080 httpserver
```

## Cache go modules

As you can see `go build` downloads our dependencies. But what is not good here is that it will do it every time we build an image. And imagine if your project have a lot of dependencies, it will slow down your build process. Let's change something in main.go file and run build again.

To fix this we can use `go mod download` which will download dependencies first. But we should re-run it if our go.mod / go.sum files have been changed.

We can do it by copying go.mod / go.sum files into docker first, then run `go mod download`, then copy all other files and run `go build`.

```
FROM golang

ENV GO111MODULE=on

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

EXPOSE 8080
ENTRYPOINT ["/app/httpserver"]
```

## Multi-stage build

One more thing I like to do with my Dockerfiles is to use multi-stage build to reduce the size of final image. To run our server we only need a binary file, we don't need the go installed, so inside one Dockerfile we can build program first using `golang` image, and then copy only a binary from it to scratch.

```
# build stage
FROM golang as builder

ENV GO111MODULE=on

WORKDIR /app

COPY go.mod .
COPY go.sum .

RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

# final stage
FROM scratch
COPY --from=builder /app/httpserver /app/
EXPOSE 8080
ENTRYPOINT ["/app/httpserver"]
```

## Conclusion

So I think go modules is a nice feature, and you definitely should try it, I use it in all my services I write. Of course it needs some improvements, but it works well in practice.

>>>>>>> 92ac0a1e08268a15f149bf1f07041a3ea7509110
