#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for f in admin-roles.txt service-accounts.txt psa-status.txt security-baseline.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
if ! grep -qiE "enabled|disabled" $USER_HOME/psa-status.txt; then
  echo "FAIL: psa-status.txt should say enabled or disabled"
  exit 1
fi
echo "PASS"
exit 0
