#!/bin/bash
# Wait for metrics to be available
for i in $(seq 1 60); do
  kubectl top nodes > /root/node-metrics.txt 2>/dev/null && break
  sleep 5
done
kubectl top pods -n monitoring-lab > /root/pod-metrics.txt 2>/dev/null || echo "Metrics not yet available" > /root/pod-metrics.txt
