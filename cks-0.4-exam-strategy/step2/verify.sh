#!/bin/bash
if ! kubectl get role pod-reader -n exam-practice &>/dev/null; then
  echo "FAIL: Role pod-reader not found"
  exit 1
fi
if ! kubectl get rolebinding exam-sa-binding -n exam-practice &>/dev/null; then
  echo "FAIL: RoleBinding exam-sa-binding not found"
  exit 1
fi
if ! kubectl get networkpolicy deny-all -n exam-practice &>/dev/null; then
  echo "FAIL: NetworkPolicy deny-all not found"
  exit 1
fi
if [ ! -f /root/rbac-check.txt ] || [ ! -s /root/rbac-check.txt ]; then
  echo "FAIL: /root/rbac-check.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
