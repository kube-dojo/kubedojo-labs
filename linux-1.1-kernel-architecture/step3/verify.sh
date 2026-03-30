#!/bin/bash
# Verify /root/ip-forward.txt contains 0 or 1
if [ ! -f /root/ip-forward.txt ]; then
  echo "/root/ip-forward.txt does not exist"
  exit 1
fi

value=$(cat /root/ip-forward.txt | tr -d '[:space:]')
if [ "$value" = "0" ] || [ "$value" = "1" ]; then
  echo "ip_forward = $value"
  exit 0
else
  echo "Expected 0 or 1, got: '$value'"
  exit 1
fi
