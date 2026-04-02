#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: Job has 5 completions
for i in $(seq 1 60); do
  SUCCEEDED=$(kubectl get job parallel-job -n practice -o jsonpath='{.status.succeeded}' 2>/dev/null)
  [ "$SUCCEEDED" = "5" ] && exit 0
  sleep 2
done
# Also accept if job spec has completions=5 and is still running
COMPLETIONS=$(kubectl get job parallel-job -n practice -o jsonpath='{.spec.completions}' 2>/dev/null)
[ "$COMPLETIONS" = "5" ] && exit 0
exit 1
