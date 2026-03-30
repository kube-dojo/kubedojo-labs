#!/bin/bash
# Solution: Start and enable nginx
if systemctl start nginx 2>/dev/null; then
  systemctl enable nginx 2>/dev/null || true
  systemctl is-active nginx
else
  # Docker fallback: start nginx directly
  nginx 2>/dev/null || true
fi
