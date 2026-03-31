#!/bin/bash
# Verify: pod is running and pod-ip.txt contains a valid IP
for i in $(seq 1 30); do
  POD_STATUS=$(kubectl get pod network-test -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  IP_FILE=$(cat /root/pod-ip.txt 2>/dev/null)
  if [ "$POD_STATUS" = "Running" ] && echo "$IP_FILE" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$'; then exit 0; fi
  sleep 2
done
exit 1
