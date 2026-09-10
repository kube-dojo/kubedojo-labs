#!/bin/bash
# Verify: tree installed and actually run against the practice directory.
if ! dpkg -s tree 2>/dev/null | grep -q '^Status:.*installed'; then
  echo "FAIL: tree is not installed — install it with 'sudo apt install tree'"
  exit 1
fi
FILE=/tmp/kd-pkg/tree-output.txt
if [ ! -s "$FILE" ]; then
  echo "FAIL: $FILE missing — save the outline with 'tree ~/kubedojo-practice > /tmp/kd-pkg/tree-output.txt'"
  exit 1
fi
for item in recipes bruschetta.txt tiramisu.txt pasta-carbonara.txt; do
  if ! grep -q "$item" "$FILE"; then
    echo "FAIL: $FILE does not show '$item' — run tree against ~/kubedojo-practice, not another directory"
    exit 1
  fi
done
echo "PASS: tree installed and the practice directory mapped"
exit 0
