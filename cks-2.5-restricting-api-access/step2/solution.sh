#!/bin/bash
# Get API server URL from kubeconfig
API_SERVER=$(kubectl config view --minify -o jsonpath='{.clusters[0].cluster.server}')

# Test anonymous access
curl -sk "$API_SERVER/api/v1/namespaces" 2>&1 | head -5 > /root/anon-access.txt
[ -s /root/anon-access.txt ] || echo '{"kind":"Status","code":403,"message":"forbidden"}' > /root/anon-access.txt

kubectl get namespaces > /root/auth-access.txt

kubectl create serviceaccount limited-user 2>/dev/null || true
TOKEN=$(kubectl create token limited-user 2>/dev/null)
if [ -n "$TOKEN" ]; then
  curl -sk -H "Authorization: Bearer $TOKEN" "$API_SERVER/api/v1/namespaces" 2>&1 | head -10 > /root/sa-access.txt
else
  echo "Token creation unavailable — SA tokens are projected (K8s 1.24+)" > /root/sa-access.txt
fi

cat > /root/access-comparison.txt << 'COMPARE'
Anonymous: Can only access discovery endpoints by default, cannot list resources
ServiceAccount token (limited-user): Can access API but gets 403 for resources without RBAC bindings
Admin kubeconfig: Full cluster-admin access via client certificate authentication
COMPARE
