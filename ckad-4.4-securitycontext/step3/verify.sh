#!/bin/bash
NR=$(kubectl get pod nonroot-pod -n security-lab -o jsonpath='{.spec.securityContext.runAsNonRoot}' 2>/dev/null)
if [ "$NR" != "true" ]; then
  echo "FAIL: runAsNonRoot should be true"
  exit 1
fi
PE=$(kubectl get pod nonroot-pod -n security-lab -o jsonpath='{.spec.containers[0].securityContext.allowPrivilegeEscalation}' 2>/dev/null)
if [ "$PE" != "false" ]; then
  echo "FAIL: allowPrivilegeEscalation should be false"
  exit 1
fi
if [ ! -f /root/nonroot-value.txt ]; then
  echo "FAIL: /root/nonroot-value.txt not found"
  exit 1
fi
if [ ! -f /root/priv-escalation.txt ]; then
  echo "FAIL: /root/priv-escalation.txt not found"
  exit 1
fi
echo "PASS"
exit 0
