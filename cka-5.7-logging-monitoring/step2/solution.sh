#!/bin/bash
kubectl get events -n practice --sort-by='.lastTimestamp' -o wide > /root/events.txt
echo "---" >> /root/events.txt
echo "=== Warning Events ===" >> /root/events.txt
kubectl get events -n practice --field-selector=type=Warning >> /root/events.txt 2>&1
cat /root/events.txt | head -20
