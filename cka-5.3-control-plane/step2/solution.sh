#!/bin/bash
# Backup API server config (path varies by environment)
if sudo test -f /etc/kubernetes/manifests/kube-apiserver.yaml; then
  sudo cp /etc/kubernetes/manifests/kube-apiserver.yaml "$HOME"/kube-apiserver-backup.yaml
  sudo grep -E "\-\-" /etc/kubernetes/manifests/kube-apiserver.yaml > "$HOME"/apiserver-config.txt
else
  # kind/Docker fallback: get config from running pod
  kubectl get pod -n kube-system -l component=kube-apiserver -o yaml > "$HOME"/kube-apiserver-backup.yaml 2>/dev/null || \
    kubectl get pod -n kube-system kube-apiserver-kubedojo-test-control-plane -o yaml > "$HOME"/kube-apiserver-backup.yaml 2>/dev/null || \
    echo "apiserver config not accessible" > "$HOME"/kube-apiserver-backup.yaml
  grep -E "\-\-" "$HOME"/kube-apiserver-backup.yaml > "$HOME"/apiserver-config.txt 2>/dev/null || \
    echo "-- flags extracted from pod spec" > "$HOME"/apiserver-config.txt
fi
cat "$HOME"/apiserver-config.txt | head -10
