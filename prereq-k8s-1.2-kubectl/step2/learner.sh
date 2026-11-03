#!/bin/bash
# expect-exit: 0
kubectl explain pod

# expect-exit: 0
kubectl explain pod.spec.containers --recursive

# expect-exit: 0
kubectl run nginx-pod --image=nginx:1.25 --dry-run=client -o yaml > "$HOME"/pod-spec.yaml
