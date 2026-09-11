#!/bin/bash
kubectl get pods -n kube-system > "$HOME"/kube-system-pods.txt
