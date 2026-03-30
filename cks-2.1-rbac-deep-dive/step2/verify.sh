#!/bin/bash
if ! kubectl get rolebinding deployer-binding -n rbac-lab &>/dev/null; then
  echo "FAIL: RoleBinding deployer-binding not found"
  exit 1
fi
if ! kubectl get rolebinding log-viewer-binding -n rbac-lab &>/dev/null; then
  echo "FAIL: RoleBinding log-viewer-binding not found"
  exit 1
fi
if ! kubectl get clusterrolebinding node-viewer-binding &>/dev/null; then
  echo "FAIL: ClusterRoleBinding node-viewer-binding not found"
  exit 1
fi
CAN_DEPLOY=$(kubectl auth can-i create deployments -n rbac-lab --as=system:serviceaccount:rbac-lab:app-deployer 2>&1)
if [ "$CAN_DEPLOY" != "yes" ]; then
  echo "FAIL: app-deployer should be able to create deployments"
  exit 1
fi
if [ ! -f /root/permission-check.txt ] || [ ! -s /root/permission-check.txt ]; then
  echo "FAIL: /root/permission-check.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
