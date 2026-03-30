#!/bin/bash
kubectl create role deployer --verb=get,list,watch,create,update,patch --resource=deployments -n rbac-lab
kubectl patch role deployer -n rbac-lab --type='json' -p='[{"op":"add","path":"/rules/-","value":{"apiGroups":[""],"resources":["pods","services"],"verbs":["get","list"]}}]'
kubectl create role log-viewer --verb=get,list --resource=pods --resource=pods/log -n rbac-lab
kubectl create clusterrole node-viewer --verb=get,list,watch --resource=nodes
{
  kubectl get role deployer -n rbac-lab -o yaml
  echo "---"
  kubectl get role log-viewer -n rbac-lab -o yaml
  echo "---"
  kubectl get clusterrole node-viewer -o yaml
} > /root/roles.yaml
