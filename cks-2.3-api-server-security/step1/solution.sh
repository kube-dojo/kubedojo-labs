#!/bin/bash
grep -E '\-\-(auth|token|cert|client-ca|service-account)' /etc/kubernetes/manifests/kube-apiserver.yaml > /root/auth-flags.txt
ANON=$(grep 'anonymous-auth' /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null)
if [ -z "$ANON" ]; then
  echo "anonymous-auth not explicitly set (defaults to true)" > /root/anonymous-auth.txt
else
  echo "$ANON" > /root/anonymous-auth.txt
fi
INSECURE=$(grep 'insecure-port' /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null)
if [ -z "$INSECURE" ]; then
  echo "insecure-port not set (disabled by default in modern K8s)" > /root/insecure-port.txt
else
  echo "$INSECURE" > /root/insecure-port.txt
fi
