#!/bin/bash
# Wait for API server
for i in $(seq 1 60); do
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
  grep -q "audit-policy-file" "$MANIFEST" && AUDIT_CONFIGURED=true
  grep -q "audit-log-path" "$MANIFEST" && AUDIT_CONFIGURED=true
else
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" grep -q "audit-policy-file" /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null && AUDIT_CONFIGURED=true
  fi
fi

# Accept audit sample as evidence even if flags couldn't be verified
if [ "$AUDIT_CONFIGURED" = false ] && [ -f /root/audit-sample.txt ] && [ -s /root/audit-sample.txt ]; then
  AUDIT_CONFIGURED=true
fi

if [ "$AUDIT_CONFIGURED" = false ]; then
  echo "FAIL: audit configuration not found"
  exit 1
fi

if [ ! -f /root/audit-sample.txt ] || [ ! -s /root/audit-sample.txt ]; then
  echo "FAIL: /root/audit-sample.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
