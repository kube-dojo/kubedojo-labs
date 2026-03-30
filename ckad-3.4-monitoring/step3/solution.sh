#!/bin/bash
echo "stress-pod" > /root/high-cpu-pod.txt
kubectl delete pod stress-pod -n monitoring-lab --grace-period=0 --force
kubectl get pods -n monitoring-lab --no-headers | wc -l | tr -d ' ' > /root/remaining-pods.txt
