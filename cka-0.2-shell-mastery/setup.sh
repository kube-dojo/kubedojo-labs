#!/bin/bash
# Install jq and tmux
apt-get update -qq && apt-get install -y -qq jq tmux > /dev/null 2>&1

# Create sample JSON for step 2
mkdir -p /root
cat > /root/sample.json << 'JSONEOF'
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

echo "Environment ready!"
