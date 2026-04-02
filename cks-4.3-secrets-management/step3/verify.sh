#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get role secret-reader -n secrets-lab &>/dev/null; then
  echo "FAIL: Role secret-reader not found"
  exit 1
fi
if ! kubectl get sa app-sa -n secrets-lab &>/dev/null; then
  echo "FAIL: ServiceAccount app-sa not found"
  exit 1
fi
CAN_GET=$(kubectl auth can-i get secrets -n secrets-lab --as=system:serviceaccount:secrets-lab:app-sa 2>&1)
if [ "$CAN_GET" != "yes" ]; then
  echo "FAIL: app-sa should be able to get secrets"
  exit 1
fi
CAN_LIST=$(kubectl auth can-i list secrets -n secrets-lab --as=system:serviceaccount:secrets-lab:app-sa 2>&1)
if [ "$CAN_LIST" == "yes" ]; then
  echo "FAIL: app-sa should NOT be able to list secrets"
  exit 1
fi
for f in secret-rbac-test.txt secrets-best-practices.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
