#!/bin/bash
ls /etc/kubernetes/manifests/
echo
kubectl get pods -n kube-system -l tier=control-plane -o wide
echo
for component in kube-apiserver etcd kube-scheduler kube-controller-manager; do
  echo "== ${component} =="
  kubectl get pods -n kube-system -l "component=${component}" -o wide
done
