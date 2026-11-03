#!/bin/bash
set -eo pipefail
kubectl run secure-pod --namespace=default --image=nginx:1.25 --labels=app=secure --dry-run=client -o yaml | kubectl apply -f -
