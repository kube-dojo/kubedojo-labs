#!/bin/bash
# Try to identify CNI from config files first, then from pods
if [ -d /etc/cni/net.d/ ] && [ "$(sudo ls /etc/cni/net.d/ 2>/dev/null)" ]; then
  sudo ls /etc/cni/net.d/ > "$HOME"/cni-plugin.txt
else
  kubectl get pods -n kube-system --no-headers | grep -iE 'calico|flannel|cilium|weave|canal' | awk '{print $1}' | head -1 > "$HOME"/cni-plugin.txt
fi

# If still empty, try describe node
if [ ! -s "$HOME"/cni-plugin.txt ]; then
  kubectl describe node $(kubectl get nodes -o jsonpath='{.items[0].metadata.name}') | grep -i "cni" > "$HOME"/cni-plugin.txt
fi

echo "CNI plugin:"
cat "$HOME"/cni-plugin.txt
