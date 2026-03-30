#!/bin/bash
kubectl delete pod image-pod -n practice --force --grace-period=0 2>/dev/null
sleep 2
kubectl run image-pod --image=nginx:1.25 -n practice
kubectl wait --for=condition=Ready pod/image-pod -n practice --timeout=60s
