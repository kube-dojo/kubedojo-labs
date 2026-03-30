#!/bin/bash
if [ ! -f /root/etcd-endpoint.txt ]; then
  echo "FAIL: /root/etcd-endpoint.txt does not exist"
  exit 1
fi

if grep -q "2379" /root/etcd-endpoint.txt; then
  echo "PASS: File contains etcd endpoint with port 2379"
  exit 0
else
  echo "FAIL: File should contain an etcd endpoint URL with port 2379"
  exit 1
fi
