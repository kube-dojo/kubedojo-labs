#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/alert-rules.txt ] || [ ! -s $USER_HOME/alert-rules.txt ]; then
  echo "FAIL: $USER_HOME/alert-rules.txt missing or empty"
  exit 1
fi
if ! grep -c "RULE:" $USER_HOME/alert-rules.txt | grep -q '[5-9]\|[1-9][0-9]'; then
  echo "FAIL: Expected at least 5 alert rules"
  exit 1
fi
if [ ! -x $USER_HOME/check-secrets-access.sh ]; then
  echo "FAIL: $USER_HOME/check-secrets-access.sh not found or not executable"
  exit 1
fi
if [ ! -f $USER_HOME/secrets-access-report.txt ] || [ ! -s $USER_HOME/secrets-access-report.txt ]; then
  echo "FAIL: $USER_HOME/secrets-access-report.txt missing or empty"
  exit 1
fi
echo "PASS"
exit 0
