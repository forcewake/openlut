#!/bin/bash

USER="$1"
if [ -z $USER ]; then USER="sofus"; fi

REMOTE="${USER}@wakingnexus"

#Remove the old docs.
ssh $REMOTE 'bash -s'  << 'ENDSSH'

rm -rf /var/www/openlut/*

ENDSSH

#Sync over the new docs.
rsync -avzP build/html/* $REMOTE:/var/www/openlut/

#Set strong permissions.
ssh $REMOTE 'bash -s'  << 'ENDSSH'

chown -R $USER:www-data /var/www/openlut/*
find /var/www/openlut -type f -exec chmod 0640 {} \;
find /var/www/openlut -type d -exec chmod 2750 {} \;

ENDSSH
