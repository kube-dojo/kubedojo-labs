#!/bin/bash
if id 'ubuntu' &>/dev/null; then USER_HOME='/home/ubuntu'; else USER_HOME='/root'; fi
#!/bin/bash
TARGET_FILE="$USER_HOME/names.txt"
SAMPLE_JSON="$USER_HOME/sample.json"

if [ ! -f "$TARGET_FILE" ]; then
  echo "FAIL: $TARGET_FILE does not exist"
  exit 1
fi

# Get the count of names in the sample JSON
EXPECTED_COUNT=$(jq '.items | length' "$SAMPLE_JSON")
# Get the count of names in the output file
ACTUAL_COUNT=$(wc -l < "$TARGET_FILE" | tr -d ' ')

if [ "$ACTUAL_COUNT" -ne "$EXPECTED_COUNT" ]; then
  echo "FAIL: names.txt should have $EXPECTED_COUNT lines (found $ACTUAL_COUNT)"
  exit 1
fi

# Verify Alice exists (she is definitely in sample.json)
if ! grep -q "alice" "$TARGET_FILE"; then
  echo "FAIL: names.txt is missing expected data (e.g., 'alice')"
  exit 1
fi

echo "PASS: names.txt verified with correct data count and content"
exit 0
