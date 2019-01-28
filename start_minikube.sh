## Create minikube profile  
## for kubeconfig isolation
minikube profile self2face

## Start minikube without
## gpu access under profile
minikube start \
	 --memory=10192 \
	 --cpus=8 \
	 --disk-size=30GB \
	 --insecure-registry localhost:5000 \
	 --profile serverless_datascience

## Mount current working directory                       
## into minikube for pod access
minikube mount $(pwd):/mnt &
