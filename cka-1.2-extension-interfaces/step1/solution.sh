#!/bin/bash
kubectl get nodes -o jsonpath='{.items[0].status.nodeInfo.containerRuntimeVersion}' > "$HOME"/container-runtime.txt
echo "Container runtime:"
cat "$HOME"/container-runtime.txt
