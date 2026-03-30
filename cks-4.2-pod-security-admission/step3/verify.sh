#!/bin/bash
if ! kubectl get namespace psa-transition &>/dev/null; then
  echo "FAIL: Namespace psa-transition not found"
  exit 1
fi
ENFORCE=$(kubectl get namespace psa-transition -o jsonpath='{.metadata.labels.pod-security\.kubernetes\.io/enforce}')
if [ "$ENFORCE" != "baseline" ]; then
  echo "FAIL: psa-transition should enforce=baseline"
  exit 1
fi
WARN=$(kubectl get namespace psa-transition -o jsonpath='{.metadata.labels.pod-security\.kubernetes\.io/warn}')
if [ "$WARN" != "restricted" ]; then
  echo "FAIL: psa-transition should warn=restricted"
  exit 1
fi
for f in psa-warnings.txt psa-migration-plan.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
