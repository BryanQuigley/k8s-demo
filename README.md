# Minikube Getting started
I choose to go with Kubernetes and am just targetting a generic K8S cluster. The simplest way to showcase that is just with some VMs locally.

1) Get [Minikube](https://minikube.sigs.k8s.io/docs/start/) installed somewhere it can make VMs (make sure in the libvirt group). Docker should also be installed and working.
2) minikube start --nodes 6 --driver kvm2 --disk-size=5GB --memory=2g
3) minikube addons enable metrics-server #this enables metrics based scaling

# Getting Started

## In the app directory.
1) Make new keys
```
openssl genrsa -out key.pem
openssl req -new -key key.pem -out csr.pem
openssl x509 -req -days 9999 -in csr.pem -signkey key.pem -out cert.pem
```

2) docker build -t bryan/datetime:1 .  # build the docker image
3) minikube image load bryan/datetime:1 # upload it the cluster

## Back to the parent directory.
4) kubectl apply -f . # in the parent directory to apply cluster config.
5) kubectl get pods -o wide # should show us all the pods and what VMs they are running on. There should be 3 running pods.
6) kubectl get hpa # should show cpu utilization and what the cluster scaling will do.
7) Let's try applying a load of a new request every .03 seconds by running ./load.sh .03.  This should get it up to 8 pods running. (After about a minute)
9) Reduce it to ./load.sh .06 for 4 pods.
10) Turn it off to eventually be at 1 pod.

# New version
1) Edit version number in app/package.json to 2
2) kubectl get pods -o wide --watch (in other tab to see what happens)
3) Run ./newimage.sh 2
4) Run ./load.sh to see what version it's on (and what pods are responding)

# Broken new version
1) In the docker file let's accidentally comment out the CMD line and uncomment the CMD line with sleep.
2) Edit version number in app/package.json to 3
3) Run ./newimage.sh 3
4) kubectl get pods -o wide. Note how the new pods have never reached ready state and won't replace the currently existing pods.
5) Run ./load.sh to see that it's still on version 2.

# Fixed version
Let's revert what we did to the docker file above and make a 4 version.


./newimage.sh can be run repeatedly and will automatically bring in new image updates.


TODO:
Certificates should not be included in the image. A volume or ConfigMap makes more sense.
