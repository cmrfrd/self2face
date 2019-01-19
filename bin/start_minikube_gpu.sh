minikube profile self2face

minikube start \
	 --memory=10192 \
	 --cpus=8 \
	 --disk-size=30GB \
	 --vm-driver=kvm2 \
	 --gpu \
	 --insecure-registry localhost:5000 \
	 --profile self2face

minikube addons enable nvidia-gpu-device-plugin
minikube addons enable nvidia-driver-installer

minikube mount $(pwd):/mnt &

eval $(minikube docker-env)
