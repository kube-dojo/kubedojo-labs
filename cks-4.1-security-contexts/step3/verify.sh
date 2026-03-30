#!/bin/bash
if ! kubectl get pod no-escalation -n secctx-lab &>/dev/null; then
  echo "FAIL: Pod no-escalation not found"
  exit 1
fi
APE=$(kubectl get pod no-escalation -n secctx-lab -o jsonpath='{.spec.containers[0].securityContext.allowPrivilegeEscalation}')
if [ "$APE" != "false" ]; then
  echo "FAIL: allowPrivilegeEscalation should be false"
  exit 1
fi
for f in pod-caps.txt escalation-risks.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
