#!/bin/bash
# Verify: connectivity file exists and pod-a service exists
[ -f /root/connectivity.txt ] && [ -s /root/connectivity.txt ] && kubectl get svc pod-a -n practice -o name 2>/dev/null | grep -q "service" && exit 0 || exit 1
