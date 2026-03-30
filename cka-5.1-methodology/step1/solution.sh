#!/bin/bash
kubectl describe pod broken-app -n practice | grep -A10 "Events:" > /root/diagnosis.txt
kubectl delete pod broken-app -n practice
kubectl run broken-app --image=nginx:1.25 -n practice
kubectl wait --for=condition=Ready pod/broken-app -n practice --timeout=60s
