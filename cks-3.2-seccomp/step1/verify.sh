#!/bin/bash
if ! kubectl get pod seccomp-default -n seccomp-lab &>/dev/null; then
  echo "FAIL: Pod seccomp-default not found"
  exit 1
fi
if ! kubectl get pod seccomp-unconfined -n seccomp-lab &>/dev/null; then
  echo "FAIL: Pod seccomp-unconfined not found"
  exit 1
fi
PROFILE=$(kubectl get pod seccomp-default -n seccomp-lab -o jsonpath='{.spec.securityContext.seccompProfile.type}')
if [ "$PROFILE" != "RuntimeDefault" ]; then
  echo "FAIL: seccomp-default should use RuntimeDefault profile"
  exit 1
fi
for f in seccomp-types.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
