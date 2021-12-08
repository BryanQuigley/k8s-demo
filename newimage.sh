#!/bin/bash

#imageversion=$1
imageversion=`date -u +'%Y%m%d%H%M%S'`

cd app/
echo "docker build -t bryan/datetime:$imageversion ."
docker build -t bryan/datetime:$imageversion .

echo "minikube image load bryan/datetime:$imageversion"
minikube image load bryan/datetime:$imageversion

echo "kubectl set image deployment/datetime datetime=$imageversion"
kubectl set image deployment/datetime datetime=bryan/datetime:$imageversion

