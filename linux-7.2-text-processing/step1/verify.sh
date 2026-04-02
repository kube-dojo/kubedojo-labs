#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/awk-sum.txt ]; then
  echo "FAIL: $USER_HOME/awk-sum.txt not found"
  exit 1
fi

VALUE=$(cat $USER_HOME/awk-sum.txt | tr -d '[:space:]')
if [[ "$VALUE" =~ ^[0-9]+$ ]] && [ "$VALUE" -gt 0 ]; then
  echo "PASS: awk-sum.txt contains a number: $VALUE"
  exit 0
else
  echo "FAIL: Expected a positive number, got '$VALUE'"
  exit 1
fi
