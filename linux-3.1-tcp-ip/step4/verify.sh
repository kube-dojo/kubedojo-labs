#!/bin/bash
# Verify that /root/port22-service.txt contains "ssh"
if [ ! -f /root/port22-service.txt ]; then
  echo "FAIL: /root/port22-service.txt does not exist"
  exit 1
fi

if grep -qi "ssh" /root/port22-service.txt; then
  echo "PASS: File contains 'ssh'"
  exit 0
else
  echo "FAIL: /root/port22-service.txt does not contain 'ssh'"
  exit 1
fi
