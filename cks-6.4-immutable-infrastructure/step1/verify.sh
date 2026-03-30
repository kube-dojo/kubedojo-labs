#!/bin/bash
if ! kubectl get pod immutable-nginx -n immutable-lab &>/dev/null; then
  echo "FAIL: Pod immutable-nginx not found"
  exit 1
fi
READONLY=$(kubectl get pod immutable-nginx -n immutable-lab -o jsonpath='{.spec.containers[0].securityContext.readOnlyRootFilesystem}')
if [ "$READONLY" != "true" ]; then
  echo "FAIL: readOnlyRootFilesystem should be true"
  exit 1
fi
for f in immutable-test.txt write-denied.txt tmp-write.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
