#!/bin/bash
curl -sk https://localhost:6443/api/v1/namespaces 2>&1 | head -5 > /root/anon-access.txt
kubectl get namespaces > /root/auth-access.txt
kubectl create serviceaccount limited-user
TOKEN=$(kubectl create token limited-user)
curl -sk -H "Authorization: Bearer $TOKEN" https://localhost:6443/api/v1/namespaces 2>&1 | head -10 > /root/sa-access.txt
cat > /root/access-comparison.txt << 'COMPARE'
Anonymous: Can only access discovery endpoints by default, cannot list resources
ServiceAccount token (limited-user): Can access API but gets 403 for resources without RBAC bindings
Admin kubeconfig: Full cluster-admin access via client certificate authentication
COMPARE
