#!/bin/bash
if [ ! -f /root/check-disk.sh ]; then
  echo "FAIL: /root/check-disk.sh not found"
  exit 1
fi

if [ ! -x /root/check-disk.sh ]; then
  echo "FAIL: /root/check-disk.sh is not executable"
  exit 1
fi

OUTPUT=$(/root/check-disk.sh 2>&1)
if echo "$OUTPUT" | grep -qE "(OK|WARNING)"; then
  echo "PASS: Script outputs OK or WARNING: $OUTPUT"
  exit 0
else
  echo "FAIL: Script should output OK or WARNING, got: $OUTPUT"
  exit 1
fi
