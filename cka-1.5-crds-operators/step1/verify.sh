#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/crd-count.txt ]; then
  echo "FAIL: $USER_HOME/crd-count.txt does not exist"
  exit 1
fi

COUNT=$(cat $USER_HOME/crd-count.txt | tr -d '[:space:]')
if [[ "$COUNT" =~ ^[0-9]+$ ]]; then
  echo "PASS: File contains a number: $COUNT"
  exit 0
else
  echo "FAIL: File should contain a number, got: $COUNT"
  exit 1
fi
