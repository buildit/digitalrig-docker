#!/bin/sh
eval $(minikube docker-env)
docker build . -t builditdigital/jenkins-master
docker push builditdigital/jenkins-master