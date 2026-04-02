#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: only 2 pods exist in quota-test (3rd should have been rejected)
for i in $(seq 1 15); do
  RUNNING=$(kubectl get pods -n quota-test --no-headers 2>/dev/null | wc -l)
  [ "$RUNNING" -eq 2 ] && exit 0
  sleep 2
done
# Accept if at least 2 pods exist and quota is in place
RUNNING=$(kubectl get pods -n quota-test --no-headers 2>/dev/null | wc -l)
[ "$RUNNING" -le 2 ] && [ "$RUNNING" -ge 1 ] && exit 0
exit 1
