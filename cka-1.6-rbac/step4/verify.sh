#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# 1. Check RoleBinding exists
BINDING=$(kubectl get rolebinding -n rbac-test -o json | jq -r '.items[] | select(.roleRef.name=="pod-reader")')
if [ -z "$BINDING" ]; then
  echo "FAIL: No RoleBinding found for role 'pod-reader' in rbac-test"
  exit 1
fi

# 2. Check ServiceAccount exists
if ! kubectl get sa deploy-bot -n rbac-test >/dev/null 2>&1; then
  echo "FAIL: ServiceAccount 'deploy-bot' not found"
  exit 1
fi

# 3. Final Functional Check
RESULT=$(kubectl auth can-i get pods --as=system:serviceaccount:rbac-test:deploy-bot -n rbac-test)
if [ "$RESULT" = "yes" ]; then
  echo "PASS: deploy-bot can get pods in rbac-test"
  exit 0
else
  echo "FAIL: deploy-bot still cannot get pods. Result: $RESULT"
  exit 1
fi