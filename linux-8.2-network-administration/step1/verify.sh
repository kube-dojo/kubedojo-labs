#!/bin/bash
if ip addr show dummy0 2>/dev/null | grep -q "10.10.10.1"; then
  echo "PASS: dummy0 has IP 10.10.10.1"
  exit 0
else
  echo "FAIL: dummy0 does not have IP 10.10.10.1/24"
  exit 1
fi
