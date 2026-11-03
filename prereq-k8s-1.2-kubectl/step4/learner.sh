#!/bin/bash
# expect-exit: 0
kubectl run test-pod --image=busybox --dry-run=client -o yaml

# expect-exit: 0
kubectl create deployment test-deploy --image=nginx --dry-run=client -o yaml

# expect-exit: 0
kubectl explain pod.spec

# expect-exit: 0
kubectl explain pod.spec.containers

# expect-exit: 0
kubectl explain pod.spec.containers.ports

# expect-exit: 0
kubectl run nginx --image=nginx:1.25 --dry-run=client -o yaml > "$HOME"/nginx-pod.yaml
