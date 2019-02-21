CONTROL_IMAGE_NAME=self2face
CONTROL_IMAGE_TAG=ctl
CONTROL_IMAGE_DOCKERFILE=ctl/docker/Dockerfile.ctl
CONTROL_IMAGE_PATH=ctl/

if [ ! "$(docker images | grep $CONTROL_IMAGE_NAME | grep $CONTROL_IMAGE_TAG | wc -l)" -gt "0" ]
then
    ## Building non existing docker images
    docker build -t $CONTROL_IMAGE_NAME:$CONTROL_IMAGE_TAG -f $CONTROL_IMAGE_DOCKERFILE $CONTROL_IMAGE_PATH
fi

## Image now exists 
docker run \
       --rm \
       --net host \
       -v $(pwd)/$CONTROL_IMAGE_PATH:/root/ctl \
       -v ~/.kube:/root/.kube:z \
       -v ~/.helm:/root/.helm:z \
       -v ~/.minikube:/root/.minikube:z \
       -v /var/run/docker.sock:/var/run/docker.sock:z \
       -w /root/ctl \
       -it $CONTROL_IMAGE_NAME:$CONTROL_IMAGE_TAG \
       $@


