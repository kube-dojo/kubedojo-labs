#!/bin/bash
if [ ! -f /root/rotate-backups.sh ]; then
  echo "FAIL: /root/rotate-backups.sh not found"
  exit 1
fi

if [ ! -x /root/rotate-backups.sh ]; then
  echo "FAIL: /root/rotate-backups.sh is not executable"
  exit 1
fi

echo "PASS: rotate-backups.sh exists and is executable"
exit 0
