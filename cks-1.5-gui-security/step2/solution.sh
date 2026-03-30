#!/bin/bash
kubectl create clusterrole dashboard-viewer --verb=get,list,watch --resource=pods,deployments,services,namespaces,nodes
kubectl create clusterrolebinding dashboard-readonly-binding --clusterrole=dashboard-viewer --serviceaccount=kubernetes-dashboard:dashboard-readonly
kubectl auth can-i get secrets -n default --as=system:serviceaccount:kubernetes-dashboard:dashboard-readonly > /root/readonly-secrets-check.txt 2>&1
