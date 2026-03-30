#!/bin/bash
for f in test-pod.yaml kubesec-results.json secure-pod.yaml kubesec-secure.json; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
if ! grep -q "runAsNonRoot" /root/secure-pod.yaml; then
  echo "FAIL: secure-pod.yaml missing runAsNonRoot"
  exit 1
fi
if ! grep -q "readOnlyRootFilesystem" /root/secure-pod.yaml; then
  echo "FAIL: secure-pod.yaml missing readOnlyRootFilesystem"
  exit 1
fi
echo "PASS"
exit 0
