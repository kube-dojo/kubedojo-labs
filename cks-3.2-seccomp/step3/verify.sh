#!/bin/bash
if [ ! -f /var/lib/kubelet/seccomp/profiles/audit.json ]; then
  echo "FAIL: Audit seccomp profile not found"
  exit 1
fi
if ! kubectl get pod audit-pod -n seccomp-lab &>/dev/null; then
  echo "FAIL: Pod audit-pod not found"
  exit 1
fi
if [ ! -f /root/seccomp-best-practices.txt ]; then
  echo "FAIL: /root/seccomp-best-practices.txt not found"
  exit 1
fi
LINES=$(wc -l < /root/seccomp-best-practices.txt | tr -d ' ')
if [ "$LINES" -lt 4 ]; then
  echo "FAIL: Expected at least 4 best practices"
  exit 1
fi
echo "PASS"
exit 0
