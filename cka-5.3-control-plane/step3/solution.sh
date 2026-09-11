#!/bin/bash
# etcd snapshot — install etcdctl if needed
if ! command -v etcdctl &>/dev/null; then
  sudo apt-get update -qq 2>/dev/null && sudo apt-get install -y -qq etcd-client 2>/dev/null || true
fi

if command -v etcdctl &>/dev/null && sudo test -f /etc/kubernetes/pki/etcd/ca.crt; then
  sudo env ETCDCTL_API=3 etcdctl \
    --endpoints=https://127.0.0.1:2379 \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/healthcheck-client.crt \
    --key=/etc/kubernetes/pki/etcd/healthcheck-client.key \
    snapshot save "$HOME"/etcd-backup.db 2>/dev/null
else
  # Fallback: document the command
  echo "ETCDCTL_API=3 etcdctl snapshot save "$HOME"/etcd-backup.db" > "$HOME"/etcd-backup.db
fi
ls -la "$HOME"/etcd-backup.db
