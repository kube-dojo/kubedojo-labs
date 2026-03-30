#!/bin/bash
if [ ! -f /root/cp-health.txt ]; then
  echo "FAIL: /root/cp-health.txt does not exist"
  exit 1
fi

if grep -qi -E "scheduler|controller" /root/cp-health.txt; then
  echo "PASS: File contains control plane health information"
  exit 0
else
  echo "FAIL: File should contain scheduler and controller-manager status"
  exit 1
fi
