#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for f in all-service-accounts.txt sa-permissions.txt legacy-tokens.txt sa-hardening.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
LINES=$(wc -l < $USER_HOME/sa-hardening.txt | tr -d ' ')
if [ "$LINES" -lt 4 ]; then
  echo "FAIL: Expected at least 4 best practices"
  exit 1
fi
echo "PASS"
exit 0
