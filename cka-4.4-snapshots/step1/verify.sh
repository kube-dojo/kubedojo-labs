#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify: VolumeSnapshot CRDs and VolumeSnapshotClass exist
CRD_COUNT=$(kubectl get crd 2>/dev/null | grep -c "volumesnapshot")
VSC=$(kubectl get volumesnapshotclass csi-snapclass -o jsonpath='{.metadata.name}' 2>/dev/null)
[ "$CRD_COUNT" -ge 3 ] && [ "$VSC" = "csi-snapclass" ] && exit 0 || exit 1
