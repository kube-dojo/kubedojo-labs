#!/bin/bash
kubectl create role restricted-role-creator --verb=create,get,list --resource=roles,rolebindings -n rbac-lab
kubectl create role safe-role-creator --verb=get,list --resource=roles,rolebindings -n rbac-lab

kubectl auth can-i create roles -n rbac-lab --as=system:serviceaccount:rbac-lab:secret-admin > /root/escalation-check.txt 2>&1

cat > /root/escalation-prevention.txt << 'PREVENT'
1. Never grant create/update on roles and rolebindings together - this allows self-escalation
2. Use the escalate verb restriction - Kubernetes prevents creating roles with more permissions than you have
3. Avoid wildcard (*) verbs and resources - always specify exact permissions needed
4. Regular RBAC audits to detect drift and new over-privileged accounts
PREVENT
