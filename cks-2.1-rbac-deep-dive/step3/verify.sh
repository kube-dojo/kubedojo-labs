#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for f in cluster-admin-bindings.txt overprivileged-sa.txt secret-admin-audit.txt rbac-risks.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
RISKS=$(wc -l < $USER_HOME/rbac-risks.txt | tr -d ' ')
if [ "$RISKS" -lt 3 ]; then
  echo "FAIL: Expected at least 3 RBAC risks"
  exit 1
fi
echo "PASS"
exit 0
