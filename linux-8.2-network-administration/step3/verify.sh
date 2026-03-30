#!/bin/bash
if [ ! -f /root/firewall-rules.txt ]; then
  echo "FAIL: /root/firewall-rules.txt not found"
  exit 1
fi

if [ -s /root/firewall-rules.txt ]; then
  echo "PASS: firewall-rules.txt has content"
  exit 0
else
  echo "FAIL: firewall-rules.txt is empty"
  exit 1
fi
