#!/bin/bash
# Solution: Create safe-script.sh
cat > /root/safe-script.sh << 'SCRIPT'
#!/bin/bash
set -euo pipefail

TMPFILE=$(mktemp /tmp/safe-script-XXXXXX.tmp)

function cleanup() {
  echo "Cleaning up: removing $TMPFILE"
  rm -f "$TMPFILE"
}

trap cleanup EXIT

echo "Working with temp file: $TMPFILE"
echo "Some important data" > "$TMPFILE"
cat "$TMPFILE"
echo "Script completed successfully."
SCRIPT
chmod +x /root/safe-script.sh
/root/safe-script.sh
