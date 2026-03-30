#!/bin/bash
grep 'authorization-mode' /etc/kubernetes/manifests/kube-apiserver.yaml | awk -F= '{print $2}' > /root/auth-mode.txt
MODE=$(cat /root/auth-mode.txt)
if echo "$MODE" | grep -q "RBAC" && echo "$MODE" | grep -q "Node"; then
  echo "compliant" > /root/auth-mode-check.txt
else
  echo "non-compliant" > /root/auth-mode-check.txt
fi
kubectl auth can-i --list > /root/current-user-perms.txt
cat > /root/auth-mode-explanation.txt << 'EXPLAIN'
Node: Authorizes kubelet API requests (read services, write node status, read/write pods)
RBAC: Role-based access control — primary authorization for users and ServiceAccounts
Webhook: Delegates authorization to an external HTTP service
AlwaysAllow: Allows all requests — NEVER use in production
AlwaysDeny: Denies all requests — only for testing
EXPLAIN
