#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: 4 replicas ready
for i in $(seq 1 30); do
  READY=$(kubectl get deployment scale-app -n practice -o jsonpath='{.status.readyReplicas}' 2>/dev/null)
  [ "$READY" = "4" ] && exit 0
  sleep 2
done
exit 1
