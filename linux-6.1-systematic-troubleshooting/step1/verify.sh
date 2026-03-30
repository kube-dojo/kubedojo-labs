#!/bin/bash
if [ ! -f /root/system-report.txt ]; then
  echo "FAIL: /root/system-report.txt not found"
  exit 1
fi

ERRORS=0
for check in "$(hostname)" "$(uname -r)"; do
  if ! grep -q "$check" /root/system-report.txt; then
    echo "WARN: Missing expected content: $check"
    ERRORS=$((ERRORS + 1))
  fi
done

# Check for disk and memory sections
grep -qi "disk\|filesystem\|Mounted" /root/system-report.txt || ERRORS=$((ERRORS + 1))
grep -qi "mem\|memory\|free" /root/system-report.txt || ERRORS=$((ERRORS + 1))

LINES=$(wc -l < /root/system-report.txt)
if [ "$LINES" -ge 5 ] && [ "$ERRORS" -le 1 ]; then
  echo "PASS: System report contains required information"
  exit 0
else
  echo "FAIL: System report is incomplete ($ERRORS issues)"
  exit 1
fi
