#!/bin/bash
kubectl run nginx --image=nginx --dry-run=client -o yaml > "$HOME"/nginx-pod.yaml
