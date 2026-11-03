#!/bin/bash
# expect-exit: 0
kubectl delete pod secure-pod --wait=true --timeout=120s
