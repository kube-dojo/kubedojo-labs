#!/bin/bash
# Verify: pod is running and pod-ip.txt contains a valid IP
POD_STATUS=$(kubectl get pod network-test -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
IP_FILE=$(cat /root/pod-ip.txt 2>/dev/null)
[ "$POD_STATUS" = "Running" ] && echo "$IP_FILE" | grep -qE '^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$' && exit 0 || exit 1
