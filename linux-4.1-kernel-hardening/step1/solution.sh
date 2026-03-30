#!/bin/bash
cat > /etc/sysctl.d/99-hardening.conf << 'EOF'
net.ipv4.ip_forward = 0
net.ipv4.tcp_syncookies = 1
net.ipv4.conf.all.accept_redirects = 0
EOF

# Apply settings — may fail in Docker (read-only /proc/sys), that's OK
sysctl -p /etc/sysctl.d/99-hardening.conf 2>/dev/null || echo "Note: sysctl -p failed (likely Docker — kernel params are read-only). Config file is correct."
