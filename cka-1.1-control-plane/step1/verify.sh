#!/bin/bash
FILE="/root/static-pods.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

MISSING=""
for comp in kube-apiserver kube-controller-manager kube-scheduler etcd; do
  grep -q "$comp" "$FILE" || MISSING="$MISSING $comp"
done

if [ -n "$MISSING" ]; then
  echo "FAIL: Missing components in file: $MISSING"
  exit 1
fi

echo "PASS: All 4 control plane components found in manifests directory"
exit 0