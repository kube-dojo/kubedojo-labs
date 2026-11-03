#!/bin/bash
set -e
if id ubuntu &>/dev/null; then USER_HOME=/home/ubuntu; else USER_HOME=/root; fi
kubectl run nginx-pod --image=nginx:1.25 --dry-run=client -o yaml > "$USER_HOME/pod-spec.yaml"
