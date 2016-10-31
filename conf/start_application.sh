#!/bin/bash
cd /webapp

hash docker-compose 2>/dev/null || sleep 60
cat certs/dhparams.pem 1>/dev/null 2>/dev/null || openssl dhparam -out /webapp/certs/dhparams.pem 2048

docker-compose -f docker-compose.production.yml up --build -d > docker-kubryant.log
