#!/bin/bash
# Verify: package metadata and dependency views captured for htop.
META=/tmp/kd-pkg/htop-metadata.txt
DEPS=/tmp/kd-pkg/htop-depends.txt
if [ ! -s "$META" ]; then
  echo "FAIL: $META missing — save it with 'apt show htop > /tmp/kd-pkg/htop-metadata.txt'"
  exit 1
fi
if ! grep -q '^Package: htop' "$META" || ! grep -q '^Version:' "$META"; then
  echo "FAIL: $META does not look like 'apt show htop' output (needs Package: and Version: fields)"
  exit 1
fi
if [ ! -s "$DEPS" ]; then
  echo "FAIL: $DEPS missing — save it with 'apt-cache depends htop > /tmp/kd-pkg/htop-depends.txt'"
  exit 1
fi
if ! head -n1 "$DEPS" | grep -q '^htop$' || ! grep -qi 'Depends:' "$DEPS"; then
  echo "FAIL: $DEPS does not look like 'apt-cache depends htop' output"
  exit 1
fi
echo "PASS: metadata and dependencies captured — you can now explain what an install brings in"
exit 0
