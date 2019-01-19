minikube profile self2face

minikube start \
	 --memory=10192 \
	 --cpus=8 \
	 --disk-size=30GB \
	 --insecure-registry localhost:5000 \
	 --profile serverless_datascience

minikube mount $(pwd):/mnt &

eval $(minikube docker-env)
