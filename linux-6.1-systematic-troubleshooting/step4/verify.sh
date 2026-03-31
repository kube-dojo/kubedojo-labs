#!/bin/bash
if [ ! -f /root/troubleshooting-report.txt ]; then
  echo "FAIL: /root/troubleshooting-report.txt not found"
  exit 1
fi

SECTIONS=0
for keyword in "Problem" "Investigation" "Root Cause|Cause" "Fix|Resolution"; do
  if grep -qiE "$keyword" /root/troubleshooting-report.txt; then
    SECTIONS=$((SECTIONS + 1))
  fi
done

if [ "$SECTIONS" -ge 4 ]; then
  echo "PASS: Report has all 4 required sections"
  exit 0
else
  echo "FAIL: Report should have 4 sections (Problem, Investigation, Root Cause, Fix), found $SECTIONS"
  exit 1
fi
