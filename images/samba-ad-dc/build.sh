#!/bin/sh
eval $(minikube docker-env)
docker build -t builditdigital/samba-ad-dc .
docker push builditdigital/samba-ad-dc