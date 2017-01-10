#!/bin/sh
eval $(minikube docker-env)
docker build . -t rig/k8s/nodejs