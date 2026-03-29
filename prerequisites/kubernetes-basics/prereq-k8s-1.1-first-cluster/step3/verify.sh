#!/bin/bash
# Verify namespace my-first-ns exists
kubectl get namespace my-first-ns > /dev/null 2>&1 || exit 1
exit 0
