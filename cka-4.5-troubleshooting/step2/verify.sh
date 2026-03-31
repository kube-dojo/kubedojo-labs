#!/bin/bash
# Verify: broken-pvc-access is now Bound
for i in $(seq 1 30); do
  STATUS=$(kubectl get pvc broken-pvc-access -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Bound" ] && exit 0
  sleep 2
done
exit 1
