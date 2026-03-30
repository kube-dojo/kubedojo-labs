#!/bin/bash
if [ ! -f /root/security-flags.txt ]; then
  echo "FAIL: /root/security-flags.txt not found"
  exit 1
fi
COUNT=$(wc -l < /root/security-flags.txt | tr -d ' ')
if [ "$COUNT" -lt 5 ]; then
  echo "FAIL: Expected at least 5 security flags, got $COUNT"
  exit 1
fi
if [ ! -f /root/auth-modes.txt ] || [ ! -s /root/auth-modes.txt ]; then
  echo "FAIL: /root/auth-modes.txt missing or empty"
  exit 1
fi
if [ ! -f /root/kubelet-auth.txt ] || [ ! -s /root/kubelet-auth.txt ]; then
  echo "FAIL: /root/kubelet-auth.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
