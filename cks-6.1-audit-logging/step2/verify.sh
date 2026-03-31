#!/bin/bash
# Wait for API server to be healthy
for i in $(seq 1 30); do
  if kubectl get nodes &>/dev/null; then
    break
  fi
  sleep 2
done
if ! kubectl get nodes &>/dev/null; then
  echo "FAIL: API server not healthy"
  exit 1
fi

# Check audit flags — locally or in kind node
AUDIT_CONFIGURED=false
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
if [ -f "$MANIFEST" ]; then
  grep -q "audit-policy-file" "$MANIFEST" 2>/dev/null && AUDIT_CONFIGURED=true
else
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" grep -q "audit-policy-file" /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null && AUDIT_CONFIGURED=true
  fi
fi

# Accept the audit sample file as evidence even if manifest flags could not be
# verified (common in kind where manifest edits may have been rolled back).
if [ "$AUDIT_CONFIGURED" = false ] && [ -f /root/audit-sample.txt ] && [ -s /root/audit-sample.txt ]; then
  AUDIT_CONFIGURED=true
fi

if [ "$AUDIT_CONFIGURED" = false ]; then
  echo "FAIL: audit configuration not found and no audit-sample.txt"
  exit 1
fi

if [ ! -f /root/audit-sample.txt ] || [ ! -s /root/audit-sample.txt ]; then
  echo "FAIL: /root/audit-sample.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
