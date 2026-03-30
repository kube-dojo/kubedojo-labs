#!/bin/bash
cp /etc/kubernetes/manifests/kube-apiserver.yaml /root/kube-apiserver-backup.yaml
mkdir -p /var/log/kubernetes

# Add flags if not present
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
if ! grep -q "profiling" "$MANIFEST"; then
  sed -i '/- --tls-private-key-file/a\    - --profiling=false' "$MANIFEST"
fi
if ! grep -q "audit-log-path" "$MANIFEST"; then
  sed -i '/- --profiling/a\    - --audit-log-path=/var/log/kubernetes/audit.log' "$MANIFEST"
  sed -i '/- --audit-log-path/a\    - --audit-log-maxage=30' "$MANIFEST"
  sed -i '/- --audit-log-maxage/a\    - --audit-log-maxbackup=10' "$MANIFEST"
  sed -i '/- --audit-log-maxbackup/a\    - --audit-log-maxsize=100' "$MANIFEST"
fi

# Wait for restart
sleep 10
for i in $(seq 1 30); do
  if kubectl get nodes &>/dev/null; then
    kubectl get nodes > /root/apiserver-status.txt
    break
  fi
  sleep 2
done
