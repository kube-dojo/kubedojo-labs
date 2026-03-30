#!/bin/bash
for f in image-sizes.txt minimal-Dockerfile image-hardening.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
if ! grep -qi "FROM" /root/minimal-Dockerfile; then
  echo "FAIL: minimal-Dockerfile should contain FROM instruction"
  exit 1
fi
LINES=$(wc -l < /root/image-hardening.txt | tr -d ' ')
if [ "$LINES" -lt 5 ]; then
  echo "FAIL: Expected at least 5 image hardening practices"
  exit 1
fi
echo "PASS"
exit 0
