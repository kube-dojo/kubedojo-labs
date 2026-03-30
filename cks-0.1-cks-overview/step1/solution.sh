#!/bin/bash
kubectl version --short 2>/dev/null > /root/k8s-version.txt || kubectl version > /root/k8s-version.txt
kubectl get namespaces -o name > /root/namespaces.txt
grep -- '--enable-admission-plugins' /etc/kubernetes/manifests/kube-apiserver.yaml | awk -F= '{print $2}' > /root/admission-plugins.txt
