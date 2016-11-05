#!/bin/bash 
cd ~

# get dependencies
pip install awscli --upgrade
yum update -y
yum install -y docker
wget https://s3.amazonaws.com/aws-cloudwatch/downloads/latest/awslogs-agent-setup.py
wget https://aws-codedeploy-us-east-1.s3.amazonaws.com/latest/install
curl -L "https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m)" > /usr/bin/docker-compose

# install
chmod +x ./awslogs-agent-setup.py
chmod +x ./install
chmod +x /usr/bin/docker-compose

sudo ./install auto

python awslogs-agent-setup.py -n -r us-east-1 -c s3://kubryant/cloudwatch.conf
service awslogs restart

service docker restart
usermod -a -G docker ec2-user

# ssl
mkdir -p /webapp
aws s3 cp s3://kubryant-secure /webapp --recursive
openssl dhparam -out /webapp/certs/dhparams.pem 2048

# dehydrated
cd /webapp
aws s3 cp s3://kubryant/dehydrated /webapp --recursive
wget https://raw.githubusercontent.com/lukas2511/dehydrated/master/dehydrated
chmod +x ./dehydrated
chmod +x ./hook.sh

mv /webapp/dehydrated.cron /etc/cron.daily
chmod +x /etc/cron.daily/dehydrated.cron
