#!/bin/bash
for f in target-version.txt upgrade-commands.txt etcd-version.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
if ! grep -qi "kubeadm upgrade apply" /root/upgrade-commands.txt; then
  echo "FAIL: upgrade-commands.txt should contain kubeadm upgrade apply"
  exit 1
fi
echo "PASS"
exit 0
