#!/bin/bash
ROLE=$(kubectl get clusterrole node-viewer -o json 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "FAIL: ClusterRole node-viewer not found"
  exit 1
fi

VERBS=$(echo "$ROLE" | jq -r '.rules[0].verbs | join(",")')
RESOURCES=$(echo "$ROLE" | jq -r '.rules[0].resources | join(",")')

if echo "$VERBS" | grep -q "get" && echo "$VERBS" | grep -q "list" && echo "$RESOURCES" | grep -q "nodes"; then
  echo "PASS: ClusterRole node-viewer has correct permissions"
  exit 0
else
  echo "FAIL: ClusterRole found but permissions are incorrect. Expected get,list on nodes."
  exit 1
fi