#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
DEP=$(kubectl get deployment web-deploy -n practice -o json 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "FAIL: Deployment web-deploy not found"
  exit 1
fi

# Verify strategy
STRATEGY=$(echo "$DEP" | jq -r '.spec.strategy.type')
SURGE=$(echo "$DEP" | jq -r '.spec.strategy.rollingUpdate.maxSurge')
UNAVAIL=$(echo "$DEP" | jq -r '.spec.strategy.rollingUpdate.maxUnavailable')

if [ "$STRATEGY" = "RollingUpdate" ] && [ "$SURGE" = "1" ] && [ "$UNAVAIL" = "0" ]; then
  # Check if at least 3 replicas are available
  AVAIL=$(echo "$DEP" | jq -r '.status.availableReplicas')
  if [ "$AVAIL" -ge 3 ]; then
    echo "PASS: Deployment strategy and availability verified"
    exit 0
  else
    echo "FAIL: Waiting for replicas to be available (found $AVAIL)"
    exit 1
  fi
else
  echo "FAIL: Strategy parameters mismatch. Expected RollingUpdate, Surge: 1, Unavail: 0"
  exit 1
fi