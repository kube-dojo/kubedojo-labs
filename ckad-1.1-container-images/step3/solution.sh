#!/bin/bash
kubectl delete pod broken-app -n images-lab --grace-period=0 --force
kubectl run broken-app --image=nginx:1.25 -n images-lab
kubectl wait --for=condition=Ready pod/broken-app -n images-lab --timeout=60s
