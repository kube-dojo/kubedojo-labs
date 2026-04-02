#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if kubectl get clusterrolebinding dashboard-admin-binding &>/dev/null; then
  echo "FAIL: dashboard-admin-binding should be deleted"
  exit 1
fi
for f in dashboard-bindings.txt rbac-comparison.txt final-bindings.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
