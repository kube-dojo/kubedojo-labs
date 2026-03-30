#!/bin/bash
# Verify: DaemonSet desired = available
for i in $(seq 1 30); do
  DESIRED=$(kubectl get daemonset log-collector -n practice -o jsonpath='{.status.desiredNumberScheduled}' 2>/dev/null)
  AVAILABLE=$(kubectl get daemonset log-collector -n practice -o jsonpath='{.status.numberAvailable}' 2>/dev/null)
  [ -n "$DESIRED" ] && [ "$DESIRED" -gt 0 ] && [ "$DESIRED" = "$AVAILABLE" ] && exit 0
  sleep 2
done
exit 1
