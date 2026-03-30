#!/bin/bash
if ! kubectl get pod restricted-ok -n psa-restricted &>/dev/null; then
  echo "FAIL: Pod restricted-ok not found"
  exit 1
fi
for f in restricted-ok.txt restricted-fail.txt restricted-requirements.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
