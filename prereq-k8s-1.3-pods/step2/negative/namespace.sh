#!/bin/bash
set -euo pipefail
kubectl create namespace wrong-namespace
kubectl run secure-pod -n wrong-namespace --image=nginx:1.25 --labels=app=secure
