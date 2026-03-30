#!/bin/bash
for f in pod-insecure.yaml pod-baseline.yaml pod-hardened.yaml kubesec-insecure.json kubesec-baseline.json kubesec-hardened.json kubesec-scores.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
