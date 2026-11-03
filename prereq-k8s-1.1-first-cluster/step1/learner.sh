#!/bin/bash
# expect-exit: 0
kubectl cluster-info

# expect-exit: 0
kubectl get nodes

# expect-exit: 0
kubectl get nodes -o wide

# expect-exit: 0
kubectl get namespaces

# expect-exit: 0
kubectl get nodes -o jsonpath='{.items[0].metadata.name}' > "$HOME"/node-name.txt
