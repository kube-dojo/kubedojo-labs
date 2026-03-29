#!/bin/bash
# Verify pod "api" no longer exists
kubectl get pod api > /dev/null 2>&1 && exit 1
exit 0
