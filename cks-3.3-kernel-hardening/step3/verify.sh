#!/bin/bash
if ! kubectl get pod hardened-complete -n kernel-lab &>/dev/null; then
  echo "FAIL: Pod hardened-complete not found"
  exit 1
fi
READONLY=$(kubectl get pod hardened-complete -n kernel-lab -o jsonpath='{.spec.containers[0].securityContext.readOnlyRootFilesystem}')
if [ "$READONLY" != "true" ]; then
  echo "FAIL: readOnlyRootFilesystem should be true"
  exit 1
fi
for f in hardened-pod.yaml hardening-checklist.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
