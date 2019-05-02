## Setup variable configuration
export HOME_DIR=$(pwd)
export PATH_PREFIX=${1:-mnt}
export KUBEFLOW_TAG=${2:-v0.4.1}
export KUBEFLOW_SRC=${3:-kubeflow-src}
export KF_APP=${4:-kubeflow-app}

## Make download path and change to directory
download_path=${HOME_DIR}/${PATH_PREFIX}/${KUBEFLOW_SRC}/${KUBEFLOW_TAG}
echo "Downloading kubeflow to $download_path ..."
mkdir -p $download_path
cd $download_path

## download kubeflow
TMPDIR=$(mktemp -d)
curl -L -o ${TMPDIR}/kubeflow.tar.gz https://github.com/kubeflow/kubeflow/archive/${KUBEFLOW_TAG}.tar.gz
tar xzvf ${TMPDIR}/kubeflow.tar.gz  -C ${TMPDIR}
## GitHub seems to strip out the v in the file name.
KUBEFLOW_SOURCE=$(find ${TMPDIR} -maxdepth 1 -type d -name "kubeflow*")
cp -r ${KUBEFLOW_SOURCE}/kubeflow ./
cp -r ${KUBEFLOW_SOURCE}/scripts ./

## Remove any existing kubeflow app
app_path=${HOME_DIR}/${PATH_PREFIX}/
echo "Deleting path $app_path if exists ..."
if [ -d $app_path/${KF_APP} ]; then
    rm -r $app_path/${KF_APP}
fi

## Initialize kubeflow to $app_path
## generate ks deployments
## apply generated deployments
KUBEFLOW_REPO=${download_path}
cd $app_path
${download_path}/scripts/kfctl.sh \
		init ${KF_APP} \
		--platform minikube
cd ${app_path}/${KF_APP}
${download_path}/scripts/kfctl.sh generate all
${download_path}/scripts/kfctl.sh apply all
