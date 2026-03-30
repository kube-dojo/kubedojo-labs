#!/bin/bash
# Verify: VolumeSnapshot exists with correct source PVC
VS=$(kubectl get volumesnapshot source-snapshot -n practice -o jsonpath='{.metadata.name}' 2>/dev/null)
SOURCE=$(kubectl get volumesnapshot source-snapshot -n practice -o jsonpath='{.spec.source.persistentVolumeClaimName}' 2>/dev/null)
[ "$VS" = "source-snapshot" ] && [ "$SOURCE" = "source-pvc" ] && exit 0 || exit 1
