#!/bin/bash

CONTAINER_NAME=rancherserver

docker rm -f $CONTAINER_NAME
docker run -d --name $CONTAINER_NAME \
        --restart=unless-stopped \
        -p 8080:8080 \
        -p 9345:9345 \
        --expose 8080 \
        -e VIRTUAL_HOST=rancher.razerdev.com \
	-e VIRTUAL_PORT=8080 \
         rancher/server

