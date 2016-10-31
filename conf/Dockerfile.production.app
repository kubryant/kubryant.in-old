FROM golang:latest
MAINTAINER Bryant Ku <ku.bryant@gmail.com>

COPY . /go/src/github.com/kubryant/kubryant.in
WORKDIR /go/src/github.com/kubryant/kubryant.in

RUN go get -u github.com/jteeuwen/go-bindata/... && make server

ENTRYPOINT ./kubryant.in
