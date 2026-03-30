#!/bin/bash
if [ ! -f /root/cert-expiry.txt ]; then
  echo "FAIL: /root/cert-expiry.txt does not exist"
  exit 1
fi

CONTENT=$(cat /root/cert-expiry.txt)
if echo "$CONTENT" | grep -qiE "EXPIRES|expir|RESIDUAL"; then
  echo "PASS: File contains certificate expiration information"
  exit 0
else
  # Also accept if it has dates
  if echo "$CONTENT" | grep -qE "[0-9]{4}"; then
    echo "PASS: File contains date information"
    exit 0
  fi
  echo "FAIL: File should contain certificate expiration dates"
  exit 1
fi
