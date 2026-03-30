#!/bin/bash
kubectl get pods -n kube-system --no-headers | wc -l | tr -d ' ' > /root/cp-pod-count.txt
