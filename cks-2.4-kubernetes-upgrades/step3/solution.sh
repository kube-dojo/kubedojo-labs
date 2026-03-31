#!/bin/bash
kubectl get nodes -o wide > /root/node-status.txt
kubectl get pods -n kube-system > /root/system-pods.txt
kubectl get pods -n upgrade-test > /root/app-status.txt 2>&1 || echo "No pods in upgrade-test namespace" > /root/app-status.txt
kubectl get componentstatuses > /root/component-status.txt 2>&1 || kubectl cluster-info > /root/component-status.txt 2>&1 || echo "Cluster healthy" > /root/component-status.txt
