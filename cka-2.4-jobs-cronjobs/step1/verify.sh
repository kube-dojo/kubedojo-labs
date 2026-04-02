#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: Job completed successfully
for i in $(seq 1 60); do
  SUCCEEDED=$(kubectl get job pi-job -n practice -o jsonpath='{.status.succeeded}' 2>/dev/null)
  [ "$SUCCEEDED" = "1" ] && exit 0
  sleep 2
done
exit 1
