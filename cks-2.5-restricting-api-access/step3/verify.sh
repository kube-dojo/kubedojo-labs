#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
for f in rate-limits.txt rate-limit-docs.txt event-rate-limit.txt api-hardening-summary.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
LINES=$(wc -l < $USER_HOME/api-hardening-summary.txt | tr -d ' ')
if [ "$LINES" -lt 6 ]; then
  echo "FAIL: Expected at least 6 hardening items"
  exit 1
fi
echo "PASS"
exit 0
