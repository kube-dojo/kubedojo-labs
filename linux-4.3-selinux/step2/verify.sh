#!/bin/bash
# Verify file context documentation

if [ ! -f /root/selinux-lab/context-report.txt ]; then
  echo "FAIL: /root/selinux-lab/context-report.txt does not exist"
  exit 1
fi

if [ ! -s /root/selinux-lab/context-report.txt ]; then
  echo "FAIL: /root/selinux-lab/context-report.txt is empty"
  exit 1
fi

echo "PASS: File context report documented"
exit 0
