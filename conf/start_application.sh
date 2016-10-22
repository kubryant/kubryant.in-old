#!/bin/bash

. $(dirname $0)/common_functions.sh
msg "Logging from inside of start_application with pwd: $(pwd)"

docker-compose -f $(dirname $0)/../docker-compose.dev.yml up -d
