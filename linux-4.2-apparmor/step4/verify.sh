#!/bin/bash
# Verify AppArmor logs file

if [ ! -f /root/apparmor-logs.txt ]; then
  echo "FAIL: /root/apparmor-logs.txt does not exist"
  exit 1
fi

if [ -s /root/apparmor-logs.txt ]; then
  echo "PASS: AppArmor logs file exists with content"
  exit 0
else
  echo "FAIL: /root/apparmor-logs.txt is empty"
  exit 1
fi
