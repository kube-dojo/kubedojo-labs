#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -x $USER_HOME/immutability-audit.sh ]; then
  echo "FAIL: $USER_HOME/immutability-audit.sh not found or not executable"
  exit 1
fi
for f in immutability-report.txt immutability-best-practices.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
LINES=$(wc -l < $USER_HOME/immutability-best-practices.txt | tr -d ' ')
if [ "$LINES" -lt 5 ]; then
  echo "FAIL: Expected at least 5 best practices"
  exit 1
fi
echo "PASS"
exit 0
