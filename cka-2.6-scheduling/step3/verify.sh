#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: affinity-pod is Running on matching node
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod affinity-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  AFFINITY=$(kubectl get pod affinity-pod -n practice -o jsonpath='{.spec.affinity.nodeAffinity}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && [ -n "$AFFINITY" ] && exit 0
  sleep 2
done
exit 1
