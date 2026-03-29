#!/bin/bash
# Verify pod "api" exists in the default namespace
kubectl get pod api -n default > /dev/null 2>&1 || exit 1
exit 0
