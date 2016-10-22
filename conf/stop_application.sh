#!/bin/bash

. $(dirname $0)/common_functions.sh
msg "$(pwd)"
msg "$(ls -la)"
docker-compose -f $(dirname $0)/../docker-compose.dev.yml down
