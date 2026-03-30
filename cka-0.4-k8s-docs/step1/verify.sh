#!/bin/bash
if [ ! -f /root/pod-spec-fields.txt ]; then
  echo "FAIL: /root/pod-spec-fields.txt does not exist"
  exit 1
fi

if grep -q "containers" /root/pod-spec-fields.txt; then
  echo "PASS: File contains pod spec fields including 'containers'"
  exit 0
else
  echo "FAIL: File should contain pod spec fields (expected 'containers')"
  exit 1
fi
