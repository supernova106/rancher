#!/bin/bash

CONTAINER_NAME=nginx-proxy

docker rm -f $CONTAINER_NAME
docker run -d --name $CONTAINER_NAME \
        --restart=unless-stopped \
        -p 80:80 \
        -v /var/run/docker.sock:/tmp/docker.sock:ro \
        jwilder/nginx-proxy

