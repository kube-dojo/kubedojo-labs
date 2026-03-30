#!/bin/bash
for f in evidence-pod-spec.yaml evidence-logs.txt evidence-env.txt evidence-summary.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
