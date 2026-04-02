#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
ROLE=$(kubectl get role pod-reader -n rbac-test -o json 2>/dev/null)
if [ $? -ne 0 ]; then
  echo "FAIL: Role pod-reader not found in rbac-test namespace"
  exit 1
fi

# Verify rules
VERBS=$(echo "$ROLE" | jq -r '.rules[0].verbs | join(",")')
RESOURCES=$(echo "$ROLE" | jq -r '.rules[0].resources | join(",")')

if echo "$VERBS" | grep -q "get" && echo "$VERBS" | grep -q "list" && echo "$RESOURCES" | grep -q "pods"; then
  echo "PASS: Role pod-reader has correct permissions"
  exit 0
else
  echo "FAIL: Role found but permissions are incorrect. Expected get,list on pods."
  exit 1
fi