#!/bin/bash
kubectl create rolebinding deployer-binding --role=deployer --serviceaccount=rbac-lab:app-deployer -n rbac-lab
kubectl create rolebinding log-viewer-binding --role=log-viewer --serviceaccount=rbac-lab:log-reader -n rbac-lab
kubectl create clusterrolebinding node-viewer-binding --clusterrole=node-viewer --serviceaccount=rbac-lab:app-deployer
cat > /root/permission-check.txt << CHECKS
app-deployer - create deployments: $(kubectl auth can-i create deployments -n rbac-lab --as=system:serviceaccount:rbac-lab:app-deployer 2>&1)
app-deployer - get secrets: $(kubectl auth can-i get secrets -n rbac-lab --as=system:serviceaccount:rbac-lab:app-deployer 2>&1)
app-deployer - get nodes: $(kubectl auth can-i get nodes --as=system:serviceaccount:rbac-lab:app-deployer 2>&1)
log-reader - get pods/log: $(kubectl auth can-i get pods/log -n rbac-lab --as=system:serviceaccount:rbac-lab:log-reader 2>&1)
log-reader - create deployments: $(kubectl auth can-i create deployments -n rbac-lab --as=system:serviceaccount:rbac-lab:log-reader 2>&1)
CHECKS
