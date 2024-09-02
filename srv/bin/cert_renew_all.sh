#!/bin/bash
rm -rf /srv/tmp/cert/challenge
mkdir -p /srv/tmp/cert/challenge
certbot renew -n --webroot --webroot-path /srv/tmp/cert/challenge --agree-tos --email $MY_EMAIL
cp -RL /etc/letsencrypt/live/* /srv/data/cert 2>/dev/null || :
chmod -R 775 /srv/data/cert
rm -rf /srv/tmp/cert/challenge
