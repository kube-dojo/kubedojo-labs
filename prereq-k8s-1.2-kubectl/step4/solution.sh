#!/bin/bash
kubectl run nginx --image=nginx:1.25 --dry-run=client -o yaml > "$HOME"/nginx-pod.yaml
