#!/bin/bash
# Solution: Create API check script
cat > /root/api-check.sh << 'SCRIPT'
#!/bin/bash
set -euo pipefail

RESPONSE=$(curl -s http://localhost:8080/)

STATUS=$(echo "$RESPONSE" | jq -r '.status')
VERSION=$(echo "$RESPONSE" | jq -r '.version')
DB=$(echo "$RESPONSE" | jq -r '.services.database')
CACHE=$(echo "$RESPONSE" | jq -r '.services.cache')
QUEUE=$(echo "$RESPONSE" | jq -r '.services.queue')

echo "Status: $STATUS"
echo "Version: $VERSION"
echo "Database: $DB"
echo "Cache: $CACHE"
echo "Queue: $QUEUE"
SCRIPT
chmod +x /root/api-check.sh
/root/api-check.sh
