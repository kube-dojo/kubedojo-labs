#!/bin/bash
# Verify pod "web" exists and is Running
kubectl get pod web -o jsonpath='{.status.phase}' 2>/dev/null | grep -q "Running" || exit 1
exit 0
