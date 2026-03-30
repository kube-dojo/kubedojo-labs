#!/bin/bash
if ! kubectl get pod nonroot-pod -n secctx-lab &>/dev/null; then
  echo "FAIL: Pod nonroot-pod not found"
  exit 1
fi
NONROOT=$(kubectl get pod nonroot-pod -n secctx-lab -o jsonpath='{.spec.securityContext.runAsNonRoot}')
if [ "$NONROOT" != "true" ]; then
  echo "FAIL: nonroot-pod should have runAsNonRoot=true"
  exit 1
fi
for f in nonroot-id.txt root-fail.txt fixed-pod.yaml; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
