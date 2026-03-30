#!/bin/bash
# Solution: Create backup rotation script

# First create dummy backups for testing
for i in $(seq 1 8); do
  touch "/root/backups/backup-2026030${i}.tar.gz"
  sleep 0.1
done

cat > /root/rotate-backups.sh << 'SCRIPT'
#!/bin/bash
set -euo pipefail

BACKUP_DIR="/root/backups"
KEEP=5

echo "=== Backup Rotation ==="
echo "Before rotation:"
ls -1t "$BACKUP_DIR"/backup-*.tar.gz 2>/dev/null | head -20

# Count current backups
COUNT=$(ls -1 "$BACKUP_DIR"/backup-*.tar.gz 2>/dev/null | wc -l)

if [ "$COUNT" -gt "$KEEP" ]; then
  DELETE=$((COUNT - KEEP))
  echo "Deleting $DELETE old backup(s)..."
  ls -1t "$BACKUP_DIR"/backup-*.tar.gz | tail -n +$((KEEP + 1)) | xargs rm -f
else
  echo "Only $COUNT backups, nothing to rotate."
fi

echo ""
echo "After rotation:"
ls -1t "$BACKUP_DIR"/backup-*.tar.gz 2>/dev/null
echo "Total: $(ls -1 "$BACKUP_DIR"/backup-*.tar.gz 2>/dev/null | wc -l) backups"
SCRIPT
chmod +x /root/rotate-backups.sh
/root/rotate-backups.sh
