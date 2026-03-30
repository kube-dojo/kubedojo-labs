#!/bin/bash
# Verify SELinux status file

if [ ! -f /root/selinux-status.txt ]; then
  echo "FAIL: /root/selinux-status.txt does not exist"
  exit 1
fi

if [ ! -s /root/selinux-status.txt ]; then
  echo "FAIL: /root/selinux-status.txt is empty"
  exit 1
fi

echo "PASS: SELinux status report saved"
exit 0
