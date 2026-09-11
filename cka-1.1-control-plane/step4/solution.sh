#!/bin/bash
kubectl get pods -n kube-system | grep -E 'scheduler|controller-manager' > "$HOME"/cp-health.txt
echo "Control plane health:"
cat "$HOME"/cp-health.txt
