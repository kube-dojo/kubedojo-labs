#!/bin/bash
# Verify that /root/dig-output.txt exists and contains dig output
if [ ! -f /root/dig-output.txt ]; then
  echo "FAIL: /root/dig-output.txt does not exist"
  exit 1
fi

# Check for ANSWER SECTION or an IP address in the output
if grep -q "ANSWER SECTION" /root/dig-output.txt; then
  echo "PASS: File contains dig ANSWER SECTION"
  exit 0
fi

if grep -qE '[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+' /root/dig-output.txt; then
  echo "PASS: File contains an IP address"
  exit 0
fi

echo "FAIL: /root/dig-output.txt does not contain expected dig output"
exit 1
