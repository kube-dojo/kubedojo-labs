#!/bin/bash
# Install jq and tmux
apt-get update -qq && apt-get install -y -qq jq tmux > /dev/null 2>&1

# Create sample JSON for step 2 (each learner home).
_SAMPLE=$(mktemp)
cat > "$_SAMPLE" << 'JSONEOF'
{
  "items": [
    {"name": "alice", "role": "admin", "age": 30},
    {"name": "bob", "role": "developer", "age": 25},
    {"name": "charlie", "role": "admin", "age": 35},
    {"name": "diana", "role": "developer", "age": 28},
    {"name": "eve", "role": "sre", "age": 32}
  ]
}
JSONEOF
for home in /root /home/ubuntu; do
  [ -d "$home" ] || continue
  cp "$_SAMPLE" "$home/sample.json"
done
rm -f "$_SAMPLE"

echo "Environment ready!"

if [ -d /home/ubuntu ]; then
  chown -R ubuntu:ubuntu /home/ubuntu/ 2>/dev/null || true
fi
