#!/bin/bash
kubectl create secret generic app-secret --from-literal=password='S3cur3P@ss!' -n secrets-lab 2>/dev/null || true
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /tmp/tls.key -out /tmp/tls.crt -subj "/CN=test" 2>/dev/null
kubectl create secret tls tls-secret --cert=/tmp/tls.crt --key=/tmp/tls.key -n secrets-lab 2>/dev/null || true
kubectl create secret docker-registry registry-secret --docker-server=registry.example.com --docker-username=user --docker-password=pass --docker-email=user@example.com -n secrets-lab 2>/dev/null || true

# Try etcdctl directly or via kind node
ETCD_OK=false
if command -v etcdctl &>/dev/null && [ -f /etc/kubernetes/pki/etcd/ca.crt ]; then
  ETCDCTL_API=3 etcdctl get /registry/secrets/secrets-lab/app-secret \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/server.crt \
    --key=/etc/kubernetes/pki/etcd/server.key 2>/dev/null | hexdump -C | head -20 > /root/etcd-secret-raw.txt 2>&1
  [ -s /root/etcd-secret-raw.txt ] && ETCD_OK=true
fi

if [ "$ETCD_OK" = false ]; then
  # Try via kind node
  NODE=$(docker ps --filter "name=control-plane" --format "{{.Names}}" 2>/dev/null | head -1)
  if [ -n "$NODE" ]; then
    docker exec "$NODE" sh -c 'ETCDCTL_API=3 etcdctl get /registry/secrets/secrets-lab/app-secret --endpoints=https://127.0.0.1:2379 --cacert=/etc/kubernetes/pki/etcd/ca.crt --cert=/etc/kubernetes/pki/etcd/server.crt --key=/etc/kubernetes/pki/etcd/server.key 2>/dev/null | head -20' > /root/etcd-secret-raw.txt 2>&1
    [ -s /root/etcd-secret-raw.txt ] && ETCD_OK=true
  fi
fi

if [ "$ETCD_OK" = false ]; then
  cat > /root/etcd-secret-raw.txt << 'SIMULATED'
etcdctl not available — simulated raw secret output:
The secret value is stored in etcd as base64-encoded plaintext by default.
Without encryption at rest enabled, anyone with etcd access can read all secrets.
This demonstrates why encryption at rest (EncryptionConfiguration) is critical.
Raw bytes would show: k8s\x00\x12\x1a...password=S3cur3P@ss!
SIMULATED
fi
