#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
if [ ! -f $USER_HOME/word-freq.txt ]; then
  echo "FAIL: $USER_HOME/word-freq.txt not found"
  exit 1
fi

LINES=$(wc -l < $USER_HOME/word-freq.txt)
if [ "$LINES" -eq 10 ]; then
  echo "PASS: word-freq.txt has 10 lines"
  exit 0
else
  echo "FAIL: Expected 10 lines, got $LINES"
  exit 1
fi
