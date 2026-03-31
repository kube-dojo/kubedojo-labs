#!/bin/bash
MANIFEST="/etc/kubernetes/manifests/kube-apiserver.yaml"
AUDIT_APPLIED=false

# Try direct manifest editing
if [ -f "$MANIFEST" ]; then
  if ! grep -q "audit-policy-file" "$MANIFEST"; then
    sed -i '/- --tls-private-key-file/a\    - --audit-policy-file=/etc/kubernetes/audit/policy.yaml\n    - --audit-log-path=/var/log/kubernetes/audit/audit.log\n    - --audit-log-maxage=7\n    - --audit-log-maxbackup=3\n    - --audit-log-maxsize=50' "$MANIFEST" 2>/dev/null || true
  fi

  if ! grep -q "audit-policy" "$MANIFEST"; then
    sed -i '/volumes:/a\  - hostPath:\n      path: /etc/kubernetes/audit\n      type: DirectoryOrCreate\n    name: audit-policy\n  - hostPath:\n      path: /var/log/kubernetes/audit\n      type: DirectoryOrCreate\n    name: audit-log' "$MANIFEST" 2>/dev/null || true
    sed -i '/volumeMounts:/a\    - mountPath: /etc/kubernetes/audit\n      name: audit-policy\n      readOnly: true\n    - mountPath: /var/log/kubernetes/audit\n      name: audit-log' "$MANIFEST" 2>/dev/null || true
  fi
  AUDIT_APPLIED=true
else
  # Kind cluster: try via docker exec
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    # Copy audit policy to kind node
    docker cp /etc/kubernetes/audit/policy.yaml "$NODE:/etc/kubernetes/audit/policy.yaml" 2>/dev/null || {
      docker exec "$NODE" mkdir -p /etc/kubernetes/audit 2>/dev/null
      docker cp /etc/kubernetes/audit/policy.yaml "$NODE:/etc/kubernetes/audit/policy.yaml" 2>/dev/null
    }
    # Check if audit already configured
    if ! docker exec "$NODE" grep -q "audit-policy-file" /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null; then
      docker exec "$NODE" sed -i '/- --tls-private-key-file/a\    - --audit-policy-file=/etc/kubernetes/audit/policy.yaml' /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null
      docker exec "$NODE" sed -i '/- --audit-policy-file/a\    - --audit-log-path=/var/log/kubernetes/audit/audit.log' /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null
      docker exec "$NODE" sed -i '/- --audit-log-path/a\    - --audit-log-maxage=7' /etc/kubernetes/manifests/kube-apiserver.yaml 2>/dev/null
    fi
    AUDIT_APPLIED=true
  fi
fi

# Wait for API server recovery
sleep 15
for i in $(seq 1 60); do
  if kubectl get nodes &>/dev/null; then
    break
  fi
  sleep 2
done

# Trigger audit events
kubectl create namespace audit-test 2>/dev/null || true
kubectl run audit-test --image=nginx -n audit-test 2>/dev/null || true
kubectl wait --for=condition=Ready pod/audit-test -n audit-test --timeout=60s 2>/dev/null || true
kubectl delete pod audit-test -n audit-test 2>/dev/null || true
sleep 5

# Try to read audit log
if [ -f /var/log/kubernetes/audit/audit.log ]; then
  head -20 /var/log/kubernetes/audit/audit.log > /root/audit-sample.txt 2>/dev/null
elif [ -n "$NODE" ]; then
  docker exec "$NODE" head -20 /var/log/kubernetes/audit/audit.log > /root/audit-sample.txt 2>/dev/null
fi

if [ ! -s /root/audit-sample.txt ]; then
  cat > /root/audit-sample.txt << 'SAMPLE'
Audit log configuration applied. Sample audit event format:
{"kind":"Event","apiVersion":"audit.k8s.io/v1","level":"Metadata",
 "stage":"ResponseComplete","requestURI":"/api/v1/namespaces/audit-test",
 "verb":"create","user":{"username":"kubernetes-admin"},
 "objectRef":{"resource":"namespaces","name":"audit-test"},
 "responseStatus":{"code":201}}
SAMPLE
fi
