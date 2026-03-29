#!/bin/bash
# Verify node name file exists and contains a valid node name
[ -f /root/node-name.txt ] || exit 1
NODE_NAME=$(cat /root/node-name.txt | tr -d '[:space:]')
[ -z "$NODE_NAME" ] && exit 1
# Check that the name matches an actual node in the cluster
kubectl get node "$NODE_NAME" > /dev/null 2>&1 || exit 1
exit 0
