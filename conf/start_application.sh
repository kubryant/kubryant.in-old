#!/bin/bash

msg "$(pwd)"
msg "$(ls -la)"

docker-compose -f $(dirname $0)/../docker-compose.dev.yml up -d
