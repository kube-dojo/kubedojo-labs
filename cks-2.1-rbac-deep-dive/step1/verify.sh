#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get role deployer -n rbac-lab &>/dev/null; then
  echo "FAIL: Role deployer not found"
  exit 1
fi
if ! kubectl get role log-viewer -n rbac-lab &>/dev/null; then
  echo "FAIL: Role log-viewer not found"
  exit 1
fi
if ! kubectl get clusterrole node-viewer &>/dev/null; then
  echo "FAIL: ClusterRole node-viewer not found"
  exit 1
fi
# Check deployer cannot access secrets
RULES=$(kubectl get role deployer -n rbac-lab -o jsonpath='{.rules[*].resources[*]}')
if echo "$RULES" | grep -q "secrets"; then
  echo "FAIL: deployer role should NOT have access to secrets"
  exit 1
fi
if [ ! -f $USER_HOME/roles.yaml ] || [ ! -s $USER_HOME/roles.yaml ]; then
  echo "FAIL: $USER_HOME/roles.yaml missing or empty"
  exit 1
fi
echo "PASS"
exit 0
