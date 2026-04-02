#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: pv-small reclaim policy was changed (it may have been deleted already if PVC was bound and removed)
POLICY=$(kubectl get pv pv-small -o jsonpath='{.spec.persistentVolumeReclaimPolicy}' 2>/dev/null)
# Either the PV has Delete policy or it was already deleted (both are valid)
[ "$POLICY" = "Delete" ] && exit 0
# If pv-small doesn't exist anymore, it was deleted by the Delete policy — that's correct
kubectl get pv pv-small 2>/dev/null
if [ $? -ne 0 ]; then
  exit 0
fi
exit 1
