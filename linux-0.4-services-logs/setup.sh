#!/bin/bash
# Setup for services & logs lab: nginx installed but stopped (step 1 starts it).
export DEBIAN_FRONTEND=noninteractive
if ! command -v nginx > /dev/null 2>&1; then
  apt-get update -qq > /dev/null 2>&1
  apt-get install -y -qq nginx > /dev/null 2>&1
fi
systemctl stop nginx 2>/dev/null || true
pkill nginx 2>/dev/null || true
# Step 3 expects this script to exist (text.md: "A script already exists at
# /opt/myservice/run.sh").
mkdir -p /opt/myservice
cat > /opt/myservice/run.sh << 'EOF'
#!/bin/bash
while true; do
  echo "myservice heartbeat $(date)"
  sleep 30
done
EOF
chmod +x /opt/myservice/run.sh
echo "Setup complete."
