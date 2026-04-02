#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: PVC is bound and pod is running
for i in $(seq 1 30); do
  PVC_STATUS=$(kubectl get pvc dynamic-pvc -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  POD_STATUS=$(kubectl get pod dynamic-pod -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$PVC_STATUS" = "Bound" ] && [ "$POD_STATUS" = "Running" ] && exit 0
  sleep 2
done
exit 1
