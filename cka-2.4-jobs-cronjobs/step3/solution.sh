#!/bin/bash
kubectl create cronjob heartbeat --image=busybox:1.36 \
  --schedule="*/1 * * * *" -n practice \
  -- sh -c 'echo "Heartbeat at $(date)"' 2>/dev/null || true

# Wait for at least one job to be spawned
for i in $(seq 1 45); do
  JOBS=$(kubectl get jobs -n practice -o name 2>/dev/null | grep -c "heartbeat")
  [ "$JOBS" -ge 1 ] && break
  sleep 2
done
