#!/bin/bash
if [ ! -f /root/nginx-digest.txt ] || [ ! -s /root/nginx-digest.txt ]; then
  echo "FAIL: /root/nginx-digest.txt missing or empty"
  exit 1
fi
if ! kubectl get pod pinned-pod -n image-lab &>/dev/null; then
  echo "FAIL: Pod pinned-pod not found"
  exit 1
fi
IMAGE=$(kubectl get pod pinned-pod -n image-lab -o jsonpath='{.spec.containers[0].image}')
if ! echo "$IMAGE" | grep -q "sha256"; then
  echo "FAIL: Pod should use image digest (sha256)"
  exit 1
fi
for f in image-tag-risks.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
