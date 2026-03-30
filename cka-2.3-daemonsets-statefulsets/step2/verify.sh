#!/bin/bash
# Verify: pods named web-sts-0, web-sts-1, web-sts-2 exist
for i in $(seq 1 30); do
  P0=$(kubectl get pod web-sts-0 -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
  P1=$(kubectl get pod web-sts-1 -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
  P2=$(kubectl get pod web-sts-2 -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
  [ "$P0" = "web-sts-0" ] && [ "$P1" = "web-sts-1" ] && [ "$P2" = "web-sts-2" ] && exit 0
  sleep 2
done
exit 1
