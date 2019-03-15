#!/bin/bash

docker rmi content-server
docker build -t "content-server" .
docker run --rm -it --name server -p 22:22 -p 4000:4000 -e NGINX_PORT=4000 -e CONTENT_PATH=/wwwroot -e CONTENT_AUTH_URL=http://localhost -e USER_NAME=content -e USER_PASSWORD=password content-server

