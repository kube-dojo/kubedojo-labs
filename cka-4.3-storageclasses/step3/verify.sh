#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: fast-local is default and default-pvc is bound
for i in $(seq 1 30); do
  IS_DEFAULT=$(kubectl get sc fast-local -o jsonpath='{.metadata.annotations.storageclass\.kubernetes\.io/is-default-class}' 2>/dev/null)
  PVC_STATUS=$(kubectl get pvc default-pvc -n practice -o jsonpath='{.status.phase}' 2>/dev/null)
  [ "$IS_DEFAULT" = "true" ] && [ "$PVC_STATUS" = "Bound" ] && exit 0
  sleep 2
done
exit 1
