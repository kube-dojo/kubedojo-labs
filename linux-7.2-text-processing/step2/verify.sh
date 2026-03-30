#!/bin/bash
if [ ! -f /root/sed-output.txt ]; then
  echo "FAIL: /root/sed-output.txt not found"
  exit 1
fi

if grep -q "DATABASE_HOST\|DATABASE_PORT\|LOG_LEVEL" /root/sed-output.txt; then
  echo "PASS: sed-output.txt contains uppercase keys"
  exit 0
else
  echo "FAIL: Keys should be uppercase (e.g., DATABASE_HOST=localhost)"
  exit 1
fi
