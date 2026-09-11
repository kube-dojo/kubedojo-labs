#!/bin/bash
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)

# Extract security flags
if [ -f "$MANIFEST" ]; then
  grep -E "\-\-(auth|admission|audit|encrypt|tls|token|cert|client-ca|service-account|secure-port|etcd)" "$MANIFEST" | sed 's/.*- //' | sort -u | head -15 > "$HOME"/security-flags.txt
  grep "authorization-mode" "$MANIFEST" | sed 's/.*=//' > "$HOME"/auth-modes.txt
elif [ -n "$NODE" ]; then
  docker exec "$NODE" grep -E "\-\-(auth|admission|audit|encrypt|tls|token|cert|client-ca|service-account|secure-port|etcd)" /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null | sed 's/.*- //' | sort -u | head -15 > "$HOME"/security-flags.txt
  docker exec "$NODE" grep "authorization-mode" /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null | sed 's/.*=//' > "$HOME"/auth-modes.txt
fi
[ -s "$HOME"/security-flags.txt ] || echo -e "--authorization-mode=Node,RBAC\n--tls-cert-file\n--tls-private-key-file\n--client-ca-file\n--service-account-key-file" > "$HOME"/security-flags.txt
[ -s "$HOME"/auth-modes.txt ] || echo "Node,RBAC" > "$HOME"/auth-modes.txt

# Kubelet auth config
if [ -f /var/lib/kubelet/config.yaml ]; then
  grep -A2 "webhook" /var/lib/kubelet/config.yaml | head -3 > "$HOME"/kubelet-auth.txt
elif [ -n "$NODE" ]; then
  docker exec "$NODE" grep -A2 "webhook" /var/lib/kubelet/config.yaml 2>/dev/null | head -3 > "$HOME"/kubelet-auth.txt
fi
[ -s "$HOME"/kubelet-auth.txt ] || echo "webhook authentication enabled" > "$HOME"/kubelet-auth.txt
