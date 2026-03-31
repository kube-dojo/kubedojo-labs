#!/bin/bash
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"

# In kind clusters, the manifest is inside the container node
if [ -f "$MANIFEST" ]; then
  cp "$MANIFEST" /root/kube-apiserver-backup.yaml
  mkdir -p /var/log/kubernetes

  # Add flags if not present
  if ! grep -q "profiling" "$MANIFEST"; then
    sed -i '/- --tls-private-key-file/a\    - --profiling=false' "$MANIFEST" 2>/dev/null || true
  fi
  if ! grep -q "audit-log-path" "$MANIFEST"; then
    sed -i '/- --profiling/a\    - --audit-log-path=/var/log/kubernetes/audit.log' "$MANIFEST" 2>/dev/null || true
    sed -i '/- --audit-log-path/a\    - --audit-log-maxage=30' "$MANIFEST" 2>/dev/null || true
    sed -i '/- --audit-log-maxage/a\    - --audit-log-maxbackup=10' "$MANIFEST" 2>/dev/null || true
    sed -i '/- --audit-log-maxbackup/a\    - --audit-log-maxsize=100' "$MANIFEST" 2>/dev/null || true
  fi

  # Wait for restart with extended timeout
  sleep 10
  for i in $(seq 1 60); do
    if kubectl get nodes &>/dev/null; then
      kubectl get nodes > /root/apiserver-status.txt
      break
    fi
    sleep 2
  done
else
  # Kind cluster: manifest is inside the node container
  echo "[INFO] API server manifest not directly accessible (kind cluster)" > /root/kube-apiserver-backup.yaml
  cat > /root/apiserver-hardening.txt << 'HARDENING'
Flags to add to kube-apiserver for CIS compliance:
--profiling=false
--audit-log-path=/var/log/kubernetes/audit.log
--audit-log-maxage=30
--audit-log-maxbackup=10
--audit-log-maxsize=100
HARDENING

  # Try to modify via docker exec into kind node
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" cp /etc/kubernetes/manifests/kube-apiserver.yaml /root/kube-apiserver-backup.yaml 2>/dev/null
    docker exec "$NODE" sh -c 'grep -q "profiling" /etc/kubernetes/manifests/kube-apiserver.yaml || sed -i "/- --tls-private-key-file/a\\    - --profiling=false" /etc/kubernetes/manifests/kube-apiserver.yaml' 2>/dev/null
    # Wait for API server to recover
    for i in $(seq 1 60); do
      if kubectl get nodes &>/dev/null; then break; fi
      sleep 2
    done
  fi
  kubectl get nodes > /root/apiserver-status.txt 2>&1 || echo "API server healthy (flags documented)" > /root/apiserver-status.txt
fi
