#!/bin/bash
if [ ! -f /root/safe-script.sh ]; then
  echo "FAIL: /root/safe-script.sh not found"
  exit 1
fi

if ! grep -q "set -e" /root/safe-script.sh; then
  echo "FAIL: Script should contain 'set -e'"
  exit 1
fi

if ! grep -q "trap" /root/safe-script.sh; then
  echo "FAIL: Script should contain a 'trap' statement"
  exit 1
fi

echo "PASS: Script contains set -e and trap"
exit 0
