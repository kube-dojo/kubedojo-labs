#!/bin/bash
# Verify SELinux workflow documentation

if [ ! -f /root/selinux-workflow.txt ]; then
  echo "FAIL: /root/selinux-workflow.txt does not exist"
  exit 1
fi

if [ ! -s /root/selinux-workflow.txt ]; then
  echo "FAIL: /root/selinux-workflow.txt is empty"
  exit 1
fi

# Check for mention of audit2allow (key troubleshooting tool)
if grep -qi "audit2allow" /root/selinux-workflow.txt; then
  echo "PASS: SELinux troubleshooting workflow documented with audit2allow"
  exit 0
else
  echo "FAIL: /root/selinux-workflow.txt should mention audit2allow"
  exit 1
fi
