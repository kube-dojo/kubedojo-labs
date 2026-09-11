#!/bin/bash
kubectl get pod web -o jsonpath='{.status.podIP}' > "$HOME"/web-pod-ip.txt
