#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
FILE="$USER_HOME/bookmarks.txt"
if [ ! -f "$FILE" ]; then
  echo "FAIL: $FILE does not exist"
  exit 1
fi

MISSING=""
grep -q "workload-resources/pod-v1" "$FILE" || MISSING="$MISSING pod,"
grep -q "workload-resources/deployment-v1" "$FILE" || MISSING="$MISSING deployment,"
grep -q "concepts/services-networking/service" "$FILE" || MISSING="$MISSING service,"
grep -q "access-authn-authz/rbac" "$FILE" || MISSING="$MISSING rbac,"

if [ -n "$MISSING" ]; then
  echo "FAIL: Bookmarks file missing URLs for: $MISSING"
  exit 1
fi

echo "PASS: bookmarks.txt verified with all required URLs"
exit 0