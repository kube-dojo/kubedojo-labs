#!/bin/bash
# expect-exit: 0
kubectl scale deployment webapp --replicas=4

# expect-exit: 0
kubectl get pods -l app=webapp

# expect-exit: 0
kubectl scale deployment webapp --replicas=2

# expect-exit: 0
kubectl get deployment webapp

# expect-exit: 0
kubectl scale deployment webapp --replicas=5
