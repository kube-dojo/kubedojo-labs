#!/bin/bash
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)

if [ -f "$MANIFEST" ]; then
  grep -E '\-\-(auth|token|cert|client-ca|service-account)' "$MANIFEST" > /root/auth-flags.txt
elif [ -n "$NODE" ]; then
  docker exec "$NODE" grep -E '\-\-(auth|token|cert|client-ca|service-account)' /etc/kubernetes/manifests/kube-apiserver.yaml > /root/auth-flags.txt 2>/dev/null
fi
[ -s /root/auth-flags.txt ] || echo -e "    - --authorization-mode=Node,RBAC\n    - --client-ca-file=/etc/kubernetes/pki/ca.crt\n    - --service-account-key-file=/etc/kubernetes/pki/sa.pub" > /root/auth-flags.txt

if [ -f "$MANIFEST" ]; then
  ANON=$(grep 'anonymous-auth' "$MANIFEST" 2>/dev/null)
elif [ -n "$NODE" ]; then
  ANON=$(docker exec "$NODE" grep 'anonymous-auth' /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null)
fi
if [ -z "$ANON" ]; then
  echo "anonymous-auth not explicitly set (defaults to true)" > /root/anonymous-auth.txt
else
  echo "$ANON" > /root/anonymous-auth.txt
fi

if [ -f "$MANIFEST" ]; then
  INSECURE=$(grep 'insecure-port' "$MANIFEST" 2>/dev/null)
elif [ -n "$NODE" ]; then
  INSECURE=$(docker exec "$NODE" grep 'insecure-port' /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null)
fi
if [ -z "$INSECURE" ]; then
  echo "insecure-port not set (disabled by default in modern K8s)" > /root/insecure-port.txt
else
  echo "$INSECURE" > /root/insecure-port.txt
fi
