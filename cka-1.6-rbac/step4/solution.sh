#!/bin/bash
# Create ServiceAccount
kubectl create serviceaccount deploy-bot -n rbac-test

# Bind pod-reader role to deploy-bot
kubectl create rolebinding deploy-bot-binding \
  --role=pod-reader \
  --serviceaccount=rbac-test:deploy-bot \
  -n rbac-test

# Verify access
echo "Can deploy-bot get pods?"
kubectl auth can-i get pods --as=system:serviceaccount:rbac-test:deploy-bot -n rbac-test
