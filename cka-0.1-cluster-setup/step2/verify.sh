#!/bin/bash
if [ ! -f /root/apiserver-pod.txt ]; then
  echo "FAIL: /root/apiserver-pod.txt does not exist"
  exit 1
fi

CONTENT=$(cat /root/apiserver-pod.txt | tr -d '[:space:]')
if echo "$CONTENT" | grep -q "kube-apiserver"; then
  echo "PASS: File contains kube-apiserver pod name"
  exit 0
else
  echo "FAIL: File should contain a pod name with 'kube-apiserver', got: $CONTENT"
  exit 1
fi
