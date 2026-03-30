#!/bin/bash
# Detect the CNI plugin name
if kubectl get pods -n kube-system 2>/dev/null | grep -qi calico; then
  echo "calico" > /root/cni-plugin.txt
elif kubectl get pods -n kube-system 2>/dev/null | grep -qi flannel; then
  echo "flannel" > /root/cni-plugin.txt
elif kubectl get pods -n kube-system 2>/dev/null | grep -qi weave; then
  echo "weave" > /root/cni-plugin.txt
elif kubectl get pods -n kube-system 2>/dev/null | grep -qi cilium; then
  echo "cilium" > /root/cni-plugin.txt
elif kubectl get pods -n kube-system 2>/dev/null | grep -qi kindnet; then
  echo "kindnet" > /root/cni-plugin.txt
else
  # Fallback: check config files
  CNI_TYPE=$(cat /etc/cni/net.d/*.conflist 2>/dev/null | grep -oP '"type"\s*:\s*"\K[^"]+' | head -1)
  echo "${CNI_TYPE:-bridge}" > /root/cni-plugin.txt
fi
cat /root/cni-plugin.txt
