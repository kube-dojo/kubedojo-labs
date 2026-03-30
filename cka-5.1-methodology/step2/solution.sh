#!/bin/bash
# Create a debug copy of the pod
kubectl debug debug-target -n practice --image=busybox:1.36 --copy-to=debug-copy --share-processes -- sleep 3600
sleep 5
kubectl get pod debug-copy -n practice
