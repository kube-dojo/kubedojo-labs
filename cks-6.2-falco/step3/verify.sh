#!/bin/bash
if ! kubectl get pod test-pod -n falco-lab &>/dev/null; then
  echo "FAIL: test-pod not found in falco-lab"
  exit 1
fi
for f in falco-detections.txt incident-response.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
