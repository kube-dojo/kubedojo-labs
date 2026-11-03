#!/bin/bash
# expect-exit: 0
kubectl get nodes -o wide

# expect-exit: 0
NODE=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')

# expect-exit: 0
kubectl get node "$NODE" -o yaml

# expect-exit: 0
kubectl get node "$NODE" -o json

# expect-exit: 0
kubectl get node "$NODE" -o jsonpath='{.metadata.name}'

# expect-exit: 0
kubectl get node "$NODE" -o jsonpath='{.status.addresses[0].address}'

# expect-exit: 0
kubectl get node "$NODE" -o jsonpath='{.status.addresses[?(@.type=="InternalIP")].address}' > "$HOME"/node-ip.txt
