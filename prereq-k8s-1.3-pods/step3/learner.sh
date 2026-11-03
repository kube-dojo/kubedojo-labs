#!/bin/bash
# The text inspects a running pod; bound the wait for its earlier creation to become ready.
# expect-exit: 0
kubectl wait --for=condition=Ready pod/web --timeout=120s

# expect-exit: 0
kubectl describe pod web

# expect-exit: 0
kubectl logs web

# expect-exit: 0
kubectl get pod web -o wide

# expect-exit: 0
kubectl get pod web -o jsonpath='{.status.podIP}'

# expect-exit: 0
kubectl get pod web -o jsonpath='{.status.podIP}' > "$HOME"/web-pod-ip.txt
