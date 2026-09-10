#!/bin/bash
# Solution: Create safe-script.sh
cat > "$HOME"/safe-script.sh << 'SCRIPT'
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
chmod +x "$HOME"/safe-script.sh
"$HOME"/safe-script.sh
