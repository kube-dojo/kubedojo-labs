#!/bin/bash
if [ ! -f /root/alert-rules.txt ] || [ ! -s /root/alert-rules.txt ]; then
  echo "FAIL: /root/alert-rules.txt missing or empty"
  exit 1
fi
if ! grep -c "RULE:" /root/alert-rules.txt | grep -q '[5-9]\|[1-9][0-9]'; then
  echo "FAIL: Expected at least 5 alert rules"
  exit 1
fi
if [ ! -x /root/check-secrets-access.sh ]; then
  echo "FAIL: /root/check-secrets-access.sh not found or not executable"
  exit 1
fi
if [ ! -f /root/secrets-access-report.txt ] || [ ! -s /root/secrets-access-report.txt ]; then
  echo "FAIL: /root/secrets-access-report.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
