#!/bin/bash
kubectl top pods -n practice > /root/resource-usage.txt 2>&1 || \
  echo "Metrics not yet available — this is expected in some lab environments" > /root/resource-usage.txt
kubectl top nodes >> /root/resource-usage.txt 2>&1 || true
