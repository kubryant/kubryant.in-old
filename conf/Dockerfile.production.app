FROM golang:latest
MAINTAINER Bryant Ku <ku.bryant@gmail.com>

COPY ./kubryant.in /go/src/github.com/kubryant/kubryant.in/kubryant.in
WORKDIR /go/src/github.com/kubryant/kubryant.in

ENTRYPOINT ./kubryant.in
