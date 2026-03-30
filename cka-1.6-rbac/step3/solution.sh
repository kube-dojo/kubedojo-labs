#!/bin/bash
kubectl auth can-i get pods --as=system:serviceaccount:rbac-test:default -n rbac-test > /root/can-i-result.txt 2>&1
echo "Can default SA get pods in rbac-test?"
cat /root/can-i-result.txt
