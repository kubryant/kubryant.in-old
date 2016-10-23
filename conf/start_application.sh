#!/bin/bash

hash docker-compose 2>/dev/null || sleep 60

docker-compose -f $(dirname $0)/../docker-compose.production.yml up --build -d > docker-kubryant.log
