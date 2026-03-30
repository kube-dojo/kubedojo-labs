#!/bin/bash
# Verify seccomp status file

if [ ! -f /root/seccomp-status.txt ]; then
  echo "FAIL: /root/seccomp-status.txt does not exist"
  exit 1
fi

if grep -qi "seccomp" /root/seccomp-status.txt; then
  echo "PASS: seccomp status documented"
  exit 0
else
  echo "FAIL: /root/seccomp-status.txt does not contain 'Seccomp' information"
  exit 1
fi
