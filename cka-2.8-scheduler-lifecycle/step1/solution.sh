#!/bin/bash
kubectl run lifecycle-pod --image=busybox:1.36 -n practice \
  --restart=Never -- sh -c 'echo "Task complete"; exit 0' 2>/dev/null || true
sleep 5
