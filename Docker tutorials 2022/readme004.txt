minikube version
Start a Kubernetes cluster
minikube start
kubectl version
kubectl cluster-info
To view the nodes in the cluster:
kubectl get nodes
Deploy your first app:
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
I find a suitable node,where an instance of the application could be run,
To list your deployments:
kubectl get deployments
Pods that are running inside Kubernetes are running on a private, isolated network
We will open a second terminal window to run the proxy( forward communications into the cluster-wide)
Open second terminal tab:
kubectl proxy
We now have a connection between our host (terminal) and the Kubernetes cluster
Let's open http://localhost:8001/version
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME
Access the POD:
http://localhost:8001/api/v1/namespaces/default/pods/$POD_NAME
A Pod is a Kubernetes abstraction that represents a group of one or more application containers (such as Docker)
Pods are the atomic unit on the Kubernetes platform
each pod has an ip address
A Pod always runs on a Node
Each Node is managed by the control plane
A Node can have multiple pods
Kubelet, a process responsible for communication between the Kubernetes control plane and the Node
kubectl get pods
To view what containers are inside that Pod and what images are used to build those containers
kubectl describe pods
Show logs for the container within the Pod:
kubectl logs $POD_NAME
Executing command on the container:
kubectl exec $POD_NAME -- env
start a bash session in the Pod’s container:
kubectl exec -ti $POD_NAME -- bash
cat server.js
Check that the application is up by running a curl command:
Services enable a loose coupling between dependent Pods
kubectl get services
We have a Service called kubernetes that is created by default 
To create a new service and expose it to external traffic:
kubectl get deployments
kubectl expose deployment/kubernetes-bootcamp --type="NodePort" --port 8080
kubectl get services
To find out what port was opened externally:
kubectl describe services/kubernetes-bootcamp
Create an environment variable called NODE_PORT that has the value of the Node port assigned:
export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT
Test that the app is exposed outside of the cluster:
curl $(minikube ip):$NODE_PORT
You can see the name of the label:
kubectl describe deployment
see "Labels"
Let’s use this label to query our list of Pods:
kubectl get services -l app=kubernetes-bootcamp
Get the name of the Pod and store it in the POD_NAME environment variable:
export POD_NAME=$(kubectl get pods -o go-template --template '{{range .items}}{{.metadata.name}}{{"\n"}}{{end}}')
echo Name of the Pod: $POD_NAME
To apply a new label:
kubectl label pods $POD_NAME version=v1
kubectl describe pods $POD_NAME
we can query now the list of pods using the new label:
kubectl get pods -l version=v1
To delete Services:
kubectl delete service -l app=kubernetes-bootcamp
kubectl get services
This proves that the app is not reachable anymore from outside of the cluster:
curl $(minikube ip):$NODE_PORT
Confirm that the app is still running:
kubectl exec -ti $POD_NAME -- curl localhost:8080
kubectl exec -ti $POD_NAME -- ls -la

Running Multiple Instances of Your App
Scaling = changing the number of replicas in a Deployment
Scaling will increase the number of Pods
kubectl get deployments
To see the ReplicaSet created by the Deployment:
kubectl get rs
ReplicaSet's format: [DEPLOYMENT-NAME]-[RANDOM-STRING]
DESIRED = desired number of replicas of the application
CURRENT = how many replicas are currently running
how many replicas are currently running
Let’s scale the Deployment to 4 replicas
kubectl scale deployments/kubernetes-bootcamp --replicas=4
Now there are 4 pods:
kubectl get pods -o wide
kubectl describe deployments/kubernetes-bootcamp

To find out the exposed IP and Port:
kubectl describe services/kubernetes-bootcamp
Create an environment variable called NODE_PORT:
export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT
Send multiple request and check:
curl $(minikube ip):$NODE_PORT
Every time you run the curl command, you will hit a different Pod

Performing a Rolling Update
Developers are expected to deploy new versions of them several times a day
updated app has new ip address
kubectl get deployments
kubectl get pods
To view the current image version of the app:
kubectl describe pods
And look for the Image field
To update the image of the application to version 2
kubectl set image deployments/kubernetes-bootcamp kubernetes-bootcamp=jocatalin/kubernetes-bootcamp:v2
Verify an update:
kubectl describe services/kubernetes-bootcamp
export NODE_PORT=$(kubectl get services/kubernetes-bootcamp -o go-template='{{(index .spec.ports 0).nodePort}}')
echo NODE_PORT=$NODE_PORT
Next, do a curl to the the exposed IP and port:
curl $(minikube ip):$NODE_PORT
To roll back the deployment to your last working version, use the rollout undo command:
kubectl rollout undo deployments/kubernetes-bootcamp





























