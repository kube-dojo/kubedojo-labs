#!/bin/bash
kubectl get pods -n kube-system | grep -E 'scheduler|controller-manager' > /root/cp-health.txt
echo "Control plane health:"
cat /root/cp-health.txt
