#!/bin/sh
eval $(minikube docker-env)
docker build . -t builditdigital/kube-utils
docker push builditdigital/kube-utils