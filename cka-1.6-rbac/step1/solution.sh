#!/bin/bash
kubectl create role pod-reader --verb=get --verb=list --resource=pods -n rbac-test
echo ""
echo "Role created:"
kubectl describe role pod-reader -n rbac-test
