#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
SCRIPT="$USER_HOME/create-files.sh"
DIR="$USER_HOME/timed"

if [ ! -f "$SCRIPT" ]; then
  echo "FAIL: $SCRIPT does not exist"
  exit 1
fi

if [ ! -x "$SCRIPT" ]; then
  echo "FAIL: $SCRIPT is not executable"
  exit 1
fi

if [ ! -d "$DIR" ]; then
  echo "FAIL: Directory $DIR was not created"
  exit 1
fi

for i in 1 2 3 4 5; do
  FILE="$DIR/test-${i}.txt"
  if [ ! -f "$FILE" ]; then
    echo "FAIL: $FILE missing"
    exit 1
  fi
  CONTENT=$(cat "$FILE")
  if [ "$CONTENT" != "file $i" ]; then
    echo "FAIL: $FILE content is wrong. Expected 'file $i', got '$CONTENT'"
    exit 1
  fi
done

echo "PASS: Script verified, directory exists, and all 5 files have correct content"
exit 0
