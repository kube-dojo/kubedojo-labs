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
if ! grep -q "audit-policy-file" /etc/kubernetes/manifests/kube-apiserver.yaml; then
  echo "FAIL: audit-policy-file flag not found"
  exit 1
fi
if ! grep -q "audit-log-path" /etc/kubernetes/manifests/kube-apiserver.yaml; then
  echo "FAIL: audit-log-path flag not found"
  exit 1
fi
if [ ! -f /root/audit-sample.txt ] || [ ! -s /root/audit-sample.txt ]; then
  echo "FAIL: /root/audit-sample.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
