#!/bin/bash
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"

# Add audit flags
if ! grep -q "audit-policy-file" "$MANIFEST"; then
  sed -i '/- --tls-private-key-file/a\    - --audit-policy-file=/etc/kubernetes/audit/policy.yaml\n    - --audit-log-path=/var/log/kubernetes/audit/audit.log\n    - --audit-log-maxage=7\n    - --audit-log-maxbackup=3\n    - --audit-log-maxsize=50' "$MANIFEST"
fi

# Add volumes if not present
if ! grep -q "audit-policy" "$MANIFEST"; then
  sed -i '/volumes:/a\  - hostPath:\n      path: /etc/kubernetes/audit\n      type: DirectoryOrCreate\n    name: audit-policy\n  - hostPath:\n      path: /var/log/kubernetes/audit\n      type: DirectoryOrCreate\n    name: audit-log' "$MANIFEST"
  sed -i '/volumeMounts:/a\    - mountPath: /etc/kubernetes/audit\n      name: audit-policy\n      readOnly: true\n    - mountPath: /var/log/kubernetes/audit\n      name: audit-log' "$MANIFEST"
fi

# Wait for restart
sleep 15
for i in $(seq 1 60); do
  if kubectl get nodes &>/dev/null; then
    break
  fi
  sleep 2
done

# Trigger events
kubectl create namespace audit-test 2>/dev/null || true
kubectl run audit-test --image=nginx -n audit-test 2>/dev/null || true
kubectl delete pod audit-test -n audit-test 2>/dev/null || true
sleep 5

head -20 /var/log/kubernetes/audit/audit.log > /root/audit-sample.txt 2>/dev/null || echo "Audit log not yet populated" > /root/audit-sample.txt
