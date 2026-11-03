#!/bin/bash
set -euo pipefail
kubectl run secure-pod -n default --image=nginx:1.26 --labels=app=secure
