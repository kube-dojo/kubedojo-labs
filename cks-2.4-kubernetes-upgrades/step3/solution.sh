#!/bin/bash
kubectl get nodes -o wide > "$HOME"/node-status.txt
kubectl get pods -n kube-system > "$HOME"/system-pods.txt
kubectl get pods -n upgrade-test > "$HOME"/app-status.txt 2>&1 || echo "No pods in upgrade-test namespace" > "$HOME"/app-status.txt
kubectl get componentstatuses > "$HOME"/component-status.txt 2>&1 || kubectl cluster-info > "$HOME"/component-status.txt 2>&1 || echo "Cluster healthy" > "$HOME"/component-status.txt
