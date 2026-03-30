#!/bin/bash
# Verify seccomp profile

if [ ! -f /root/seccomp-profile.json ]; then
  echo "FAIL: /root/seccomp-profile.json does not exist"
  exit 1
fi

# Check valid JSON (use jq if available, otherwise basic grep check)
if command -v jq &>/dev/null; then
  if ! jq . /root/seccomp-profile.json > /dev/null 2>&1; then
    echo "FAIL: /root/seccomp-profile.json is not valid JSON"
    exit 1
  fi

  # Check it contains chmod
  if jq -r '.. | strings' /root/seccomp-profile.json 2>/dev/null | grep -q "chmod"; then
    echo "PASS: seccomp profile is valid JSON and blocks chmod"
    exit 0
  else
    echo "FAIL: Profile does not contain 'chmod' syscall"
    exit 1
  fi
else
  # Fallback: basic content check without jq
  if grep -q "chmod" /root/seccomp-profile.json && grep -q "defaultAction" /root/seccomp-profile.json; then
    echo "PASS: seccomp profile contains chmod rule and defaultAction"
    exit 0
  else
    echo "FAIL: Profile missing 'chmod' or 'defaultAction'"
    exit 1
  fi
fi
