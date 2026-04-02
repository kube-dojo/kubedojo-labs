#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if ! kubectl get sa limited-user &>/dev/null; then
  echo "FAIL: ServiceAccount limited-user not found"
  exit 1
fi
for f in anon-access.txt auth-access.txt sa-access.txt access-comparison.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
