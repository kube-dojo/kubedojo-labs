#!/bin/bash
kubectl get nodes -o jsonpath='{.items[0].status.nodeInfo.containerRuntimeVersion}' > /root/container-runtime.txt
echo "Container runtime:"
cat /root/container-runtime.txt
