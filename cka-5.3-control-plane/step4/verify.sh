#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: scheduler is running and test pod is Running
for i in $(seq 1 30); do
  SCHED=$(kubectl get pods -n kube-system -l component=kube-scheduler --field-selector=status.phase=Running -o name 2>/dev/null | head -1)
  POD_STATUS=$(kubectl get pod scheduler-test -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ -n "$SCHED" ] && [ "$POD_STATUS" = "Running" ] && exit 0
  sleep 2
done
exit 1
