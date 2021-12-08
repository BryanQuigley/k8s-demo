#!/bin/bash

SLEEPTIME="${1:-.1}"

url=`minikube service datetime-service --url | cut -c 5-`

echo "Try it once to make sure it's working"
wget  --no-check-certificate   -O- "https"$url

while true
do
    wget -q  --no-check-certificate   -O- "https"$url | cut -f 4,16 -d ' ' &
    sleep $SLEEPTIME
done