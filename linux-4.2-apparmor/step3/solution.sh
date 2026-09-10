#!/bin/bash
# Ensure profile is loaded
sudo apparmor_parser -r /etc/apparmor.d/usr.bin.curl 2>/dev/null || true

# Switch to enforce mode
sudo aa-enforce /etc/apparmor.d/usr.bin.curl 2>/dev/null || true

# Verify
sudo aa-status 2>/dev/null | grep -i curl
