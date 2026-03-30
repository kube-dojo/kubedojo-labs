#!/bin/bash
for s in app-secret tls-secret registry-secret; do
  if ! kubectl get secret $s -n secrets-lab &>/dev/null; then
    echo "FAIL: Secret $s not found in secrets-lab"
    exit 1
  fi
done
if [ ! -f /root/etcd-secret-raw.txt ] || [ ! -s /root/etcd-secret-raw.txt ]; then
  echo "FAIL: /root/etcd-secret-raw.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
