#!/bin/bash
# Solution: Create backup script
cat > "$HOME"/backup.sh << 'SCRIPT'
#!/bin/bash
set -euo pipefail

BACKUP_DIR="$HOME/backups"
DATE=$(date +%Y%m%d)
FILENAME="etc-${DATE}.tar.gz"
FILEPATH="${BACKUP_DIR}/${FILENAME}"

mkdir -p "$BACKUP_DIR"

echo "Creating backup of /etc..."
sudo tar -czf "$FILEPATH" /etc 2>/dev/null

SIZE=$(ls -lh "$FILEPATH" | awk '{print $5}')
echo "Backup complete: $FILEPATH ($SIZE)"
SCRIPT
chmod +x "$HOME"/backup.sh
"$HOME"/backup.sh
