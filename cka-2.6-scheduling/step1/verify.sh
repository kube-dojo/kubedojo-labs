#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: pod is running on a node with disk=ssd label
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod ssd-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  NODE=$(kubectl get pod ssd-pod -n practice -o jsonpath='{.spec.nodeName}' 2>/dev/null)
  if [ "$STATUS" = "Running" ] && [ -n "$NODE" ]; then
    LABEL=$(kubectl get node "$NODE" -o jsonpath='{.metadata.labels.disk}' 2>/dev/null)
    [ "$LABEL" = "ssd" ] && exit 0
  fi
  sleep 2
done
exit 1
