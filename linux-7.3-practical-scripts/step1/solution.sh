#!/bin/bash
# Solution: Create backup script
cat > /root/backup.sh << 'SCRIPT'
#!/bin/bash
set -euo pipefail

BACKUP_DIR="/root/backups"
DATE=$(date +%Y%m%d)
FILENAME="etc-${DATE}.tar.gz"
FILEPATH="${BACKUP_DIR}/${FILENAME}"

mkdir -p "$BACKUP_DIR"

echo "Creating backup of /etc..."
tar -czf "$FILEPATH" /etc 2>/dev/null

SIZE=$(ls -lh "$FILEPATH" | awk '{print $5}')
echo "Backup complete: $FILEPATH ($SIZE)"
SCRIPT
chmod +x /root/backup.sh
/root/backup.sh
