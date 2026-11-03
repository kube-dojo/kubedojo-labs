#!/bin/bash
# expect-exit: 0
kubectl describe deployment webapp | grep "Image:"

# expect-exit: 0
kubectl set image deployment/webapp nginx=nginx:1.26

# expect-exit: 0
kubectl rollout status deployment/webapp --timeout=120s

# expect-exit: 0
kubectl rollout history deployment/webapp

# expect-exit: 0
kubectl describe deployment webapp | grep "Image:"
