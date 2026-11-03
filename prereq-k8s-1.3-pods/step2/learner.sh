#!/bin/bash
# expect-exit: 0
kubectl run secure-pod --namespace=default --image=nginx:1.25 --labels=app=secure
