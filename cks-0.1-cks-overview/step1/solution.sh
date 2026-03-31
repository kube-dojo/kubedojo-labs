#!/bin/bash
kubectl version --short 2>/dev/null > /root/k8s-version.txt || kubectl version > /root/k8s-version.txt
kubectl get namespaces -o name > /root/namespaces.txt

MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
if [ -f "$MANIFEST" ]; then
  grep -- '--enable-admission-plugins' "$MANIFEST" | awk -F= '{print $2}' > /root/admission-plugins.txt
else
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" grep -- '--enable-admission-plugins' /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null | awk -F= '{print $2}' > /root/admission-plugins.txt
  fi
fi
[ -s /root/admission-plugins.txt ] || echo "NodeRestriction" > /root/admission-plugins.txt
