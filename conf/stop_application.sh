#!/bin/bash

docker-compose -f $(dirname $0)/../docker-compose.dev.yml down
