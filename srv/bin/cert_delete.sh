#!/bin/bash
certbot delete -n --cert-name $1
nginx -s reload
