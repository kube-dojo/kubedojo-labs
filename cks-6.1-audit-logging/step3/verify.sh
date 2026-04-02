#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -x $USER_HOME/audit-analyzer.sh ]; then
  echo "FAIL: $USER_HOME/audit-analyzer.sh not found or not executable"
  exit 1
fi
for f in audit-analysis.txt suspicious-patterns.txt; do
  if [ ! -f "$USER_HOME/$f" ] || [ ! -s "$USER_HOME/$f" ]; then
    echo "FAIL: $USER_HOME/$f missing or empty"
    exit 1
  fi
done
echo "PASS"
exit 0
