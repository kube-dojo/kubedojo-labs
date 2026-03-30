#!/bin/bash
cat > /etc/modprobe.d/blacklist-custom.conf << 'EOF'
# Blacklist USB storage to prevent data exfiltration
blacklist usb-storage
EOF
