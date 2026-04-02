#!/bin/bash
FILE="/root/cni-plugin.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

CONTENT=$(cat "$FILE" | tr -d '[:space:]')
# Kind uses kindnet, usually 10-kindnet.conflist or similar
if echo "$CONTENT" | grep -qE "kindnet|calico|flannel|cilium|weave|antrea"; then
  echo "PASS: CNI plugin identified: $CONTENT"
  exit 0
else
  echo "FAIL: File does not contain a recognized CNI plugin name"
  exit 1
fi