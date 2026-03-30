#!/bin/bash
# Verify: hostpath-pod exists with hostPath volume
HP=$(kubectl get pod hostpath-pod -n practice -o jsonpath='{.spec.volumes[0].hostPath.path}' 2>/dev/null)
[ "$HP" = "/data/hostpath-test" ] && exit 0 || exit 1
