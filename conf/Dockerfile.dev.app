FROM golang:latest
MAINTAINER Bryant Ku <ku.bryant@gmail.com>

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash - && apt-get install -y nodejs
RUN go get -u github.com/jteeuwen/go-bindata/... && go get -u github.com/yosssi/goat/...
RUN apt-get install -y psmisc

WORKDIR /go/src/github.com/kubryant/kubryant.in

ENTRYPOINT goat
