#!/bin/bash
if [ ! -f /root/api-check.sh ]; then
  echo "FAIL: /root/api-check.sh not found"
  exit 1
fi

if [ ! -x /root/api-check.sh ]; then
  echo "FAIL: /root/api-check.sh is not executable"
  exit 1
fi

OUTPUT=$(/root/api-check.sh 2>&1)
if echo "$OUTPUT" | grep -qi "status\|version\|healthy"; then
  echo "PASS: Script produces parsed API output"
  exit 0
else
  echo "FAIL: Script should produce parsed API output, got: $OUTPUT"
  exit 1
fi
