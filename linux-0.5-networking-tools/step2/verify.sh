#!/bin/bash
# Verify /root/google-ip.txt contains an IP address
if [ ! -f /root/google-ip.txt ]; then
  echo "/root/google-ip.txt does not exist"
  exit 1
fi

ip=$(cat /root/google-ip.txt | tr -d '[:space:]')
if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "Resolved google.com to: $ip"
  exit 0
else
  echo "File should contain an IP address, got: '$ip'"
  exit 1
fi
