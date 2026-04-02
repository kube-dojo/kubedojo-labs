#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: both PVCs exist and are Bound
for i in $(seq 1 30); do
  STATUS1=$(kubectl get pvc pvc-app -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  STATUS2=$(kubectl get pvc pvc-shared -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$STATUS1" = "Bound" ] && [ "$STATUS2" = "Bound" ] && exit 0
  sleep 2
done
exit 1
