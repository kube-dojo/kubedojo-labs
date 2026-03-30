#!/bin/bash
kubectl delete pod crash-pod -n practice --force --grace-period=0 2>/dev/null
sleep 2
kubectl run crash-pod --image=busybox:1.36 -n practice -- sleep 3600
kubectl wait --for=condition=Ready pod/crash-pod -n practice --timeout=60s
