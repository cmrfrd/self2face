CONTROL_IMAGE_NAME=self2face
CONTROL_IMAGE_TAG=ctl
CONTROL_IMAGE_DOCKERFILE=ctl/dockerfiles/Dockerfile.ctl
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
       -e HOME=$HOME \
       -v $(pwd)/$CONTROL_IMAGE_PATH:$HOME/ctl \
       -v ~/.kube:$HOME/.kube:z \
       -v ~/.helm:$HOME/.helm:z \
       -v ~/.minikube:$HOME/.minikube:z \
       -v /var/run/docker.sock:/var/run/docker.sock:z \
       -w $HOME/ctl \
       -it $CONTROL_IMAGE_NAME:$CONTROL_IMAGE_TAG \
       $@


