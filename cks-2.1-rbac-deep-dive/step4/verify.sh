#!/bin/bash
if ! kubectl get role restricted-role-creator -n rbac-lab &>/dev/null; then
  echo "FAIL: Role restricted-role-creator not found"
  exit 1
fi
if ! kubectl get role safe-role-creator -n rbac-lab &>/dev/null; then
  echo "FAIL: Role safe-role-creator not found"
  exit 1
fi
# Verify safe-role-creator doesn't allow create
VERBS=$(kubectl get role safe-role-creator -n rbac-lab -o jsonpath='{.rules[*].verbs[*]}')
if echo "$VERBS" | grep -q "create"; then
  echo "FAIL: safe-role-creator should not allow create"
  exit 1
fi
for f in escalation-check.txt escalation-prevention.txt; do
  if [ ! -f "/root/$f" ] || [ ! -s "/root/$f" ]; then
    echo "FAIL: /root/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
