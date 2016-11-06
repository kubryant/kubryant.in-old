FROM golang:latest
MAINTAINER Bryant Ku <ku.bryant@gmail.com>

COPY . /go/src/github.com/kubryant/kubryant.in
WORKDIR /go/src/github.com/kubryant/kubryant.in

ENTRYPOINT ./kubryant.in
