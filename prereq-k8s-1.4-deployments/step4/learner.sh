#!/bin/bash
# expect-exit: 0
kubectl rollout history deployment/webapp

# expect-exit: 0
kubectl rollout undo deployment/webapp

# expect-exit: 0
kubectl rollout status deployment/webapp --timeout=120s

# expect-exit: 0
kubectl describe deployment webapp | grep "Image:"
