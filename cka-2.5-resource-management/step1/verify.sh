#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: ResourceQuota exists with correct limits
PODS=$(kubectl get quota ns-quota -n quota-test -o jsonpath='{.spec.hard.pods}' 2>/dev/null)
CPU=$(kubectl get quota ns-quota -n quota-test -o jsonpath='{.spec.hard.requests\.cpu}' 2>/dev/null)
MEM=$(kubectl get quota ns-quota -n quota-test -o jsonpath='{.spec.hard.requests\.memory}' 2>/dev/null)

[ "$PODS" = "2" ] && [ "$CPU" = "500m" ] && [ "$MEM" = "512Mi" ] && exit 0
exit 1
