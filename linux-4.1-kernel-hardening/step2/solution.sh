#!/bin/bash
sudo tee /etc/modprobe.d/blacklist-custom.conf > /dev/null << 'EOF'
# Blacklist USB storage to prevent data exfiltration
blacklist usb-storage
EOF
