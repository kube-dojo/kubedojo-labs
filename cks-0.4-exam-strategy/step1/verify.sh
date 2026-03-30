#!/bin/bash
PRIV=$(kubectl get pod fix-me-1 -n exam-practice -o jsonpath='{.spec.containers[0].securityContext.privileged}' 2>/dev/null)
if [ "$PRIV" == "true" ]; then
  echo "FAIL: fix-me-1 is still privileged"
  exit 1
fi
USER=$(kubectl get pod fix-me-2 -n exam-practice -o jsonpath='{.spec.containers[0].securityContext.runAsUser}' 2>/dev/null)
if [ "$USER" == "0" ] || [ -z "$USER" ]; then
  echo "FAIL: fix-me-2 still running as root"
  exit 1
fi
if [ ! -f /root/fix1-context.txt ] || [ ! -s /root/fix1-context.txt ]; then
  echo "FAIL: /root/fix1-context.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
