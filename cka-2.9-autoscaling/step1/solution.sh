#!/bin/bash
kubectl autoscale deployment scale-app -n practice \
  --cpu-percent=50 --min=1 --max=5 2>/dev/null || true
