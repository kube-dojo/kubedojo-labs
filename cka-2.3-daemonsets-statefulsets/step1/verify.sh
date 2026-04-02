#!/bin/bash
DS=$(kubectl get ds log-collector -n practice -o json 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "FAIL: DaemonSet log-collector not found"
  exit 1
fi

IMAGE=$(echo "$DS" | jq -r '.spec.template.spec.containers[0].image')
if [[ "$IMAGE" != *"fluentd"* ]]; then
  echo "FAIL: Incorrect image. Expected fluentd, found: $IMAGE"
  exit 1
fi

DESIRED=$(echo "$DS" | jq -r '.status.desiredNumberScheduled')
AVAIL=$(echo "$DS" | jq -r '.status.numberAvailable')

if [ "$DESIRED" -gt 0 ] && [ "$DESIRED" = "$AVAIL" ]; then
  echo "PASS: DaemonSet is available on all $DESIRED nodes"
  exit 0
else
  echo "FAIL: Waiting for pods to be available. Desired: $DESIRED, Available: $AVAIL"
  exit 1
fi