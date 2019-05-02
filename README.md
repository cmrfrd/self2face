## Self 2 Face

Upload, simulate, and control your face using machine learning

### How to run this repo

#### Step 1 start minikube

Choose between cpu or gpu version

``` shell
$ ./start_minikube.sh
```

#### Step 2 access control

Create and access a `control` (`ctl`) container with tools to control the cluster

``` shell
$ ./access_cluster_ctl.sh
```

#### Step 3 Build container

Build the jupyter self2face container

``` shell
$ source minikube-env.sh
$ docker-compose -f dockerfiles/docker-compose.yml build
```

#### Step 4 Deploy kubeflow

Deploy kubeflow on minikube and mount local directory as pvc via shell script (configure to preference)

``` shell
$ ./bin/deploy_kubeflow.sh
$ ./bin/create_host_pvc.sh
```

#### Step 5 Access kubeflow components

Access components via port forwarding

``` shell
$ ./bin/forward_ports.sh
```

### Directory structure

* `pci_passthrough/`
  
  Setup and description for how to do pci passthrough into a virtual machine. This is used to create a single node kubernetes cluster with gpu access 

* `ctl/`

  Control scripts and environment for interacting with the single node kubernetes cluster

* `models/`

  Directory to store exported models

* `notebooks/`

  Directory to store all notebooks acting as documenatation and code
