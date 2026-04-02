#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
# Verify boot parameters analysis

if [ ! -f $USER_HOME/boot-params.txt ]; then
  echo "FAIL: $USER_HOME/boot-params.txt does not exist"
  exit 1
fi

# Check the file has meaningful content (at least a few lines)
LINES=$(wc -l < $USER_HOME/boot-params.txt)
if [ "$LINES" -lt 2 ]; then
  echo "FAIL: $USER_HOME/boot-params.txt has too little content ($LINES lines)"
  exit 1
fi

echo "PASS: Boot parameters analysis saved to $USER_HOME/boot-params.txt"
exit 0
