sh -c "(kubectl port-forward -n kubeflow svc/ambassador 7222:80 &
        kubectl port-forward -n kube-system svc/kubernetes-dashboard 7333:80 &
        kubectl port-forward -n default svc/minio 7444:9000)"
