#!/bin/bash
kubectl get pods -n kube-system --no-headers | wc -l | tr -d ' ' > "$HOME"/cp-pod-count.txt
