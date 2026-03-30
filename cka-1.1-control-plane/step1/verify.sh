#!/bin/bash
if [ ! -f /root/static-pods.txt ]; then
  echo "FAIL: /root/static-pods.txt does not exist"
  exit 1
fi

if grep -q "apiserver" /root/static-pods.txt && grep -q "etcd" /root/static-pods.txt; then
  echo "PASS: File contains apiserver and etcd entries"
  exit 0
else
  echo "FAIL: File should contain 'apiserver' and 'etcd'"
  exit 1
fi
