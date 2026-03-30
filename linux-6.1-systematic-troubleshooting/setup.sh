#!/bin/bash
# Setup: Create a failing service and seed some error logs
apt-get update -qq
apt-get install -y -qq systemd > /dev/null 2>&1

# Create a deliberately failing service
cat > /etc/systemd/system/broken-app.service << 'EOF'
[Unit]
Description=Broken Application Service

[Service]
ExecStart=/usr/local/bin/broken-app
Restart=no

[Install]
WantedBy=multi-user.target
EOF

# The binary doesn't exist, so the service will fail
systemctl daemon-reload
systemctl start broken-app.service 2>/dev/null || true

# Seed some error logs
logger -p user.err "ERROR: Database connection timeout after 30s"
logger -p user.crit "CRITICAL: Disk /dev/sda1 read-only filesystem detected"
logger -p user.err "ERROR: Failed to bind to port 8080 - address already in use"
logger -p user.err "ERROR: Authentication failed for user admin"
logger -p user.err "ERROR: Out of memory allocating 256MB buffer"

echo "Setup complete."
