#!/bin/bash
kubectl get clusterrolebindings -o wide | grep kubernetes-dashboard > /root/dashboard-bindings.txt
ADMIN=$(kubectl auth can-i get secrets --all-namespaces --as=system:serviceaccount:kubernetes-dashboard:dashboard-admin 2>&1)
READONLY=$(kubectl auth can-i get secrets --all-namespaces --as=system:serviceaccount:kubernetes-dashboard:dashboard-readonly 2>&1)
cat > /root/rbac-comparison.txt << COMPARE
dashboard-admin: $ADMIN
dashboard-readonly: $READONLY
COMPARE
kubectl delete clusterrolebinding dashboard-admin-binding
kubectl get clusterrolebindings -o wide | grep kubernetes-dashboard > /root/final-bindings.txt 2>&1 || echo "No dashboard bindings with cluster-admin" > /root/final-bindings.txt
