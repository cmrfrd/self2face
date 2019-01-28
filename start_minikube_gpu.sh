## Create minikube profile
## for kubeconfig isolation
minikube profile self2face

## start minikube with gpu
## and profile
minikube start \
	 --memory=10192 \
	 --cpus=8 \
	 --disk-size=42GB \
	 --vm-driver=kvm2 \
	 --gpu \
	 --insecure-registry localhost:5000 \
	 --profile self2face

## Add nvidia plugins
## for gpu access
minikube addons enable nvidia-gpu-device-plugin
minikube addons enable nvidia-driver-installer

## Mount current working directory
## into minikube for pod access
minikube mount $(pwd):/mnt &

