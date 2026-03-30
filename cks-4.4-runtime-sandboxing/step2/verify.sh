#!/bin/bash
if ! kubectl get runtimeclass gvisor &>/dev/null; then
  echo "FAIL: RuntimeClass gvisor not found"
  exit 1
fi
if ! kubectl get runtimeclass kata &>/dev/null; then
  echo "FAIL: RuntimeClass kata not found"
  exit 1
fi
if [ ! -f /root/sandboxed-pod.yaml ] || [ ! -s /root/sandboxed-pod.yaml ]; then
  echo "FAIL: /root/sandboxed-pod.yaml missing or empty"
  exit 1
fi
if ! grep -q "runtimeClassName" /root/sandboxed-pod.yaml; then
  echo "FAIL: sandboxed-pod.yaml should reference runtimeClassName"
  exit 1
fi
echo "PASS"
exit 0
