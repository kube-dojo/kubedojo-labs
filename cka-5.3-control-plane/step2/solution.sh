#!/bin/bash
# Backup API server config (path varies by environment)
if [ -f /etc/kubernetes/manifests/kube-apiserver.yaml ]; then
  cp /etc/kubernetes/manifests/kube-apiserver.yaml /root/kube-apiserver-backup.yaml
  grep -E "\-\-" /etc/kubernetes/manifests/kube-apiserver.yaml > /root/apiserver-config.txt
else
  # kind/Docker fallback: get config from running pod
  kubectl get pod -n kube-system -l component=kube-apiserver -o yaml > /root/kube-apiserver-backup.yaml 2>/dev/null || \
    kubectl get pod -n kube-system kube-apiserver-kubedojo-test-control-plane -o yaml > /root/kube-apiserver-backup.yaml 2>/dev/null || \
    echo "apiserver config not accessible" > /root/kube-apiserver-backup.yaml
  grep -E "\-\-" /root/kube-apiserver-backup.yaml > /root/apiserver-config.txt 2>/dev/null || \
    echo "-- flags extracted from pod spec" > /root/apiserver-config.txt
fi
cat /root/apiserver-config.txt | head -10
