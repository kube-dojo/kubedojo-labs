#!/bin/bash
# expect-exit: 0
kubectl run nginx --image=nginx

# expect-exit: 0
kubectl get pods

# Replay the text's watch followed by Ctrl+C with a bounded interrupt.
# expect-exit: 124
timeout --signal=INT 2s kubectl get pods -w

# expect-exit: 0
kubectl run redis --image=redis:7.2

# expect-exit: 0
kubectl run web --image=nginx:1.25
