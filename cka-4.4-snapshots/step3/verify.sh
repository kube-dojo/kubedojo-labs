#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: restored-pvc exists with dataSource referencing the snapshot
PVC=$(kubectl get pvc restored-pvc -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
DS_NAME=$(kubectl get pvc restored-pvc -n practice -o jsonpath='{.spec.dataSource.name}' 2>/dev/null)
DS_KIND=$(kubectl get pvc restored-pvc -n practice -o jsonpath='{.spec.dataSource.kind}' 2>/dev/null)
[ "$PVC" = "restored-pvc" ] && [ "$DS_NAME" = "source-snapshot" ] && [ "$DS_KIND" = "VolumeSnapshot" ] && exit 0 || exit 1
