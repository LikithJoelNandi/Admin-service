#!/usr/bin/env bash
port=8080
docker stop admin-service
docker rm admin-service
docker rmi admin-service
docker run -i -d -p 8889:8888 --name admin-service -t demo/admin-service
