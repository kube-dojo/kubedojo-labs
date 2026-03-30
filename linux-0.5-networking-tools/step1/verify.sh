#!/bin/bash
# Verify /root/my-ip.txt contains an IP address
if [ ! -f /root/my-ip.txt ]; then
  echo "/root/my-ip.txt does not exist"
  exit 1
fi

ip=$(cat /root/my-ip.txt | tr -d '[:space:]')
if [[ "$ip" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
  echo "IP address: $ip"
  exit 0
else
  echo "File should contain an IP address, got: '$ip'"
  exit 1
fi
