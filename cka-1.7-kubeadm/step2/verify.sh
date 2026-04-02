#!/bin/bash
FILE="/root/cert-expiry.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

if grep -qi "CERTIFICATE" "$FILE" && grep -qi "EXPIRES" "$FILE"; then
  echo "PASS: Certificate expiration report verified"
  exit 0
else
  echo "FAIL: File does not appear to be a valid 'kubeadm certs check-expiration' output"
  exit 1
fi