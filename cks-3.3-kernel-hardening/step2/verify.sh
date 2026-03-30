#!/bin/bash
if ! kubectl get pod no-caps -n kernel-lab &>/dev/null; then
  echo "FAIL: Pod no-caps not found"
  exit 1
fi
if ! kubectl get pod net-caps -n kernel-lab &>/dev/null; then
  echo "FAIL: Pod net-caps not found"
  exit 1
fi
CAPS=$(kubectl get pod no-caps -n kernel-lab -o jsonpath='{.spec.containers[0].securityContext.capabilities.drop[*]}')
if [[ "$CAPS" != *"ALL"* ]]; then
  echo "FAIL: no-caps should drop ALL capabilities"
  exit 1
fi
for f in default-caps.txt caps-comparison.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
