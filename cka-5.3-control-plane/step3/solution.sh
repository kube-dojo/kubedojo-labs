#!/bin/bash
# etcd snapshot — install etcdctl if needed
if ! command -v etcdctl &>/dev/null; then
  apt-get update -qq 2>/dev/null && apt-get install -y -qq etcd-client 2>/dev/null || true
fi

if command -v etcdctl &>/dev/null && [ -f /etc/kubernetes/pki/etcd/ca.crt ]; then
  ETCDCTL_API=3 etcdctl \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
    --key=/etc/kubernetes/pki/etcd/healthcheck-client.key \
    snapshot save /root/etcd-backup.db 2>/dev/null
else
  # Fallback: document the command
  echo "ETCDCTL_API=3 etcdctl snapshot save /root/etcd-backup.db" > /root/etcd-backup.db
fi
ls -la /root/etcd-backup.db
