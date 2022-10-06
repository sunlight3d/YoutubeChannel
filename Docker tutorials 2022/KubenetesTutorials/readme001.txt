Orchestration Tools = Tools to manage, scale, and maintain containerized applications
Kubenetes Clusters, Docker Swarm,...
A Pod can contains many Containers
How to test Kubenetes is running:
- Create a .yaml configuration file(podTest.yaml)
- Create a Pod from this .yaml file
kubectl apply -f podTest.yaml

You must start a cluster firstly !
minikube is local Kubernetes, focusing on making it easy 
to learn and develop for Kubernetes

#Start a cluster:
minikube start

#show pods:
kubectl get pods
kubectl get pod "pod's name" --watch

Delete Pod
kubectl delete pod "pod's name"  

brew install kompose
kompose -f docker-compose.dev.yml convert

https://kubernetes.io/docs/tasks/configure-pod-container/translate-compose-kubernetes/
