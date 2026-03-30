#!/bin/bash
kubectl get events -n monitoring-lab --sort-by='.lastTimestamp' > /root/events.txt
kubectl get events -A --field-selector type=Warning > /root/warning-events.txt 2>/dev/null || echo "No warning events" > /root/warning-events.txt
