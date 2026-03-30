#!/bin/bash
kubectl logs crasher -n debug-lab
echo "exit 1" > /root/crash-reason.txt
kubectl delete pod crasher -n debug-lab --grace-period=0 --force
kubectl run crasher --image=busybox:1.36 -n debug-lab -- sh -c "echo running; sleep 3600"
kubectl wait --for=condition=Ready pod/crasher -n debug-lab --timeout=60s
