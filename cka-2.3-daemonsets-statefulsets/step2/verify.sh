#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Check if 3 pods are ready in order
if ! kubectl get pod web-sts-2 -n practice >/dev/null 2>&1; then
  echo "FAIL: Pod web-sts-2 not found. Is the StatefulSet scaled to 3?"
  exit 1
fi

READY_COUNT=$(kubectl get sts web-sts -n practice -o jsonpath='{.status.readyReplicas}')
if [ "$READY_COUNT" -eq 3 ]; then
  echo "PASS: StatefulSet scaled to 3 and pods are ready"
  exit 0
else
  echo "FAIL: Only $READY_COUNT replicas are ready"
  exit 1
fi