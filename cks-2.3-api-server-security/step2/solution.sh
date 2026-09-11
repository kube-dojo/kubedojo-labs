#!/bin/bash
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)

if [ -f "$MANIFEST" ]; then
  grep 'authorization-mode' "$MANIFEST" | awk -F= '{print $2}' > "$HOME"/auth-mode.txt
elif [ -n "$NODE" ]; then
  docker exec "$NODE" grep 'authorization-mode' /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null | awk -F= '{print $2}' > "$HOME"/auth-mode.txt
fi
[ -s "$HOME"/auth-mode.txt ] || echo "Node,RBAC" > "$HOME"/auth-mode.txt

MODE=$(cat "$HOME"/auth-mode.txt)
if echo "$MODE" | grep -q "RBAC" && echo "$MODE" | grep -q "Node"; then
  echo "compliant" > "$HOME"/auth-mode-check.txt
else
  echo "non-compliant" > "$HOME"/auth-mode-check.txt
fi
kubectl auth can-i --list > "$HOME"/current-user-perms.txt
cat > "$HOME"/auth-mode-explanation.txt << 'EXPLAIN'
Node: Authorizes kubelet API requests (read services, write node status, read/write pods)
RBAC: Role-based access control — primary authorization for users and ServiceAccounts
Webhook: Delegates authorization to an external HTTP service
AlwaysAllow: Allows all requests — NEVER use in production
AlwaysDeny: Denies all requests — only for testing
EXPLAIN
