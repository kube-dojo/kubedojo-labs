#!/bin/bash
# Detect the CNI plugin name
if kubectl get pods -n kube-system 2>/dev/null | grep -qi calico; then
  echo "calico" > "$HOME"/cni-plugin.txt
elif kubectl get pods -n kube-system 2>/dev/null | grep -qi flannel; then
  echo "flannel" > "$HOME"/cni-plugin.txt
elif kubectl get pods -n kube-system 2>/dev/null | grep -qi weave; then
  echo "weave" > "$HOME"/cni-plugin.txt
elif kubectl get pods -n kube-system 2>/dev/null | grep -qi cilium; then
  echo "cilium" > "$HOME"/cni-plugin.txt
elif kubectl get pods -n kube-system 2>/dev/null | grep -qi kindnet; then
  echo "kindnet" > "$HOME"/cni-plugin.txt
else
  # Fallback: check config files
  CNI_TYPE=$(sudo cat /etc/cni/net.d/*.conflist 2>/dev/null | grep -oP '"type"\s*:\s*"\K[^"]+' | head -1)
  echo "${CNI_TYPE:-bridge}" > "$HOME"/cni-plugin.txt
fi
cat "$HOME"/cni-plugin.txt
