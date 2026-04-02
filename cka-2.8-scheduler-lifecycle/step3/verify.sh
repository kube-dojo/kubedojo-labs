#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: critical-pod is Running
for i in $(seq 1 30); do
  STATUS=$(kubectl get pod critical-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Running" ] && exit 0
  sleep 2
done
exit 1
