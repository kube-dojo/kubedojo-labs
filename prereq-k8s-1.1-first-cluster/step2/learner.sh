#!/bin/bash
# expect-exit: 0
kubectl get pods -n kube-system

# expect-exit: 0
kubectl get pods -n kube-system --no-headers | wc -l

# expect-exit: 0
kubectl get pods -n kube-system --no-headers | wc -l | tr -d ' ' > "$HOME"/cp-pod-count.txt
