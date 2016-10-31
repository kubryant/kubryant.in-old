#!/bin/bash
cd /webapp

hash docker-compose 2>/dev/null || sleep 60
cat certs/dhparams.pem 2>/dev/null || sleep 120

docker-compose -f docker-compose.production.yml up --build -d > docker-kubryant.log
