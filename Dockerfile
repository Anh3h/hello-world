FROM golang:1.12-alpine AS build

RUN apk add --no-cache git

RUN go get github.com/golang/example/hello
WORKDIR /go/src/github.com/golang/example/hello

RUN go build -o /bin/HelloWorld

FROM golang:1.12-alpine

COPY --from=build /bin/HelloWorld /bin/HelloWorld
ENTRYPOINT ["/bin/HelloWorld"]
