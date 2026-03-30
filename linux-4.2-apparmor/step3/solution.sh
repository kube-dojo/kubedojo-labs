#!/bin/bash
# Ensure profile is loaded
apparmor_parser -r /etc/apparmor.d/usr.bin.curl 2>/dev/null || true

# Switch to enforce mode
aa-enforce /etc/apparmor.d/usr.bin.curl 2>/dev/null || true

# Verify
aa-status 2>/dev/null | grep -i curl
