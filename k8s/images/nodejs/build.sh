#!/bin/sh
eval $(minikube docker-env)
docker build . -t builditdigital/node-builder
docker push builditdigital/node-builder