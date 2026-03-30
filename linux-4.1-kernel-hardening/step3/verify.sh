#!/bin/bash
# Verify audit rules
# Docker-compatible: checks file content, not live auditd state

if [ ! -f /root/audit-rules.txt ]; then
  echo "FAIL: /root/audit-rules.txt does not exist"
  exit 1
fi

# Check that the file has content (audit rules listed)
if [ ! -s /root/audit-rules.txt ]; then
  echo "FAIL: /root/audit-rules.txt is empty"
  exit 1
fi

# Check for the passwd watch rule in the file
if grep -q "/etc/passwd" /root/audit-rules.txt; then
  echo "PASS: Audit rule for /etc/passwd found in rules file"
  exit 0
fi

echo "FAIL: /root/audit-rules.txt does not contain a rule for /etc/passwd"
exit 1
