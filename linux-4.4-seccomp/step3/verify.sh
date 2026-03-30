#!/bin/bash
# Verify K8s seccomp manifest or seccomp profile exists

if [ -f /root/k8s-seccomp.yaml ]; then
  if grep -q "seccompProfile" /root/k8s-seccomp.yaml; then
    echo "PASS: Kubernetes seccomp manifest exists with seccompProfile"
    exit 0
  else
    echo "FAIL: /root/k8s-seccomp.yaml does not contain seccompProfile"
    exit 1
  fi
fi

# Fallback: check if seccomp profile at least exists
if [ -f /root/seccomp-profile.json ]; then
  echo "PASS: seccomp profile exists"
  exit 0
fi

echo "FAIL: Neither /root/k8s-seccomp.yaml nor /root/seccomp-profile.json found"
exit 1
