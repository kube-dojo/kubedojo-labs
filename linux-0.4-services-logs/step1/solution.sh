#!/bin/bash
# Solution: Start and enable nginx
if sudo systemctl start nginx 2>/dev/null; then
  sudo systemctl enable nginx 2>/dev/null || true
  systemctl is-active nginx
else
  # Docker fallback: start nginx directly
  sudo nginx 2>/dev/null || true
fi
