#!/bin/bash
# Delete the broken pod and recreate with correct image
kubectl delete pod broken-pod -n practice --ignore-not-found
kubectl run broken-pod --image=nginx:1.25 -n practice
kubectl wait --for=condition=Ready pod/broken-pod -n practice --timeout=60s
