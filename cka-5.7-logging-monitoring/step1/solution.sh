#!/bin/bash
kubectl logs multi-log -n practice -c app --since=1h --timestamps > /root/app-logs.txt
echo "=== Sidecar logs ===" >> /root/app-logs.txt
kubectl logs multi-log -n practice -c sidecar --since=1h --timestamps >> /root/app-logs.txt
cat /root/app-logs.txt | head -10
