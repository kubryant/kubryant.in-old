#!/bin/bash

docker-compose -f $(dirname $0)/../docker-compose.production.yml up --build -d > docker-kubryant.log
