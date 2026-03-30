#!/bin/bash
# Ensure scheduler manifest is in place
cp /root/kube-scheduler-backup.yaml /etc/kubernetes/manifests/kube-scheduler.yaml 2>/dev/null
sleep 15
# Create test pod if not exists
kubectl run scheduler-test --image=nginx:1.25 -n practice 2>/dev/null || true
kubectl wait --for=condition=Ready pod/scheduler-test -n practice --timeout=60s
kubectl get pod scheduler-test -n practice
