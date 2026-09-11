#!/bin/bash
kubectl get clusterrolebindings -o wide | grep kubernetes-dashboard > "$HOME"/dashboard-bindings.txt
ADMIN=$(kubectl auth can-i get secrets --all-namespaces --as=system:serviceaccount:kubernetes-dashboard:dashboard-admin 2>&1)
READONLY=$(kubectl auth can-i get secrets --all-namespaces --as=system:serviceaccount:kubernetes-dashboard:dashboard-readonly 2>&1)
cat > "$HOME"/rbac-comparison.txt << COMPARE
dashboard-admin: $ADMIN
dashboard-readonly: $READONLY
COMPARE
kubectl delete clusterrolebinding dashboard-admin-binding
kubectl get clusterrolebindings -o wide | grep kubernetes-dashboard > "$HOME"/final-bindings.txt 2>&1 || echo "No dashboard bindings with cluster-admin" > "$HOME"/final-bindings.txt
