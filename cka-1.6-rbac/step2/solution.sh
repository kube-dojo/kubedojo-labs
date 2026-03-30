#!/bin/bash
kubectl create clusterrole node-viewer --verb=get --verb=list --resource=nodes
echo ""
echo "ClusterRole created:"
kubectl describe clusterrole node-viewer
