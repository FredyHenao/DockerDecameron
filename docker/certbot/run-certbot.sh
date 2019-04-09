#!/usr/bin/env bash

letsencrypt certonly --webroot -w /var/www/letsencrypt -d "$CN" --agree-tos --email "$EMAIL" --non-interactive --text

cp /etc/letsencrypt/live/"$CN"/"$CERT".pem /var/certs/"$CN"/"$CERT".pem
cp /etc/letsencrypt/live/"$CN"/"$PRIVKEY".pem /var/certs/"$CN"/"$PRIVKEY".pem

# Test
#if [ -n "$CN"  ] && [ -n "$EMAIL" ] ; then
#    for i in ${CN//,/ }
#    do
#      sudo chmod -R 777 /var/certs/*
#      mkdir /var/certs/${i}

#      letsencrypt certonly --webroot -w /var/www/letsencrypt -d "$i" --agree-tos --email "$EMAIL" --non-interactive --text
#      cp /etc/letsencrypt/live/"$i"/cert.pem /var/certs/"$i"/cert.pem
#      cp /etc/letsencrypt/live/"$i"/privkey.pem /var/certs/"$i"/privkey.pem
#    done
#fi