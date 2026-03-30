#!/bin/bash
if [ ! -f /root/container-runtime.txt ]; then
  echo "FAIL: /root/container-runtime.txt does not exist"
  exit 1
fi

CONTENT=$(cat /root/container-runtime.txt | tr '[:upper:]' '[:lower:]')
if echo "$CONTENT" | grep -qE "containerd|cri-o|crio"; then
  echo "PASS: File identifies a container runtime"
  exit 0
else
  echo "FAIL: File should contain 'containerd' or 'cri-o', got: $CONTENT"
  exit 1
fi
