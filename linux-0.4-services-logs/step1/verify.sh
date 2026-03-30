#!/bin/bash
# Verify nginx is active
if systemctl is-active --quiet nginx 2>/dev/null; then
  echo "nginx is running!"
  exit 0
fi

# Docker fallback: check if nginx process is running
if pgrep -x nginx > /dev/null 2>&1; then
  echo "nginx is running! (detected via process)"
  exit 0
fi

echo "nginx is not running. Start it with: systemctl start nginx"
exit 1
