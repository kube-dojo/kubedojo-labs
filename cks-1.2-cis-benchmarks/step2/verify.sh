#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"

# Check directly or via kind node
PROFILING_FOUND=false
AUDIT_FOUND=false

if [ -f "$MANIFEST" ]; then
  grep -q "profiling=false" "$MANIFEST" && PROFILING_FOUND=true
  grep -q "audit-log-path" "$MANIFEST" && AUDIT_FOUND=true
else
  # Check inside kind node
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" grep -q "profiling=false" /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null && PROFILING_FOUND=true
    docker exec "$NODE" grep -q "audit-log-path" /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null && AUDIT_FOUND=true
  fi
  # Accept documentation fallback
  if [ -f $USER_HOME/apiserver-hardening.txt ] && grep -q "profiling=false" $USER_HOME/apiserver-hardening.txt; then
    PROFILING_FOUND=true
    AUDIT_FOUND=true
  fi
fi

if [ "$PROFILING_FOUND" = false ]; then
  echo "FAIL: --profiling=false not set"
  exit 1
fi
if [ "$AUDIT_FOUND" = false ]; then
  echo "FAIL: --audit-log-path not configured"
  exit 1
fi

# Wait for API server to be ready
for i in $(seq 1 30); do
  if kubectl get nodes &>/dev/null; then
    echo "PASS"
    exit 0
  fi
  sleep 2
done
echo "FAIL: API server did not recover"
exit 1
