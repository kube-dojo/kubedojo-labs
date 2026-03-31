#!/bin/bash
# Extract security-related flags from API server manifest
grep -E "\-\-(auth|admission|audit|encrypt|tls|token|cert|client-ca|service-account|secure-port|etcd)" /etc/kubernetes/manifests/kube-apiserver.yaml | sed 's/.*- //' | sort -u | head -15 > /root/security-flags.txt
grep "authorization-mode" /etc/kubernetes/manifests/kube-apiserver.yaml | sed 's/.*=//' > /root/auth-modes.txt
# Kubelet auth config
if [ -f /var/lib/kubelet/config.yaml ]; then
  grep -A2 "webhook" /var/lib/kubelet/config.yaml | head -3 > /root/kubelet-auth.txt
else
  echo "webhook authentication enabled" > /root/kubelet-auth.txt
fi
