#!/bin/bash
if [ ! -f /root/security-checklist.txt ] || [ ! -s /root/security-checklist.txt ]; then
  echo "FAIL: /root/security-checklist.txt missing or empty"
  exit 1
fi
LINES=$(wc -l < /root/security-checklist.txt | tr -d ' ')
if [ "$LINES" -lt 13 ]; then
  echo "FAIL: Expected at least 13 checklist items"
  exit 1
fi
if [ ! -x /root/quick-audit.sh ]; then
  echo "FAIL: /root/quick-audit.sh not found or not executable"
  exit 1
fi
if [ ! -f /root/audit-results.txt ] || [ ! -s /root/audit-results.txt ]; then
  echo "FAIL: /root/audit-results.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
