#!/bin/bash
kubectl create serviceaccount dashboard-admin -n kubernetes-dashboard
kubectl create serviceaccount dashboard-readonly -n kubernetes-dashboard
kubectl create clusterrolebinding dashboard-admin-binding --clusterrole=cluster-admin --serviceaccount=kubernetes-dashboard:dashboard-admin
cat > /root/dashboard-risk.txt << 'RISKS'
Can read all secrets across all namespaces including credentials and tokens
Can delete any resource including namespaces, persistent volumes, and nodes
Can modify RBAC to escalate privileges for other accounts
Can exec into any pod to access sensitive data or pivot laterally
RISKS
