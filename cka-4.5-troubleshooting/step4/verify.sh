#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: broken-pvc-capacity is now Bound
for i in $(seq 1 30); do
  STATUS=$(kubectl get pvc broken-pvc-capacity -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS" = "Bound" ] && exit 0
  sleep 2
done
exit 1
