#!/bin/bash
rm -rf /srv/tmp/cert/challenge
mkdir -p /srv/tmp/cert/challenge
certbot certonly -n --webroot --webroot-path /srv/tmp/cert/challenge --agree-tos --email $MY_EMAIL -d $1
cp -RL /etc/letsencrypt/live/* /srv/data/cert
chmod -R 775 /srv/data/cert
rm -rf /srv/tmp/cert/challenge
nginx -s reload