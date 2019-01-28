docker run \
       --rm \
       --net host \
       -v $(pwd)/ctl:/home/ctl \
       -v ~/.kube:/root/.kube:z \
       -v ~/.helm:/root/.helm:z \
       -v ~/.minikube:/root/.minikube:z \
       -w /home/ctl \
       -it self2face:ctl \
       $@
