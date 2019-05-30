#!/usr/bin/env bash
port=8889
docker stop admin-service
docker rm admin-service
docker rmi admin-service
docker image build -t admin-service - /root/Admin-service/Dockerfile
docker run -d -p 8889:8888 --name admin-service admin-service
