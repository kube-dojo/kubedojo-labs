#!/bin/bash
if ! kubectl get namespace immutable-enforced &>/dev/null; then
  echo "FAIL: Namespace immutable-enforced not found"
  exit 1
fi
for f in enforce-test.txt immutability-patterns.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
